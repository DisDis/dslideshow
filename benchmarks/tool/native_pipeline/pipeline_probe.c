// SPDX-License-Identifier: MIT
// Benchmark-only timing of the native EGL/GBM/KMS pipeline. No GL calls.
#define _GNU_SOURCE
#include <EGL/egl.h>
#include <gbm.h>
#include <xf86drmMode.h>

#include <dlfcn.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdatomic.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <time.h>
#include <unistd.h>

enum probe_function {
    PROBE_EGL_SWAP_BUFFERS = 1,
    PROBE_EGL_MAKE_CURRENT,
    PROBE_GBM_LOCK_FRONT_BUFFER,
    PROBE_GBM_RELEASE_BUFFER,
    PROBE_DRM_ATOMIC_COMMIT,
    PROBE_DRM_PAGE_FLIP,
    PROBE_EGL_CREATE_WINDOW_SURFACE,
};

enum { PROBE_DEFAULT_CAPACITY = 131072, PROBE_MAX_CAPACITY = 1048576 };

// Binary ABI v1. The endian sentinel lets readers reject or decode other byte
// orders explicitly. All counters and per-record commit markers are atomic.
struct probe_header {
    char magic[8];
    uint32_t version, endian, header_size, record_size, capacity, pid;
    uint32_t flags, init_errno;
    _Atomic uint64_t reserved_count, committed_count, dropped_count;
    uint64_t start_monotonic_ns, start_realtime_ns;
    _Atomic uint64_t closed_monotonic_ns;
    _Atomic uint32_t lifecycle, clock_errors;
    uint64_t reserved[4];
};

struct probe_record {
    _Atomic uint32_t committed;
    uint16_t function, depth;
    uint64_t sequence, start_ns, end_ns, cpu_start_ns, cpu_end_ns;
    uint32_t tid;
    int32_t result_errno;
    int64_t result;
    uint64_t args[6];
    uint32_t entry_errno;
    uint32_t reserved0;
    uint64_t reserved1;
};

_Static_assert(sizeof(struct probe_header) == 128, "header ABI");
_Static_assert(sizeof(struct probe_record) == 128, "record ABI");
_Static_assert(offsetof(struct probe_header, reserved_count) == 40, "counter ABI");
_Static_assert(offsetof(struct probe_header, lifecycle) == 88, "lifecycle ABI");
_Static_assert(offsetof(struct probe_record, sequence) == 8, "sequence ABI");
_Static_assert(offsetof(struct probe_record, tid) == 48, "tid ABI");
_Static_assert(offsetof(struct probe_record, args) == 64, "args ABI");
_Static_assert(offsetof(struct probe_record, entry_errno) == 112, "errno ABI");
_Static_assert(ATOMIC_LLONG_LOCK_FREE == 2, "64-bit lock-free counters required");

static EGLBoolean (*next_swap)(EGLDisplay, EGLSurface);
static EGLBoolean (*next_make_current)(EGLDisplay, EGLSurface, EGLSurface, EGLContext);
static struct gbm_bo *(*next_lock)(struct gbm_surface *);
static void (*next_release)(struct gbm_surface *, struct gbm_bo *);
static int (*next_atomic_commit)(int, drmModeAtomicReqPtr, uint32_t, void *);
static int (*next_page_flip)(int, uint32_t, uint32_t, uint32_t, void *);
static EGLSurface (*next_create_window)(EGLDisplay, EGLConfig, EGLNativeWindowType, const EGLint *);
static struct probe_header *header;
static struct probe_record *records;
static size_t mapping_size;
static int output_fd = -1;
static pid_t owner_pid;
static _Thread_local uint32_t call_depth, cached_tid;

static uint64_t now_ns(clockid_t clock) {
    struct timespec value;
    if (clock_gettime(clock, &value) != 0) {
        if (header) atomic_fetch_add_explicit(&header->clock_errors, 1, memory_order_relaxed);
        return 0;
    }
    return (uint64_t)value.tv_sec * UINT64_C(1000000000) + (uint64_t)value.tv_nsec;
}

static void report_error(const char *operation, int error) {
    // Initialization/errors only; there is no formatting or output per frame.
    fprintf(stderr, "NATIVE_PIPELINE_ERROR operation=%s errno=%d timing_results_valid=false\n", operation, error);
}

static bool parse_capacity(uint32_t *out) {
    const char *text = getenv("BENCH_NATIVE_PIPELINE_CAPACITY");
    *out = PROBE_DEFAULT_CAPACITY;
    if (!text || !*text) return true;
    uint64_t value = 0;
    for (const unsigned char *p = (const unsigned char *)text; *p; ++p) {
        if (*p < '0' || *p > '9') return false;
        value = value * 10 + (*p - '0');
        if (value > PROBE_MAX_CAPACITY) return false;
    }
    if (value == 0) return false;
    *out = (uint32_t)value;
    return true;
}

