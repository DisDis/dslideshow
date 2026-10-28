// No display, DRM device, EGL library or GPU is opened by this mock.
#define _GNU_SOURCE
#include <EGL/egl.h>
#include <gbm.h>
#include <xf86drmMode.h>
#include <assert.h>
#include <dlfcn.h>
#include <errno.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define PTR(value) ((void *)(uintptr_t)(value))

EGLBoolean eglSwapBuffers(EGLDisplay display, EGLSurface surface) {
    assert(errno == 77 && display == PTR(0x11) && surface == PTR(0x22));
    if (getenv("MOCK_DIE_IN_CALL")) _exit(17);
    if (getenv("MOCK_NESTED")) {
        // Resolve through the public namespace so compiler inlining/local
        // binding of this mock does not bypass the LD_PRELOAD nested call.
        EGLBoolean (*make_current)(EGLDisplay, EGLSurface, EGLSurface, EGLContext);
        void *symbol = dlsym(RTLD_DEFAULT, "eglMakeCurrent");
        memcpy(&make_current, &symbol, sizeof make_current);
        assert(make_current);
        errno = 77;
        assert(make_current(PTR(0x11), PTR(0x22), PTR(0x33), PTR(0x44)) == EGL_TRUE);
    }
    errno = EAGAIN;
    return EGL_FALSE;
}

EGLBoolean eglMakeCurrent(EGLDisplay display, EGLSurface draw, EGLSurface read, EGLContext context) {
    assert(errno == 77 && display == PTR(0x11) && draw == PTR(0x22) && read == PTR(0x33) && context == PTR(0x44));
    errno = ERANGE;
    return EGL_TRUE;
}

struct gbm_bo *gbm_surface_lock_front_buffer(struct gbm_surface *surface) {
    assert(errno == 77 && surface == PTR(0x55));
    errno = EINTR;
    return PTR(0x88);
}

void gbm_surface_release_buffer(struct gbm_surface *surface, struct gbm_bo *bo) {
    assert(errno == 77 && surface == PTR(0x55) && bo == PTR(0x88));
    errno = EIO;
}

int drmModeAtomicCommit(int fd, drmModeAtomicReqPtr req, uint32_t flags, void *userdata) {
    assert(errno == 77 && fd == 9 && req == PTR(0xaa) && flags == 0xbb && userdata == PTR(0xcc));
    errno = EBUSY;
    return -7;
}

int drmModePageFlip(int fd, uint32_t crtc, uint32_t fb, uint32_t flags, void *userdata) {
    assert(errno == 77 && fd == 9 && crtc == 10 && fb == 11 && flags == 12 && userdata == PTR(0xdd));
    errno = ENOTTY;
    return 3;
}

EGLSurface eglCreateWindowSurface(EGLDisplay display, EGLConfig config, EGLNativeWindowType window, const EGLint *attrs) {
    assert(errno == 77 && display == PTR(0x11) && config == PTR(0xee) && window == PTR(0xff));
    assert(attrs && attrs[0] == 123 && attrs[1] == 456);
    errno = ENODEV;
    return PTR(0x99);
}
