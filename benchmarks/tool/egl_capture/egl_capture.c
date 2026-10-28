// SPDX-License-Identifier: MIT
// Optional benchmark-only capture of the real EGL backbuffer before swap.
#define _GNU_SOURCE
#include <EGL/egl.h>
#include <GLES2/gl2.h>
#include <dlfcn.h>
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <limits.h>
#include <link.h>
#include <pthread.h>
#include <stdatomic.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <unistd.h>
#include "sha256_file.h"

#ifndef GL_READ_FRAMEBUFFER_BINDING
#define GL_READ_FRAMEBUFFER_BINDING 0x8CAA
#endif
#ifndef GL_PIXEL_PACK_BUFFER_BINDING
#define GL_PIXEL_PACK_BUFFER_BINDING 0x88ED
#endif
#ifndef GL_PACK_ROW_LENGTH
#define GL_PACK_ROW_LENGTH 0x0D02
#endif
#ifndef GL_PACK_SKIP_ROWS
#define GL_PACK_SKIP_ROWS 0x0D04
#endif
#ifndef GL_PACK_SKIP_PIXELS
#define GL_PACK_SKIP_PIXELS 0x0D03
#endif
#ifndef GL_READ_BUFFER
#define GL_READ_BUFFER 0x0C02
#endif

#define CAPTURE_WIDTH 2560
#define CAPTURE_HEIGHT 1600
#define CAPTURE_STRIDE (CAPTURE_WIDTH * 4)
#define CAPTURE_BYTES ((size_t)CAPTURE_STRIDE * CAPTURE_HEIGHT)

typedef EGLBoolean (*swap_buffers_fn)(EGLDisplay, EGLSurface);
static swap_buffers_fn real_swap;
static pthread_once_t initialize_once = PTHREAD_ONCE_INIT;
static pthread_mutex_t capture_mutex = PTHREAD_MUTEX_INITIALIZER;
static atomic_uint_fast64_t swap_count;
static uint64_t last_request_id;
static int capture_dir = -1;
static bool loaded_runtime_ready;
static bool write_loaded_runtime(void);

struct capture_result {
    uint64_t id;
    uint64_t swap_index;
    bool barrier;
    bool raw_written;
    const char *error;
    int native_errno;
    GLenum gl_error;
    EGLint width;
    EGLint height;
    GLint framebuffer;
    GLint read_framebuffer;
    char filename[80];
};

