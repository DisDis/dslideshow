#define _GNU_SOURCE
#include <dlfcn.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <time.h>

int posix_fallocate(int fd, off_t offset, off_t length) {
    if (getenv("MOCK_FAIL_ALLOCATION")) return ENOSPC;
    int (*real_allocate)(int, off_t, off_t);
    void *symbol = dlsym(RTLD_NEXT, "posix_fallocate");
    memcpy(&real_allocate, &symbol, sizeof real_allocate);
    return real_allocate(fd, offset, length);
}

int clock_gettime(clockid_t clock, struct timespec *value) {
    if (clock == CLOCK_THREAD_CPUTIME_ID && getenv("MOCK_FAIL_CPU_CLOCK")) {
        errno = EIO;
        return -1;
    }
    int (*real_clock)(clockid_t, struct timespec *);
    void *symbol = dlsym(RTLD_NEXT, "clock_gettime");
    memcpy(&real_clock, &symbol, sizeof real_clock);
    return real_clock(clock, value);
}
