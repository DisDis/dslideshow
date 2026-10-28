#ifndef NATIVE_PIPELINE_TEST_DRM_H
#define NATIVE_PIPELINE_TEST_DRM_H
#include <stdint.h>
typedef struct _drmModeAtomicReq *drmModeAtomicReqPtr;
int drmModeAtomicCommit(int, drmModeAtomicReqPtr, uint32_t, void *);
int drmModePageFlip(int, uint32_t, uint32_t, uint32_t, void *);
#endif
