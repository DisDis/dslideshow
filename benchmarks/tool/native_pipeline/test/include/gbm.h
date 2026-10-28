#ifndef NATIVE_PIPELINE_TEST_GBM_H
#define NATIVE_PIPELINE_TEST_GBM_H
struct gbm_surface;
struct gbm_bo;
struct gbm_bo *gbm_surface_lock_front_buffer(struct gbm_surface *);
void gbm_surface_release_buffer(struct gbm_surface *, struct gbm_bo *);
#endif
