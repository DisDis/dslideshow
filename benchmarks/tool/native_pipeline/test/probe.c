#define _GNU_SOURCE
#include <EGL/egl.h>
#include <gbm.h>
#include <xf86drmMode.h>
#include <assert.h>
#include <errno.h>
#include <pthread.h>
#include <stdint.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

#define PTR(value) ((void *)(uintptr_t)(value))

static void invoke_all(void) {
    errno = 77;
    assert(eglSwapBuffers(PTR(0x11), PTR(0x22)) == EGL_FALSE && errno == EAGAIN);
    errno = 77;
    assert(eglMakeCurrent(PTR(0x11), PTR(0x22), PTR(0x33), PTR(0x44)) == EGL_TRUE && errno == ERANGE);
    errno = 77;
    assert(gbm_surface_lock_front_buffer(PTR(0x55)) == PTR(0x88) && errno == EINTR);
    errno = 77;
    gbm_surface_release_buffer(PTR(0x55), PTR(0x88));
    assert(errno == EIO);
    errno = 77;
    assert(drmModeAtomicCommit(9, PTR(0xaa), 0xbb, PTR(0xcc)) == -7 && errno == EBUSY);
    errno = 77;
    assert(drmModePageFlip(9, 10, 11, 12, PTR(0xdd)) == 3 && errno == ENOTTY);
    const EGLint attrs[] = {123, 456};
    errno = 77;
    assert(eglCreateWindowSurface(PTR(0x11), PTR(0xee), PTR(0xff), attrs) == PTR(0x99) && errno == ENODEV);
}

static void *thread_calls(void *unused) {
    (void)unused;
    for (int i = 0; i < 20; ++i) invoke_all();
    return NULL;
}

int main(int argc, char **argv) {
    if (argc > 1 && strcmp(argv[1], "threads") == 0) {
        pthread_t threads[4];
        for (int i = 0; i < 4; ++i) assert(pthread_create(&threads[i], NULL, thread_calls, NULL) == 0);
        for (int i = 0; i < 4; ++i) assert(pthread_join(threads[i], NULL) == 0);
        return 0;
    }
    if (argc > 1 && (strcmp(argv[1], "fork") == 0 || strcmp(argv[1], "spawn") == 0)) {
        pid_t child = fork();
        assert(child >= 0);
        if (!child) {
            if (strcmp(argv[1], "spawn") == 0) {
                execl("/bin/true", "true", (char *)NULL);
                _exit(99);
            }
            invoke_all();
            _exit(0);
        }
        int status;
        assert(waitpid(child, &status, 0) == child && WIFEXITED(status) && WEXITSTATUS(status) == 0);
    }
    invoke_all();
    if (argc > 1 && strcmp(argv[1], "exit") == 0) _exit(0);
    return 0;
}
