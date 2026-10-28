// Host-only fake; opens no display and does not load an EGL driver.
#include <EGL/egl.h>
#include <GLES3/gl3.h>
#include <stdint.h>
#include <stdlib.h>

static int reads, swaps, queries;
void fake_counts(int *r, int *s, int *q) { *r = reads; *s = swaps; *q = queries; }
static int configured(const char *name, int fallback) {
    const char *value = getenv(name);
    return value == NULL ? fallback : atoi(value);
}
EGLDisplay eglGetCurrentDisplay(void) { return (EGLDisplay)(uintptr_t)1; }
EGLSurface eglGetCurrentSurface(EGLint which) {
    if (which == EGL_READ && configured("FAKE_READ_MISMATCH", 0)) return (EGLSurface)(uintptr_t)4;
    return (EGLSurface)(uintptr_t)2;
}
EGLContext eglGetCurrentContext(void) { return (EGLContext)(uintptr_t)3; }
EGLBoolean eglQuerySurface(EGLDisplay display, EGLSurface surface, EGLint attribute, EGLint *value) {
    (void)display; (void)surface;
    *value = attribute == EGL_WIDTH ? configured("FAKE_WIDTH", 2560) : 1600;
    return EGL_TRUE;
}
EGLBoolean eglSwapBuffers(EGLDisplay display, EGLSurface surface) {
    (void)display; (void)surface; swaps++;
    return configured("FAKE_SWAP_FALSE", 0) ? EGL_FALSE : EGL_TRUE;
}
const GLubyte *glGetString(GLenum name) { (void)name; return (const GLubyte *)"OpenGL ES 3.1 fake"; }
GLenum glGetError(void) {
    return configured("FAKE_GL_ERROR", 0) ? GL_INVALID_OPERATION : GL_NO_ERROR;
}
void glGetIntegerv(GLenum name, GLint *value) {
    queries++;
    if (name == GL_FRAMEBUFFER_BINDING) *value = configured("FAKE_FBO", 0);
    else if (name == GL_READ_BUFFER) *value = GL_BACK;
    else *value = 0;
}
void glReadPixels(GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, void *data) {
    (void)x; (void)y; (void)format; (void)type; reads++;
    unsigned char *out = data;
    for (int row = 0; row < height; row++) {
        for (int column = 0; column < width; column++) {
            *out++ = (unsigned char)(row & 255);
            *out++ = (unsigned char)(column & 255);
            *out++ = 37;
            *out++ = 255;
        }
    }
}
