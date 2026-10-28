# Изменения benchmarks

Здесь описываются стенд, его диагностические пробы и инструменты. Продуктовые
изменения backend, config_app и dslideshow_flutter ведутся в
[корневом changelog](../changelog.md).

Исторические группы ниже перенесены из changelog приложения. Их версии и даты
обозначают выпуски приложения, а не самостоятельные выпуски пакета benchmarks.

## Unreleased

* Pass stable immutable effect inputs through the viewport, probes and capture
  tools. Preserve borrowed photo ownership, separate BlurProbe clones, identity
  PhotoMotionProbe cameras and existing shader/live regression paths; no new
  hardware acceptance run accompanies this interface migration.

* Preserve matched OpenGL photo ABBA and EGL backbuffer evidence for the new
  flutter-pi/900-MHz profile. Keep failed visual/performance trials explicit;
  retain focused production Radial/VHS configurations and independent shader
  reconstruction/resource/live-input regressions.

* Add bounded native EGL/GBM/DRM diagnostics and an owned V3D/DRM tracefs session
  on a frozen photo-only release bundle. Verify the actual mapped engine and
  correlate raw FrameTiming windows with native spans and GPU submissions/IRQs;
  preserve losses and incomplete data instead of treating diagnostic FPS as an
  optimization result.
* Add photo-only screening generated from all 37 effect families and 82 presets,
  deduplicating identical settings. Follow slow settings with warmed repetitions;
  exclude video, GIF and 48-MP preparation from this investigation. Preserve
  runtime, media and build provenance for baseline/candidate comparisons.
* Match production prepared-photo inputs and viewport sizing. Remove shared
  GlobalKeys from repeated media views; retain the source key only for bitmap
  probes that need to inspect one RenderImage. Keep legacy input layouts available
  for reproducing older reports.
* Compare measured repetitions separately from warmup cases, require complete
  measurements and matching conditions, and report frame tails and resource
  changes. Add regression checks for comparison parsing and frozen build/source
  fingerprints.
* Add an optional EGL backbuffer capture helper and flutter-pi wrapper with a
  sequential request/ack protocol, actual swap barriers, RGBA readback and loaded
  runtime/engine provenance. Keep capture runs separate from performance timings.
  Archive completed strict pixel-audit results independently of manual visual
  acceptance.
* Archive the completed retained-transform Stretch/CrossZoom and photo-shader
  Radial trials, then retire their temporary entrypoint/classes/assets after
  promotion to the application. Keep normal viewport binding and regressions.
* Add separate full-resolution Glass and linear-light Film Dissolve photo-shader
  trials, a four-case matched A/B configuration and geometry/resource tests.
  Record fractional pane seams and intermediate gamma-surface quantization as
  visual differences; preserve strict historical audit results. Archive both
  builds and retire temporary implementations after production promotion.
* Investigate sharing Glass reconstruction weights for exactly matching photo
  coordinates and sizes, with strict image/resource regressions and an isolated
  three-case A/B configuration. Archive the completed trial after production
  promotion; retain its preceding shader only as a strict reconstruction-test
  fixture, without a separate reference effect or preview mode.
* Parameterize the historical standard matrix for configured effects and retain
  canonical effect settings in reports as the catalog becomes 37 families /
  82 presets. Compare presets at 21 phases with temporary frozen renderers.
  After visual review, remove the working reference/pixel-comparison scaffolding
  and shaders; preserve source/release archives, results and the preset mapping.

Method, archived sources and results:
[effect performance investigation](../doc/effect-performance-2026-10.md).
The retained [EGL helper](tool/egl_capture/README.md) documents the capture protocol.

## Из выпуска приложения 13.1.0+1 — 2026-10-27

* Update the effect-matrix regression and documentation to 624 cases and cover
  every registered effect across all six primary media directions.

## Из выпуска приложения 13.0.0+1 — 2026-10-27

* Add a standalone local Ambient API probe for device OAuth, album-source
  selection, paginated media listing and photo/video downloads. Preserve resumable
  private state, bounded downloads, diagnostics and loopback HTTP checks.
* Reproduce thumbnail alpha handling with FFmpeg 5.1.9 and 8.0.1, retaining codec
  fixtures and local diagnostic runs separately from the backend fix.

## Из выпуска приложения 12.0.0+2 — 2026-10-27

* Add frozen local HTTP/Chrome gallery comparisons and native-cache probes for
  cold writes, warm hits, read-only metadata, cancellation and cleanup. Keep
  backend baseline/candidate measurements separate from product release notes.

## Из выпуска приложения 10.1.0+1 — 2026-10-25

* Add focused OpenGL photo/GIF/video and visual suites, including camera-specific
  audits and explicit unsupported-media reporting.
* Add composition controls and reverse-order LiquidMorph/Accordion A/B scenarios.
  Retain the rejected grouped Accordion experiment for diagnostics and distinguish
  UI work from raster bottlenecks in reports.
* Add opt-in Mosaic drawing probes and focused device suites; audit every selected
  dense grid with full-resolution RGBA fingerprints.

## Из выпуска приложения 10.0.0+2 — 2026-10-25

* Add the standalone automatic Raspberry Pi benchmark application with media
  fixtures, telemetry, visual audits and portable reports.
* Add ZoomOver/BlurFade component, composition and photo/GIF/video scenarios,
  including full-frame RGBA fingerprints and zero-blur/smooth-progress checks.
* Use OpenGL by default. Defer Vulkan runs until native video support, keep an
  explicit future opt-in and preserve native crash/cleanup failures in reports.
  Track known native OpenGL video-to-video crashes as unresolved failures.
* Document device deployment, unattended runs, flutter-pi source/runtime locations
  and reproducible performance validation.
