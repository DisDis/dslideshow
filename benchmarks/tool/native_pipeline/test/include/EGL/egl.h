#ifndef NATIVE_PIPELINE_TEST_EGL_H
#define NATIVE_PIPELINE_TEST_EGL_H
#include <stdint.h>
typedef void *EGLDisplay;
typedef void *EGLSurface;
typedef void *EGLContext;
typedef void *EGLConfig;
typedef void *EGLNativeWindowType;
typedef uint32_t EGLBoolean;
typedef int32_t EGLint;
#define EGL_FALSE 0
#define EGL_TRUE 1
#define EGL_NO_SURFACE ((EGLSurface)0)
EGLBoolean eglSwapBuffers(EGLDisplay, EGLSurface);
EGLBoolean eglMakeCurrent(EGLDisplay, EGLSurface, EGLSurface, EGLContext);
EGLSurface eglCreateWindowSurface(EGLDisplay, EGLConfig, EGLNativeWindowType, const EGLint *);
#endif
