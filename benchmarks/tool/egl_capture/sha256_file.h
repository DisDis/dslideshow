// SPDX-License-Identifier: MIT
// Small SHA-256 implementation for hashing the actually loaded engine file.
// No extra runtime library, subprocess or package is required.
#ifndef BENCHMARK_EGL_SHA256_FILE_H
#define BENCHMARK_EGL_SHA256_FILE_H
#include <errno.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>

struct capture_sha256 {
    uint32_t state[8];
    uint64_t bytes;
    unsigned char block[64];
    size_t used;
};
static uint32_t capture_rotate(uint32_t value, unsigned int count) {
    return (value >> count) | (value << (32 - count));
}
static void capture_sha256_block(struct capture_sha256 *hash, const unsigned char *data) {
    static const uint32_t constants[64] = {
        0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,
        0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,
        0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,
        0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,
        0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,
        0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,
        0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,
        0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2
    };
    uint32_t words[64];
    for (unsigned int i = 0; i < 16; i++) {
        const unsigned char *p = data + 4 * i;
        words[i] = ((uint32_t)p[0] << 24) | ((uint32_t)p[1] << 16) | ((uint32_t)p[2] << 8) | p[3];
    }
    for (unsigned int i = 16; i < 64; i++) {
        uint32_t x = words[i - 15], y = words[i - 2];
        uint32_t s0 = capture_rotate(x, 7) ^ capture_rotate(x, 18) ^ (x >> 3);
        uint32_t s1 = capture_rotate(y, 17) ^ capture_rotate(y, 19) ^ (y >> 10);
        words[i] = words[i - 16] + s0 + words[i - 7] + s1;
    }
    uint32_t a = hash->state[0], b = hash->state[1], c = hash->state[2], d = hash->state[3];
    uint32_t e = hash->state[4], f = hash->state[5], g = hash->state[6], h = hash->state[7];
    for (unsigned int i = 0; i < 64; i++) {
        uint32_t s1 = capture_rotate(e, 6) ^ capture_rotate(e, 11) ^ capture_rotate(e, 25);
        uint32_t choose = (e & f) ^ (~e & g);
        uint32_t t1 = h + s1 + choose + constants[i] + words[i];
        uint32_t s0 = capture_rotate(a, 2) ^ capture_rotate(a, 13) ^ capture_rotate(a, 22);
        uint32_t majority = (a & b) ^ (a & c) ^ (b & c);
        uint32_t t2 = s0 + majority;
        h = g; g = f; f = e; e = d + t1; d = c; c = b; b = a; a = t1 + t2;
    }
    hash->state[0] += a; hash->state[1] += b; hash->state[2] += c; hash->state[3] += d;
    hash->state[4] += e; hash->state[5] += f; hash->state[6] += g; hash->state[7] += h;
}
static void capture_sha256_update(struct capture_sha256 *hash, const unsigned char *data, size_t length) {
    hash->bytes += length;
    while (length != 0) {
        size_t available = sizeof hash->block - hash->used;
        size_t count = length < available ? length : available;
        memcpy(hash->block + hash->used, data, count);
        hash->used += count; data += count; length -= count;
        if (hash->used == sizeof hash->block) {
            capture_sha256_block(hash, hash->block);
            hash->used = 0;
        }
    }
}
static bool capture_sha256_fd(int fd, char hexadecimal[65]) {
    struct capture_sha256 hash = {.state = {
        0x6a09e667,0xbb67ae85,0x3c6ef372,0xa54ff53a,0x510e527f,0x9b05688c,0x1f83d9ab,0x5be0cd19
    }};
    unsigned char buffer[16384];
    for (;;) {
        ssize_t count = read(fd, buffer, sizeof buffer);
        if (count < 0 && errno == EINTR) continue;
        if (count < 0) return false;
        if (count == 0) break;
        capture_sha256_update(&hash, buffer, (size_t)count);
    }
    uint64_t bits = hash.bytes * 8;
    const unsigned char marker = 0x80, zero = 0;
    capture_sha256_update(&hash, &marker, 1);
    while (hash.used != 56) capture_sha256_update(&hash, &zero, 1);
    unsigned char length_bytes[8];
    for (unsigned int i = 0; i < 8; i++) length_bytes[7 - i] = (unsigned char)(bits >> (8 * i));
    capture_sha256_update(&hash, length_bytes, sizeof length_bytes);
    static const char digits[] = "0123456789abcdef";
    for (unsigned int i = 0; i < 32; i++) {
        unsigned char value = (unsigned char)(hash.state[i / 4] >> (24 - (i % 4) * 8));
        hexadecimal[2 * i] = digits[value >> 4];
        hexadecimal[2 * i + 1] = digits[value & 15];
    }
    hexadecimal[64] = '\0';
    return true;
}
#endif
