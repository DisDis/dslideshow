# Unreleased

* Add a standalone local Ambient API probe for device OAuth, album-source
  selection, paginated media listing and photo/video downloads. Preserve
  backend code; add resumable private state, bounded downloads, diagnostics,
  loopback HTTP regressions and local setup documentation.

* Record the deferred three-level RPC contract coverage checks and a proposed
  Google Photos client/FFmpeg thumbnail implementation plan; implementation
  of these plans remains pending.

* Generate the RPC serializer registry from @RpcSerializers using a separate
  local rpc_serializers_generator build_runner package. Preserve all 57 wire
  tags and codec behavior, remove the stale CLI registry generator, and add
  builder/codec regressions, pre-build tests and generation documentation.

* Extract frame snapshot collection and frontend-state request coalescing into
  FrameStateReader. Preserve isolate boundaries, shared frontend deadlines,
  control acknowledgement freshness and shutdown behavior; add local reader
  and RPC race regressions and update backend documentation.

* Extract WebSocketUser into its own file and device-event subscriptions into
  DeviceEventBindings. Preserve isolate boundaries, event mapping, logging and
  cleanup order; add protocol/subscription regressions and backend documentation.

# 12.0.0+2 — 2026-10-27

* Run production package and build-tool tests automatically before DEB staging,
  version increments and compilation. Stop on failure, preserving previous
  staging and versions; add failure-propagation and packaging regressions.

* Speed up new Linux gallery cache entries by completing writes and atomic
  publication without per-file durability flushes. Increase the native encoded
  cache to 512 MiB / 2048 objects and document power-loss recovery limits.
  Abort failed HTTP-to-cache transfers and cover corruption recovery, capacity
  and cleanup. Keep returning consumers and cancelling prefetches behind actual
  transport cleanup; preserve original media and server thumbnail generation.

* Increase the default server thumbnail disk cache to 512 MiB / 2048 objects.

* Remove synchronous metadata rewrites/fsync from Linux gallery cache hits.
  Keep live LRU updates in memory and coalesce advisory recency at backing close,
  preserving atomic payload publication, bounded storage and decoder pins.
  Add warm-hit/read-only metadata regressions and a frozen native-cache probe.

* Add RPC telemetry per direction: occupied slots, waiting requests, peaks,
  counters/rates, durations, oldest requests and receiver handlers. Collect
  snapshots through ordinary shared RPC slots, coalesce slow reads and retain
  stale data. Add localized telemetry details and panel WebSocket timeout counts.

* Increase the default inter-isolate RPC capacity from 5 to 25 outstanding
  requests per direction, preserving explicit limits and existing timeout
  behavior. Add a regression for saturation and slot reuse.

* Add lazy server gallery thumbnails and a revisioned catalog while preserving
  originals for fullscreen and the frame. Share a viewport-prioritized image
  queue with cancellation, single-flight, bounded encoded caches and decode
  admission across gallery routes. Publish uploads/GooglePhoto atomically with
  persistent revisions; add conditional/Range/CORS responses, resource budgets,
  lifecycle regressions and frozen local HTTP/Chrome comparisons. Raspberry Pi
  performance and visual acceptance remain pending a separate hardware run.

* Add authenticated frame telemetry and remote pause/resume, menu and screen
  controls to config_app. Read presence from the MQTT source and report actual
  frame software/display details, screen transitions and stale samples. Bound
  polling to visible pages, confirm control intent, handle timeouts without
  replaying commands, and cover protocol, lifecycle and localized adaptive UI
  with local tests. Hardware checks are excluded by agreement.

* Report measured Raspberry Pi 5 fan RPM through the existing sensor script,
  DTOs and widget. Discover the board tachometer without a fixed hwmon index;
  omit unavailable readings, preserve valid zero RPM and other sensors, and
  log partial collection diagnostics. Add local sysfs, RPC and widget regressions.

* Add Linux desktop video playback to config_app with a media_kit/libmpv
  backend while retaining video_player_web for browsers. Handle gallery player
  errors, bounded initialization, seeking, late results and controller cleanup;
  stop failed video previews and guard them when a backend is unavailable.
  Hidden gallery overlays no longer intercept player controls.

* Fix replaying the welcome preview throwing a Flutter assertion with an
  explicitly synchronous replay handler that keeps TickerFuture out of setState;
  cover replay during forward/reverse playback and after completion.