// POSIX dlsym function pointers have the same representation as void*.
#define RESOLVE(target, name) do { \
    void *symbol = dlsym(RTLD_NEXT, name); \
    _Static_assert(sizeof(target) == sizeof(symbol), "function pointer ABI"); \
    memcpy(&(target), &symbol, sizeof(target)); \
} while (0)

__attribute__((constructor)) static void initialize_probe(int argc, char **argv) {
    int saved_errno = errno;
    RESOLVE(next_swap, "eglSwapBuffers");
    RESOLVE(next_make_current, "eglMakeCurrent");
    RESOLVE(next_lock, "gbm_surface_lock_front_buffer");
    RESOLVE(next_release, "gbm_surface_release_buffer");
    RESOLVE(next_atomic_commit, "drmModeAtomicCommit");
    RESOLVE(next_page_flip, "drmModePageFlip");
    RESOLVE(next_create_window, "eglCreateWindowSurface");

    const char *path = getenv("BENCH_NATIVE_PIPELINE_OUTPUT");
    if (!path || !*path) goto done;
    // LD_PRELOAD also reaches Dart's subprocesses. Only the requested ELF may
    // create/write the output; compare inode+device, not a pathname substring.
    const char *target = getenv("BENCH_NATIVE_PIPELINE_TARGET");
    if (!target || target[0] != '/') {
        report_error("target", EINVAL);
        goto done;
    }
    struct stat expected, current;
    if (stat(target, &expected) != 0 || stat("/proc/self/exe", &current) != 0) {
        report_error("target_stat", errno);
        goto done;
    }
    if (expected.st_dev != current.st_dev || expected.st_ino != current.st_ino) goto done;
    for (int i = 1; i < argc; ++i) {
        if (strcmp(argv[i], "--help") == 0 || strcmp(argv[i], "-h") == 0) goto done;
    }
    uint32_t capacity;
    if (!parse_capacity(&capacity)) {
        report_error("capacity", EINVAL);
        goto done;
    }
    output_fd = open(path, O_RDWR | O_CREAT | O_EXCL | O_NOFOLLOW | O_CLOEXEC, 0600);
    if (output_fd < 0) {
        report_error("open", errno);
        goto done;
    }
    mapping_size = sizeof(struct probe_header) + (size_t)capacity * sizeof(struct probe_record);
    if (ftruncate(output_fd, (off_t)mapping_size) != 0) {
        report_error("ftruncate", errno);
        close(output_fd);
        output_fd = -1;
        goto done;
    }
    // A sparse file could SIGBUS during a later frame if the filesystem fills.
    // Reserve all storage now and disable the probe cleanly on ENOSPC/unsupported
    // allocation, before touching the mapping or changing any application call.
    int allocation_error = posix_fallocate(output_fd, 0, (off_t)mapping_size);
    if (allocation_error != 0) {
        report_error("posix_fallocate", allocation_error);
        close(output_fd);
        output_fd = -1;
        goto done;
    }
    void *mapping = mmap(NULL, mapping_size, PROT_READ | PROT_WRITE, MAP_SHARED, output_fd, 0);
    if (mapping == MAP_FAILED) {
        report_error("mmap", errno);
        close(output_fd);
        output_fd = -1;
        goto done;
    }
    // Prefault the bounded storage before the application starts rendering.
    memset(mapping, 0, mapping_size);
    header = mapping;
    records = (struct probe_record *)(header + 1);
    owner_pid = getpid();
    memcpy(header->magic, "NPIPV001", 8);
    header->version = 1;
    header->endian = UINT32_C(0x01020304);
    header->header_size = sizeof *header;
    header->record_size = sizeof *records;
    header->capacity = capacity;
    header->pid = (uint32_t)owner_pid;
    header->flags = 3; // bit0: timing_results_valid=false; bit1: MAP_SHARED storage.
    header->start_monotonic_ns = now_ns(CLOCK_MONOTONIC);
    header->start_realtime_ns = now_ns(CLOCK_REALTIME);
    atomic_store_explicit(&header->lifecycle, 1, memory_order_release);
done:
    errno = saved_errno;
}

struct probe_span { struct probe_record *record; bool active; };

static struct probe_span begin_probe(enum probe_function function, int entry_errno,
                                     uint64_t a0, uint64_t a1, uint64_t a2,
                                     uint64_t a3, uint64_t a4) {
    struct probe_span span = {0};
    if (!header || owner_pid != getpid()) return span;
    span.active = true;
    uint32_t depth = call_depth++;
    uint64_t index = atomic_fetch_add_explicit(&header->reserved_count, 1, memory_order_relaxed);
    if (index >= header->capacity) {
        atomic_fetch_add_explicit(&header->dropped_count, 1, memory_order_relaxed);
        return span;
    }
    span.record = &records[index];
    span.record->function = (uint16_t)function;
    span.record->depth = depth > UINT16_MAX ? UINT16_MAX : (uint16_t)depth;
    span.record->sequence = index + 1;
    if (!cached_tid) cached_tid = (uint32_t)syscall(SYS_gettid);
    span.record->tid = cached_tid;
    span.record->entry_errno = (uint32_t)entry_errno;
    span.record->args[0] = a0;
    span.record->args[1] = a1;
    span.record->args[2] = a2;
    span.record->args[3] = a3;
    span.record->args[4] = a4;
    span.record->start_ns = now_ns(CLOCK_MONOTONIC);
    span.record->cpu_start_ns = now_ns(CLOCK_THREAD_CPUTIME_ID);
    return span;
}

