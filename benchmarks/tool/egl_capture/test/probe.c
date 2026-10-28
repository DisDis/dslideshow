// Pipe-driven process for host protocol regression tests.
#include <EGL/egl.h>
#include <stdio.h>
#include <stdint.h>
void fake_counts(int *, int *, int *);
#ifndef NO_ENGINE
void fake_engine_marker(void);
#endif
int main(void) {
#ifndef NO_ENGINE
    fake_engine_marker();
#endif
    char line[16];
    while (fgets(line, sizeof line, stdin) != NULL) {
        EGLBoolean ok = eglSwapBuffers((EGLDisplay)(uintptr_t)1, (EGLSurface)(uintptr_t)2);
        int reads, swaps, queries;
        fake_counts(&reads, &swaps, &queries);
        printf("%u %d %d %d\n", ok, reads, swaps, queries);
        fflush(stdout);
    }
    return 0;
}
