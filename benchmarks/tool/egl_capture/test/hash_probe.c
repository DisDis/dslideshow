#define _GNU_SOURCE
#include "../sha256_file.h"
#include <stdio.h>
int main(int argc, char **argv) {
    if (argc != 2) return 2;
    int fd = open(argv[1], O_RDONLY | O_CLOEXEC);
    if (fd < 0) return 2;
    char digest[65];
    bool ok = capture_sha256_fd(fd, digest);
    close(fd);
    if (!ok) return 2;
    puts(digest);
    return 0;
}