static void initialize(void) {
    // ISO C does not define an object/function pointer conversion. POSIX dlsym
    // does; memcpy avoids an unnecessary pedantic cast diagnostic.
    void *symbol = dlsym(RTLD_NEXT, "eglSwapBuffers");
    memcpy(&real_swap, &symbol, sizeof real_swap);
    const char *directory = getenv("BENCHMARK_EGL_CAPTURE_DIR");
    char fallback[PATH_MAX];
    if (directory == NULL || directory[0] == '\0') {
        const char *output = getenv("BENCHMARK_OUTPUT");
        if (output == NULL || output[0] == '\0') return;
        int length = snprintf(fallback, sizeof fallback, "%s/egl-capture", output);
        if (length < 0 || (size_t)length >= sizeof fallback) {
            fprintf(stderr, "EGL_CAPTURE_ERROR initialization=capture_path_too_long\n");
            return;
        }
        directory = fallback;
    }
    if (mkdir(directory, 0700) != 0 && errno != EEXIST) {
        fprintf(stderr, "EGL_CAPTURE_ERROR initialization=mkdir errno=%d\n", errno);
        return;
    }
    capture_dir = open(directory, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
    if (capture_dir < 0) {
        fprintf(stderr, "EGL_CAPTURE_ERROR initialization=open_directory errno=%d\n", errno);
        return;
    }
    loaded_runtime_ready = write_loaded_runtime();
    if (!loaded_runtime_ready) {
        fprintf(stderr, "EGL_CAPTURE_ERROR initialization=loaded_runtime_metadata_failed errno=%d\n", errno);
    }
}

static bool write_all(int fd, const void *data, size_t length) {
    const unsigned char *cursor = data;
    while (length != 0) {
        ssize_t count = write(fd, cursor, length);
        if (count < 0 && errno == EINTR) continue;
        if (count <= 0) {
            if (count == 0) errno = EIO;
            return false;
        }
        cursor += count;
        length -= (size_t)count;
    }
    return true;
}

struct loaded_engine {
    char path[PATH_MAX];
    uintptr_t address;
    bool found;
    bool ambiguous;
};

static int locate_engine(struct dl_phdr_info *info, size_t size, void *userdata) {
    (void)size;
    struct loaded_engine *engine = userdata;
    const char *name = strrchr(info->dlpi_name, '/');
    name = name == NULL ? info->dlpi_name : name + 1;
    static const char prefix[] = "libflutter_engine.so";
    size_t length = sizeof prefix - 1;
    if (strncmp(name, prefix, length) != 0 || (name[length] != '\0' && name[length] != '.')) return 0;
    if (engine->found) { engine->ambiguous = true; return 1; }
    if (strlen(info->dlpi_name) >= sizeof engine->path) { engine->ambiguous = true; return 1; }
    strcpy(engine->path, info->dlpi_name);
    engine->address = (uintptr_t)info->dlpi_addr;
    for (size_t i = 0; i < info->dlpi_phnum; i++) {
        if (info->dlpi_phdr[i].p_type == PT_LOAD && info->dlpi_phdr[i].p_filesz != 0) {
            engine->address += info->dlpi_phdr[i].p_vaddr;
            break;
        }
    }
    engine->found = true;
    return 0;
}

static bool mapped_inode_matches(uintptr_t address, const struct stat *file) {
    FILE *maps = fopen("/proc/self/maps", "re");
    if (maps == NULL) return false;
    char line[PATH_MAX + 256];
    bool matches = false;
    while (fgets(line, sizeof line, maps) != NULL) {
        unsigned long long start, end, offset, inode;
        unsigned int device_major, device_minor;
        char permissions[5];
        if (sscanf(line, "%llx-%llx %4s %llx %x:%x %llu", &start, &end, permissions,
                   &offset, &device_major, &device_minor, &inode) != 7) continue;
        if (address >= start && address < end) {
            matches = inode == (unsigned long long)file->st_ino &&
                      device_major == major(file->st_dev) && device_minor == minor(file->st_dev);
            break;
        }
    }
    fclose(maps);
    return matches;
}

static void json_string(FILE *stream, const char *value) {
    if (value == NULL) { fputs("null", stream); return; }
    fputc('"', stream);
    for (const unsigned char *p = (const unsigned char *)value; *p != '\0'; p++) {
        switch (*p) {
            case '"': fputs("\\\"", stream); break;
            case '\\': fputs("\\\\", stream); break;
            case '\n': fputs("\\n", stream); break;
            case '\r': fputs("\\r", stream); break;
            case '\t': fputs("\\t", stream); break;
            default:
                if (*p < 0x20) fprintf(stream, "\\u%04x", *p);
                else fputc(*p, stream);
        }
    }
    fputc('"', stream);
}

static bool write_loaded_runtime(void) {
    struct loaded_engine engine = {0};
    dl_iterate_phdr(locate_engine, &engine);
    if (!engine.found || engine.ambiguous) { errno = ENOENT; return false; }
    char actual_path[PATH_MAX];
    if (realpath(engine.path, actual_path) == NULL) return false;
    int engine_fd = open(actual_path, O_RDONLY | O_CLOEXEC);
    if (engine_fd < 0) return false;
    struct stat before, after;
    bool valid = fstat(engine_fd, &before) == 0 && S_ISREG(before.st_mode) &&
                 mapped_inode_matches(engine.address, &before);
    char digest[65];
    if (valid) valid = capture_sha256_fd(engine_fd, digest);
    if (valid) valid = fstat(engine_fd, &after) == 0 && before.st_size == after.st_size &&
                       before.st_mtim.tv_sec == after.st_mtim.tv_sec &&
                       before.st_mtim.tv_nsec == after.st_mtim.tv_nsec &&
                       before.st_ctim.tv_sec == after.st_ctim.tv_sec &&
                       before.st_ctim.tv_nsec == after.st_ctim.tv_nsec;
    close(engine_fd);
    if (!valid) { errno = ESTALE; return false; }
    int fd = openat(capture_dir, "capture-runtime.json.tmp",
                    O_WRONLY | O_CREAT | O_TRUNC | O_NOFOLLOW | O_CLOEXEC, 0600);
    if (fd < 0) return false;
    FILE *stream = fdopen(fd, "w");
    if (stream == NULL) { close(fd); return false; }
    fprintf(stream, "{\"schema_version\":1,\"kind\":\"egl_capture_loaded_runtime\",\"pid\":%ld,\"engine\":{\"path\":",
            (long)getpid());
    json_string(stream, actual_path);
    fprintf(stream, ",\"sha256\":\"%s\",\"mapped_inode\":%llu},\"effective_ld_library_path\":",
            digest, (unsigned long long)before.st_ino);
    json_string(stream, getenv("LD_LIBRARY_PATH"));
    fputs(",\"captured_on\":\"first_eglSwapBuffers_entry\"}\n", stream);
    bool ok = ferror(stream) == 0 && fflush(stream) == 0 && fsync(fd) == 0;
    if (fclose(stream) != 0) ok = false;
    if (ok) ok = renameat(capture_dir, "capture-runtime.json.tmp", capture_dir, "capture-runtime.json") == 0;
    if (!ok) unlinkat(capture_dir, "capture-runtime.json.tmp", 0);
    return ok;
}

static void fail(struct capture_result *result, const char *error) {
    if (result->error == NULL) {
        result->error = error;
        result->native_errno = errno;
    }
}

static bool whitespace(char value) {
    return value == ' ' || value == '\t' || value == '\r' || value == '\n';
}

static void read_request(struct capture_result *result) {
    int fd = openat(capture_dir, "request.active", O_RDONLY | O_NOFOLLOW | O_NONBLOCK | O_CLOEXEC);
    if (fd < 0) { fail(result, "open_request_failed"); return; }
    struct stat info;
    if (fstat(fd, &info) != 0 || !S_ISREG(info.st_mode) || info.st_size <= 0 || info.st_size > 127) {
        errno = EINVAL;
        fail(result, "invalid_request_file");
        close(fd);
        return;
    }
    char text[128];
    size_t used = 0;
    while (used < (size_t)info.st_size) {
        ssize_t count = read(fd, text + used, (size_t)info.st_size - used);
        if (count < 0 && errno == EINTR) continue;
        if (count <= 0) {
            fail(result, "read_request_failed");
            close(fd);
            return;
        }
        used += (size_t)count;
    }
    close(fd);
    if (memchr(text, '\0', used) != NULL) {
        errno = EINVAL; fail(result, "invalid_request_nul"); return;
    }
    text[used] = '\0';
    // The protocol has no paths or arbitrary JSON in the request.
    char *cursor = text;
    if (*cursor < '1' || *cursor > '9') {
        errno = EINVAL; fail(result, "invalid_request_id"); return;
    }
    errno = 0;
    char *end;
    unsigned long long id = strtoull(cursor, &end, 10);
    if (errno != 0 || (uint64_t)id != id) {
        fail(result, "invalid_request_id"); return;
    }
    result->id = (uint64_t)id;
    cursor = end;
    if (*cursor != '\0' && !whitespace(*cursor)) {
        errno = EINVAL; fail(result, "invalid_request_suffix"); return;
    }
    while (whitespace(*cursor)) cursor++;
    if (strncmp(cursor, "barrier", 7) == 0) {
        result->barrier = true;
        cursor += 7;
    }
    while (whitespace(*cursor)) cursor++;
    if (*cursor != '\0') {
        errno = EINVAL; fail(result, "invalid_request_suffix"); return;
    }
    if (result->id <= last_request_id) {
        errno = EINVAL; fail(result, "request_id_not_increasing"); return;
    }
    last_request_id = result->id;
    snprintf(result->filename, sizeof result->filename, "frame-%" PRIu64 ".rgba", result->id);
}

static void validate_surface(struct capture_result *result, EGLDisplay display, EGLSurface surface) {
    if (eglGetCurrentDisplay() != display || eglGetCurrentSurface(EGL_DRAW) != surface ||
        eglGetCurrentSurface(EGL_READ) != surface ||
        eglGetCurrentContext() == EGL_NO_CONTEXT) {
        errno = 0; fail(result, "current_egl_surface_or_context_mismatch"); return;
    }
    if (!eglQuerySurface(display, surface, EGL_WIDTH, &result->width) ||
        !eglQuerySurface(display, surface, EGL_HEIGHT, &result->height)) {
        // Preserve EGL's error for the real runtime: do not call eglGetError.
        errno = 0; fail(result, "egl_query_surface_failed"); return;
    }
    if (result->width != CAPTURE_WIDTH || result->height != CAPTURE_HEIGHT) {
        errno = 0; fail(result, "surface_dimensions_not_2560x1600"); return;
    }
    result->gl_error = glGetError();
    if (result->gl_error != GL_NO_ERROR) {
        // The diagnostic records, fails and logs a pre-existing error instead
        // of silently draining it and accepting a potentially invalid image.
        errno = 0; fail(result, "preexisting_gl_error"); return;
    }
    glGetIntegerv(GL_FRAMEBUFFER_BINDING, &result->framebuffer);
    if (result->framebuffer != 0) {
        errno = 0; fail(result, "draw_framebuffer_is_not_zero"); return;
    }
    const char *version = (const char *)glGetString(GL_VERSION);
    if (version == NULL) { errno = 0; fail(result, "gl_version_unavailable"); return; }
    bool es3 = strncmp(version, "OpenGL ES ", 10) == 0 && version[10] >= '3' && version[10] <= '9';
    if (es3) {
        GLint pack_buffer = 0, row_length = 0, skip_rows = 0, skip_pixels = 0, read_buffer = 0;
        glGetIntegerv(GL_READ_FRAMEBUFFER_BINDING, &result->read_framebuffer);
        glGetIntegerv(GL_PIXEL_PACK_BUFFER_BINDING, &pack_buffer);
        glGetIntegerv(GL_PACK_ROW_LENGTH, &row_length);
        glGetIntegerv(GL_PACK_SKIP_ROWS, &skip_rows);
        glGetIntegerv(GL_PACK_SKIP_PIXELS, &skip_pixels);
        glGetIntegerv(GL_READ_BUFFER, &read_buffer);
        if (result->read_framebuffer != 0 || pack_buffer != 0 || row_length != 0 ||
            skip_rows != 0 || skip_pixels != 0 || read_buffer != GL_BACK) {
            errno = 0; fail(result, "nondefault_read_framebuffer_or_pack_state"); return;
        }
    }
    // RGBA8 rows are 10240 bytes, divisible by every legal pack alignment.
    // Do not mutate GL pack, FBO, read-buffer or other renderer state.
    result->gl_error = glGetError();
    if (result->gl_error != GL_NO_ERROR) {
        errno = 0; fail(result, "gl_state_query_failed");
    }
}

static void capture_pixels(struct capture_result *result) {
    unsigned char *pixels = malloc(CAPTURE_BYTES);
    if (pixels == NULL) { fail(result, "allocate_capture_failed"); return; }
    glReadPixels(0, 0, CAPTURE_WIDTH, CAPTURE_HEIGHT, GL_RGBA, GL_UNSIGNED_BYTE, pixels);
    result->gl_error = glGetError();
    if (result->gl_error != GL_NO_ERROR) {
        errno = 0; fail(result, "gl_read_pixels_failed");
        free(pixels);
        return;
    }
    unsigned char row[CAPTURE_STRIDE];
    for (size_t y = 0; y < CAPTURE_HEIGHT / 2; y++) {
        unsigned char *top = pixels + y * CAPTURE_STRIDE;
        unsigned char *bottom = pixels + (CAPTURE_HEIGHT - 1 - y) * CAPTURE_STRIDE;
        memcpy(row, top, sizeof row);
        memcpy(top, bottom, sizeof row);
        memcpy(bottom, row, sizeof row);
    }
    char temporary[112];
    snprintf(temporary, sizeof temporary, "%s.tmp-%ld", result->filename, (long)getpid());
    int fd = openat(capture_dir, temporary, O_WRONLY | O_CREAT | O_EXCL | O_NOFOLLOW | O_CLOEXEC, 0600);
    if (fd < 0) { fail(result, "open_raw_temporary_failed"); free(pixels); return; }
    if (!write_all(fd, pixels, CAPTURE_BYTES) || fsync(fd) != 0) {
        fail(result, "write_raw_failed");
    }
    free(pixels);
    if (close(fd) != 0) fail(result, "close_raw_failed");
    if (result->error == NULL) {
        // Publish without replacing an old raw file with the same ID.
        if (linkat(capture_dir, temporary, capture_dir, result->filename, 0) != 0) {
            fail(result, "publish_raw_failed");
        } else {
            result->raw_written = true;
        }
    }
    unlinkat(capture_dir, temporary, 0);
}

static void acknowledge(struct capture_result *result, EGLBoolean swap_success) {
    // Ack means the previous request is completely consumed. Remove active
    // before publishing it so a waiting client may immediately request again.
    if (unlinkat(capture_dir, "request.active", 0) != 0 && errno != ENOENT) {
        fail(result, "cleanup_active_failed");
    }
    char json[1400];
    char raw[96] = "null";
    if (result->raw_written) snprintf(raw, sizeof raw, "\"%s\"", result->filename);
    const char *error = result->error;
    if (error == NULL && swap_success != EGL_TRUE) error = "egl_swap_buffers_failed";
    char error_json[128] = "null";
    if (error != NULL) snprintf(error_json, sizeof error_json, "\"%s\"", error);
    int length = snprintf(json, sizeof json,
        "{\"schema_version\":1,\"id\":%" PRIu64 ",\"request_id\":%" PRIu64
        ",\"swap_index\":%" PRIu64 ",\"kind\":\"%s\",\"status\":\"%s\",\"error\":%s,"
        "\"file\":%s,\"width\":%d,\"height\":%d,\"stride\":%d,\"bytes\":%zu,"
        "\"format\":\"RGBA8888\",\"row_order\":\"top_to_bottom\",\"origin\":\"top-left\","
        "\"framebuffer\":%d,\"read_framebuffer\":%d,\"gl_error\":%u,\"native_errno\":%d,"
        "\"swap_success\":%s,\"source\":\"egl_backbuffer_before_swap\"}\n",
        result->id, result->id, result->swap_index, result->barrier ? "barrier" : "capture",
        error == NULL ? "ok" : "error", error_json, raw, result->width, result->height,
        CAPTURE_STRIDE, result->raw_written ? CAPTURE_BYTES : 0, result->framebuffer,
        result->read_framebuffer, result->gl_error, result->native_errno,
        swap_success == EGL_TRUE ? "true" : "false");
    if (error != NULL) {
        fprintf(stderr, "EGL_CAPTURE_ERROR id=%" PRIu64 " swap=%" PRIu64 " error=%s gl_error=%u errno=%d\n",
                result->id, result->swap_index, error, result->gl_error, result->native_errno);
    }
    if (length < 0 || (size_t)length >= sizeof json) return;
    int fd = openat(capture_dir, "ack.json.tmp", O_WRONLY | O_CREAT | O_TRUNC | O_NOFOLLOW | O_CLOEXEC, 0600);
    if (fd < 0) {
        fprintf(stderr, "EGL_CAPTURE_ERROR id=%" PRIu64 " open_ack errno=%d\n", result->id, errno);
        return;
    }
    bool ok = write_all(fd, json, (size_t)length) && fsync(fd) == 0;
    if (close(fd) != 0) ok = false;
    if (ok) ok = renameat(capture_dir, "ack.json.tmp", capture_dir, "ack.json") == 0;
    if (!ok) {
        fprintf(stderr, "EGL_CAPTURE_ERROR id=%" PRIu64 " publish_ack errno=%d\n", result->id, errno);
        unlinkat(capture_dir, "ack.json.tmp", 0);
    }
}

EGLBoolean eglSwapBuffers(EGLDisplay display, EGLSurface surface) {
    int caller_errno = errno;
    pthread_once(&initialize_once, initialize);
    if (real_swap == NULL) {
        fprintf(stderr, "EGL_CAPTURE_ERROR real_eglSwapBuffers_unavailable\n");
        return EGL_FALSE;
    }
    uint64_t index = atomic_fetch_add(&swap_count, 1) + 1;
    // Ordinary frames use no pixel readback, GL state queries or heap buffers.
    if (capture_dir < 0 || pthread_mutex_trylock(&capture_mutex) != 0) {
        errno = caller_errno;
        return real_swap(display, surface);
    }
    if (renameat(capture_dir, "request", capture_dir, "request.active") != 0) {
        pthread_mutex_unlock(&capture_mutex);
        errno = caller_errno;
        return real_swap(display, surface);
    }
    struct capture_result result = {.swap_index = index};
    read_request(&result);
    if (result.error == NULL && !loaded_runtime_ready) {
        errno = 0; fail(&result, "loaded_runtime_metadata_failed");
    }
    if (result.error == NULL) validate_surface(&result, display, surface);
    if (result.error == NULL && !result.barrier) capture_pixels(&result);
    errno = caller_errno;
    EGLBoolean success = real_swap(display, surface);
    int swap_errno = errno;
    acknowledge(&result, success);
    pthread_mutex_unlock(&capture_mutex);
    errno = swap_errno;
    return success;
}
