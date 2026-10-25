# Unreleased

* Add an explicit, cancellable fadingIn screen phase after hardware wake and
  fade-out reversal. Preserve manual sleep priority and the original reveal
  deadline across brief presence changes; initialize sleeping renderers black.
* Add backend and widget regressions for full wake, reverse transitions, duplicate
  ON events, stale completion and cleanup. Physical frame validation is pending.

# 10.0.0+2 — 2026-10-25

* Fix DEB checksum manifests to use paths relative to the package root;
  add a regression check that builds and extracts a fixture package.
* Add extensible special slideshow screens with clocks and direct HTTP/HTTPS
  JPEG/PNG cameras, grid/round-robin playback, scheduling and lifecycle cleanup.
* Add config_app screen editors/previews and per-type default stripping on save;
  use enums and JsonSerializable configuration models with round-trip tests.
* Fix camera cursor advancement, refresh deadlines and snapshot cancellation;
  retain pending screens and freeze transitions during pause/sleep. Keep compact
  serialization in the owning configuration models and add regression tests.
* Split clock/camera widgets, playback sessions and the renderer registry into
  separate files.

* Reduce ZoomOver opacity-layer bounds to the viewport while preserving visible
  pixels and animation curves; verify the improvement with OpenGL A/B on RaPi5.
* Reduce BlurFade compositing overhead with a composed Gaussian/alpha filter
  and explicit decal edges; preserve the original fade for zero sigma and verify
  exact full-resolution RGBA frames and smooth progress on RaPi5 OpenGL.
* Add opt-in BlurFade component/composition probes, focused photo/GIF/video
  configurations and full-frame RGBA fingerprints to the separate benchmark app.
* Use OpenGL as the default benchmark renderer; defer Vulkan device runs until
  the native runtime supports video. Add focused ZoomOver/BlurFade photo/GIF,
  video and visual regression configurations.
* Cancel screen sleep and reverse fading immediately when presence returns;
  serialize hardware power changes and ignore superseded asynchronous results.
  Preserve manual sleep priority and handle stale manual lock RPC responses.
* Replace dropped GPIO edges with immediate presence and confirmed absence;
  dispose screen timers/subscriptions and add Linux backend/Flutter regressions.
  Physical display/GPIO acceptance remains pending.
* Update Flutter/Dart dependencies and Linux desktop build support, including
  GTK dependency checks and the Snap VS Code environment fix.
* Improve image/video resource handling and transition rendering; preserve
  FixedAnimationController behaviour, original image quality and dense mosaic grids.
* Correct Cube, Tablet, Flip and Zoom Out transforms for the 2560×1600 display.
* Add the standalone automatic Raspberry Pi benchmark app with OpenGL/Vulkan
  suites, large media fixtures, telemetry, visual audits and portable reports.
* Skip unsupported Vulkan video by default, with an explicit opt-in for future
  runtimes. Preserve native crash and cleanup errors in aggregated reports.
* Document RaPi5 deployment, unattended test runs, flutter-pi source locations,
  performance validation, agent workflow and DEB release/version handling.
* Synchronize backend/frontend release versions to 10.0.0+2. Native OpenGL
  video-to-video crashes remain under investigation; flutter-pi changes,
  device firmware updates and the 24-hour soak test are deferred.

Build verification and remaining hardware limitations are recorded in
[the release record](doc/release-10.0.0.md).

# 9.5.3+2
Fix QRCode in Config and OTA pages

# 9.5.3
Fix critical issue in Config and OTA pages

# 9.5.2
Fix CurrentTimeWidget background
Fix ButtonsHint colors
Add ButtonsHint on main screen

# 9.5.1
Fix SystemMetricsWidget padding
Fix menu size

# 9.5.0
Added display info
Fix Config, OTA screen
Fix ButtonHint size
Fix SystemMetricsWidget size

# 9.4.5
Fix SlideshowPreview
Fix CubeEffect
Fix AccordionEffect
Fix BackgroundToForegroundEffect
Fix ForegroundToBackgroundEffect
Revert LiquidMorphEffect

# 9.4.0
Added http cache-control for media files
Optimize LiquidMorphEffect
Fix BlindsEffect

# 9.3.0
Added Single Item View in Gallery

# 9.2.0
The settings save values ​​other than the default values.

# 9.1.0
Support web upload files

# 9.0.1
New menu UX

# 9.0.0
Migrate SlideShowPage to StatelessWidget
SlideshowPreview: displayTime = 1000ms

# 8.4.6
New UX for OTA page

# 8.4.5
Fix CPU title
Multiple sensor support

# 8.4.4
update UI for system info

# 8.4.3
Fix disk free data for new RaPi OS Image

# 8.4.2
fix Wifi remove

# 8.4.1
fix WiFi scan

# 8.4.0
fix add\delete wifi network

# 8.3.0+4
Implement auto update

# v8.2.0+7
Increased QR Code size

# v8.2.0+5
Fix upload files.
Fix login page.
Fix restart app.

# v8.1.0+2
New OTA UI
New Config UI

# v8.0.0+3
New config UI.
Gallery.
Upload files.

# v7.3.0+19
Fix DPMS.
Support folders and sub-folders

# v7.2.0+1
First public release
More [info](https://github.com/DisDis/article-dslideshow)