* Add configurable snapshot timeouts and localized no-image placeholders to
  special camera screens, including failed refreshes and recovery. Add separate
  bundled time/date fonts and an optional localized weekday to clock screens,
  with live configuration previews and compatible compact JSON defaults.

* Refresh config_app with adaptive navigation, shared light/dark/system themes,
  complete English/Russian localization and session appearance preferences that
  preserve the active route and draft. Add a persistent Save/Undo bar, readable
  validated forms and masked secrets. Provide adaptive live slideshow, welcome
  and special-screen previews with device-scale composition and bounded cleanup.
  Localize the media, Wi-Fi, OTA and power screens and cover UI state/lifecycle
  regressions without changing the photoframe renderer or runtime.

* Fix config_app startup getting stuck on `/splash` when authentication status
  arrives before the UI mounts. Resolve login/home from the current state in
  the router and remove delayed splash navigation; cover startup transitions.

* Make backend media selection linear over a full random cycle and build disk
  indexes asynchronously with serialized selection and lifecycle guards.
  Coalesce SystemInfo requests, reuse short-lived snapshots and bound system
  commands while preserving metric DTOs and legacy missing-value behaviour.
  Reduce routine RPC/WebSocket logging and add local backend regressions and
  baseline/candidate measurements without changing frontend rendering.

* Keep config_app edits in an isolated in-memory draft, serialize Save/Reload,
  acknowledge successful writes and retain drafts on operation errors. Confirm
  discard on navigation, logout and reload; guard browser unload and disable
  pointer/keyboard editing during requests. Download the saved configuration
  from disk while preserving active services until an application restart.
  Add backend, widget, navigation and Chrome DOM regressions.

* Stream media and manual/automatic OTA downloads into temporary files, enforce
  actual byte and concurrency limits, and await close before atomic publication.
  Authenticate legacy OTA uploads before the file body, serialize installation,
  and add local failure/lifecycle regressions with a fake installer.

* Harden config_app WebSocket/RPC connection ownership, client close codes,
  handshake/request timeouts and cleanup. Cancel stale authentication attempts,
  handle network-operation failures, and remove sensitive payloads from client
  diagnostics. Add lifecycle/error regressions and the staged improvement plan.

Build verification and remaining hardware limitations are recorded in
[the release record](doc/release-12.0.0.md).

# 10.1.0+1 — 2026-10-25

* Align generated clock JSON defaults with the configured 50% time font size;
  preserve explicit sizes and cover compact save/reload without default drift.
* Add Noise Dissolve, circular Ripple Reveal and photo-only Water Refraction
  with localized wave-front displacement and full-quality image sampling.
  Filter transitions by media capability before selection/preparation.
* Add opt-in Ken Burns photo motion, bounded pause/sleep/resume and stable camera
  ownership across transitions; retain extra prepared pixels for zoom quality.
  Add typed configuration, localized controls, previews and lifecycle regressions.
* Add focused OpenGL photo/GIF/video and visual suites in the separate benchmark
  application, including camera-specific audits and explicit unsupported media.

* Batch LiquidMorph path vertices without changing wave geometry, sampling or
  source lifetimes; verify lower UI cost with reverse-order RaPi5 OpenGL A/B.
  Retain the original Accordion after its grouped-transform experiment failed
  to show a repeatable gain. Add opt-in composition controls, pixel regressions
  and focused photo/GIF/video suites; report raster bottlenecks separately.

* Hold the screen black for 2000 ms after a successful hardware ON before fading
  in. Keep the delay in ScreenService.wakeUpDelay; preserve cancellation,
  duplicate-event handling and manual sleep priority during display warm-up.
  Derive wake-delay regression timings from the constant so it can be tuned
  without retaining assumptions about the earlier 500 ms delay.

* Reduce Canvas Mosaic/MosaicFade mask work by sorting thresholds during
  preparation and drawing exact alpha groups as points. Preserve dense grids,
  cell boundaries, original schedules and FixedAnimationController behaviour.
* Add opt-in mosaic drawing probes and focused RaPi5 OpenGL photo/GIF/video
  suites; audit every selected grid with full-resolution RGBA fingerprints.
* Add an explicit, cancellable fadingIn screen phase after hardware wake and
  fade-out reversal. Preserve manual sleep priority and the original reveal
  deadline across brief presence changes; initialize sleeping renderers black.
* Add backend and widget regressions for full wake, reverse transitions, duplicate
  ON events, stale completion and cleanup. Physical frame validation is pending.

Build verification and remaining hardware limitations are recorded in
[the release record](doc/release-10.1.0.md).

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