static void end_probe(struct probe_span span, int64_t result, int result_errno) {
    if (!span.active) return;
    if (span.record) {
        span.record->cpu_end_ns = now_ns(CLOCK_THREAD_CPUTIME_ID);
        span.record->end_ns = now_ns(CLOCK_MONOTONIC);
        span.record->result = result;
        span.record->result_errno = result_errno;
        atomic_store_explicit(&span.record->committed, 1, memory_order_release);
        atomic_fetch_add_explicit(&header->committed_count, 1, memory_order_relaxed);
    }
    --call_depth;
}

__attribute__((destructor)) static void finalize_probe(void) {
    if (!header || owner_pid != getpid()) return;
    atomic_store_explicit(&header->closed_monotonic_ns, now_ns(CLOCK_MONOTONIC), memory_order_relaxed);
    atomic_store_explicit(&header->lifecycle, 2, memory_order_release);
    if (msync(header, mapping_size, MS_SYNC) != 0) report_error("msync", errno);
    // Do not unmap: other application threads can still be unwinding. The OS
    // releases the mapping/fd at exit. Completed records also survive _exit().
}

#define P(value) ((uint64_t)(uintptr_t)(value))
#define BEGIN(function, a0, a1, a2, a3, a4) \
    int entry_errno = errno; \
    struct probe_span span = begin_probe(function, entry_errno, a0, a1, a2, a3, a4); \
    errno = entry_errno
#define END(value) do { \
    int saved_errno = errno; \
    end_probe(span, (int64_t)(value), saved_errno); \
    errno = saved_errno; \
} while (0)

EGLBoolean eglSwapBuffers(EGLDisplay display, EGLSurface surface) {
    if (!next_swap) { errno = ENOSYS; return EGL_FALSE; }
    BEGIN(PROBE_EGL_SWAP_BUFFERS, P(display), P(surface), 0, 0, 0);
    EGLBoolean result = next_swap(display, surface);
    END(result);
    return result;
}

EGLBoolean eglMakeCurrent(EGLDisplay display, EGLSurface draw, EGLSurface read, EGLContext context) {
    if (!next_make_current) { errno = ENOSYS; return EGL_FALSE; }
    BEGIN(PROBE_EGL_MAKE_CURRENT, P(display), P(draw), P(read), P(context), 0);
    EGLBoolean result = next_make_current(display, draw, read, context);
    END(result);
    return result;
}

struct gbm_bo *gbm_surface_lock_front_buffer(struct gbm_surface *surface) {
    if (!next_lock) { errno = ENOSYS; return NULL; }
    BEGIN(PROBE_GBM_LOCK_FRONT_BUFFER, P(surface), 0, 0, 0, 0);
    struct gbm_bo *result = next_lock(surface);
    END(P(result));
    return result;
}

void gbm_surface_release_buffer(struct gbm_surface *surface, struct gbm_bo *bo) {
    if (!next_release) { errno = ENOSYS; return; }
    BEGIN(PROBE_GBM_RELEASE_BUFFER, P(surface), P(bo), 0, 0, 0);
    next_release(surface, bo);
    END(0);
}

int drmModeAtomicCommit(int fd, drmModeAtomicReqPtr req, uint32_t flags, void *userdata) {
    if (!next_atomic_commit) { errno = ENOSYS; return -1; }
    BEGIN(PROBE_DRM_ATOMIC_COMMIT, (uint64_t)(int64_t)fd, P(req), flags, P(userdata), 0);
    int result = next_atomic_commit(fd, req, flags, userdata);
    END(result);
    return result;
}

int drmModePageFlip(int fd, uint32_t crtc, uint32_t fb, uint32_t flags, void *userdata) {
    if (!next_page_flip) { errno = ENOSYS; return -1; }
    BEGIN(PROBE_DRM_PAGE_FLIP, (uint64_t)(int64_t)fd, crtc, fb, flags, P(userdata));
    int result = next_page_flip(fd, crtc, fb, flags, userdata);
    END(result);
    return result;
}

EGLSurface eglCreateWindowSurface(EGLDisplay display, EGLConfig config,
                                  EGLNativeWindowType window, const EGLint *attrs) {
    if (!next_create_window) { errno = ENOSYS; return EGL_NO_SURFACE; }
    BEGIN(PROBE_EGL_CREATE_WINDOW_SURFACE, P(display), P(config), P(window), P(attrs), 0);
    EGLSurface result = next_create_window(display, config, window, attrs);
    END(P(result));
    return result;
}
