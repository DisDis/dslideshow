# Unreleased

* Build the gallery index in memory with path-derived IDs and stat-derived
  revisions. Keep only a 32-byte catalog.epoch for forced invalidation, preserve
  unchanged cache keys across restarts, and remove catalog.json and serverId.

* Rotate through a validated temporary file and atomic replacement without a
  persistent request journal. Reject stale revisions and refresh the viewer
  after an unknown result before a new user action.

* Mark the in-memory gallery catalog dirty after uploads, rotations, trash and
  restore in the web isolate. Remove GalleryPublication and publication.version;
  retain watcher/periodic stat scans for external changes. Google Photos is not
  part of the notification path. Remove compatibility for unreleased trash layouts.

* Review duplicates as a list of up to ten files per page, keeping selections
  between pages and confirming every move to trash. Validate groups on opening,
  omit unavailable members and skip groups with fewer than two current files.
  Keep user decisions in memory; remove backend JSON byte caps for Czkawka results.
  Collapse repeated member sets across search modes, preferring exact matches
  while preserving broader similar groups.

* Replace verbose web request traces with concise response/error messages without
  phase or duration measurements.

* Simplify trash and restore moves to asynchronous File.rename with a target
  existence check, removing the Linux FFI wrapper. Accept the race with external
  writers between the check and rename; keep service mutations serialized.

* Store trash inside images.gallery/trash as a plain directory tree matching
  the original relative paths,
  without a manifest or persistent operation history. Add Select all and Empty
  trash with a confirmation, bounded batches and progress; refresh filesystem
  contents after an unknown response before the next action.

* Confirm moving files to trash from the grid, viewer and duplicate results, binding approval to
  the selected file versions. Distinguish image retries from metadata retries
  in duplicate comparisons and show details-loading errors explicitly.

* Read photo metadata in Dart with exif and rotate PNG images with image,
  normalizing PNG EXIF orientation and dimensions. Keep jpegtran output unchanged,
  compare parsed JPEG EXIF before/after and warn on differences without exposing
  tag values. Report actual dimensions and remove the ExifTool runtime dependency.

* Fix trash operations with configured media-directory symlinks in the local
  backend harness. Keep decoded photos visible while selecting files or opening
  dialogs, align gallery/viewer styling with the app, and limit file previews
  in operation dialogs to ten names plus the total count.

* Keep gallery selection controls visible at zero selection and add a close
  button and timeout to Undo notifications. Match Czkawka reports against
  canonical paths and show concrete search errors and candidate/result counts.
  Use the Web log level in the local backend harness and trace HTTP phases.

* Add gallery file management: move selected media to a separate trash, restore
  files without overwriting name conflicts, and confirm permanent deletion.
  Show detailed EXIF metadata inside the media viewer and rotate JPEG images
  losslessly with jpegtran or PNG images with Dart image.

* Find exact and visually similar photos through Czkawka CLI, with background
  search, cancellation, image comparison and manual selection of copies for
  trash. Reject stale selections and preserve a remaining copy in each group.

* Move gallery workflows into Bloc with stateless screens and indexed catalog
  snapshots for libraries of 50,000+ media files. Keep image demand bounded by
  the viewport and resolve individual trash previews without listing the trash.

* Add correlated, bounded gallery diagnostics for file operations, rotation,
  duplicate search and cancellation. Make safe, useful logs an acceptance
  requirement for future behavior changes.

# 15.2.0+1 — 2026-10-29

* Keep Louver media clipped to each rotating slat near edge-on angles, preventing
  full-image flashes behind the slats while preserving seamless flat endpoints.

# 15.1.0+1 — 2026-10-29

* Clarify the frame's OTA stages with larger receiving, installation and restart
  icons, a three-step sequence and an explanation while the installation log
  is empty. Keep the status card and log position stable, including at 100%
  transfer, distinguish installation success from restart and show how to return
  to the slideshow after an error. Update the English and Russian labels.

# 15.0.0+1 — 2026-10-29

* Keep the OTA connection QR, bold access code and red current version large;
  show installation output across the frame with a 32 px terminal font, pause
  auto-scroll while reading history and provide a return-to-latest action.
  Show percentages only for file transfer and preserve the active update stage
  when opening OTA or receiving delayed initialization responses.

* Add a saved frame interface language (`system`, `en`, `ru`) to JSON settings
  and the settings panel, defaulting to English. Apply it after restarting the frame application;
  keep the panel's own session language independent.

* Return an OTA error page for an incorrect firmware code after discarding the
  rejected upload, avoiding a connection reset during normal file transfer.

* Keep OTA installation log lines aligned at the left edge on the frame while
  preserving progress updates within the current line.

* Add self-contained Russian/English OTA pages with firmware upload, configuration
  backup/import and a return-to-slideshow action. Preserve damaged configuration
  downloads and replace imported settings atomically after validation; apply them
  on the next restart.

* Build the web settings panel with WebAssembly and skwasm by default, retaining
  JavaScript/CanvasKit fallback. Fix web environment initialization for Wasm.

# 14.1.0+1 — 2026-10-28

* Run slideshow and effect previews on bundled sample photos without external
  media downloads or a video URL field. Keep draft settings, pause and Repeat
  available while disconnected from the frame.

* Reuse sampling coordinates for matching prepared photos in nine-ray Radial
  Blur. Preserve all rays, resolution and independent photo-motion sampling.
* Cache stable tinted photo inputs in VHS Damage before the animated blend.
  Preserve the original live-media path.

# 14.0.0+1 — 2026-10-28

* Breaking settings change: replace slideshow.allowedEffects and
  slideshow.transitionTimeMs with slideshow.effects. Old fields are ignored;
  without the new block the frame uses Fade. Re-select effects and timing
  in the new settings catalog after updating.

* Improve photo transition performance by caching prepared photos and Phosphor
  trails, bounding Radial Blur/Glass blend surfaces and reducing Water Refraction
  texture lookups. Preserve full-resolution photos and dense Mosaic grids.

* Use retained high-quality scaling for Stretch and CrossZoom, and a
  full-resolution nine-ray Radial Blur shader for prepared photo transitions.
  Preserve outgoing photo motion and live GIF/video composition.

* Fuse Glass refraction and linear-light Film Dissolve into full-resolution
  photo shaders. Preserve effect options, photo motion and live media fallback.

* Consolidate transition effects into 37 catalog families with 82 built-in
  presets, including Slice/Panel Wipe. Add typed visual settings, localized preset
  selection, dependent controls, five Water/Ripple origins and deterministic
  legacy-family normalization. Preserve disabled options, personal timing,
  dense mosaics and full-quality photo refraction.

* Skip unknown special-screen types while parsing settings and log the omission.
  Keep nested camera drafts isolated from the saved configuration.

* Store per-effect settings in an immutable map keyed by EffectType; remove
  the redundant type field from EffectConfig. Validate fields and Save in
  config_app. Omit default values and empty sections from effect, special-screen,
  schedule and camera JSON while preserving required identities and sources.
  Use Fade for absent or empty effect selections on the frame.

* Add a shared ARGB ColorPicker with alpha and Apply/Cancel to effect, slideshow
  background and clock settings. Preserve incomplete manual input and close
  owned dialogs on disposal. Recover invalid stored effect options without
  building invalid controls; keep overflowing JSON numbers diagnosable and
  serializable while config_app blocks invalid Save before sending.

* Edit and display effect durations as integer milliseconds in the settings
  catalog, including global/custom timing and RU/EN labels.

* Match global/custom duration field spacing in the effect editor and reserve
  preview loading indicator space to prevent layout shifts.

* Add a searchable adaptive effect settings catalog and shared photo-to-photo
  preview with a Repeat button. Retain custom options for disabled effects,
  support inherited or personal timing and validate changes before Save.

* Add Burn Alpha, Fold Motion, Glow, Kaleidoscope, TV Power, Spring Motion,
  Shape Dissolve, VHS Damage, Radial Blur and Phosphor to the frame and settings
  preview, with Russian/English labels and shared live media sessions.

# 13.1.0+1 — 2026-10-27

* Add linear-light Film Dissolve, Frame, Louver, Mirror and Neon Wipe to the
  frame and settings preview, with Russian/English labels and shared live media
  sessions.

* Add Clock Wipe, Split, Panel Wipe, Stretch and Star Wipe to the frame and
  settings preview, with Russian/English labels, live media layers and shared
  video sessions.

* Add Light Leak, Film Roll, Cross Zoom, Whip and faceted Glass to the frame
  and settings preview, with localized labels, live GIF/video composition and
  shared video sessions.

* Add Soft Wipe, Light Sweep, Slice, Luma Fade and Page Peel to the shared
  slideshow registry and settings preview, with Russian/English labels and
  live GIF/video composition.

# 13.0.0+1 — 2026-10-27

* Fix FFmpeg 5.1 SIGSEGV while flattening thumbnail alpha: draw the opaque
  background in RGB before overlay and advance thumbnail policy to 4. Add gallery
  request/cache/catalog/process diagnostics with bounded native stderr, exit codes
  and timings; print supplied stack traces in console logs.

* Generate gallery thumbnails as JPEG through one FFmpeg process per job.
  Preserve EXIF and square sizes, flatten alpha on a configurable background,
  select representative animation/video frames and show video posters in the grid.
  Add gallery settings for thumbnail size, quality, frame selection, four default
  workers, queue/cache/timeout and media-stream limits. Include policy 3 and render
  settings in cache identities, use MD5 content ETags and discard old derivatives.
  Require FFmpeg at runtime for thumbnail generation.

# 12.0.0+2 — 2026-10-27

* Speed up new Linux gallery cache entries with atomic publication without
  per-file durability flushes. Increase the encoded cache to 512 MiB / 2048
  objects. Abort failed HTTP-to-cache transfers and wait for transport cleanup
  before returning consumers or cancelling prefetches. Preserve original media
  and server thumbnail generation.

* Increase the default server thumbnail disk cache to 512 MiB / 2048 objects.

* Remove synchronous metadata rewrites/fsync from Linux gallery cache hits.
  Keep live LRU updates in memory and coalesce advisory recency when the backing
  store closes, preserving atomic payload publication, bounded storage and decoder
  pins.

* Add RPC telemetry per direction: occupied slots, waiting requests, peaks,
  counters/rates, durations, oldest requests and receiver handlers. Collect
  snapshots through ordinary shared RPC slots, coalesce slow reads and retain
  stale data. Add localized telemetry details and panel WebSocket timeout counts.

* Increase the default inter-isolate RPC capacity from 5 to 25 outstanding
  requests per direction, preserving explicit limits and existing timeout
  behavior.

* Add lazy server gallery thumbnails and a revisioned catalog while preserving
  originals for fullscreen and the frame. Share a viewport-prioritized image
  queue with cancellation, single-flight, bounded encoded caches and decode
  admission across gallery routes. Publish uploads/GooglePhoto atomically with
  persistent revisions; add conditional/Range/CORS responses and resource budgets.

* Add authenticated frame telemetry and remote pause/resume, menu and screen
  controls to config_app. Read presence from MQTT and report actual frame
  software/display details, screen transitions and stale samples. Bound polling
  to visible pages, confirm control intent and handle timeouts without replaying
  commands.

* Report measured Raspberry Pi 5 fan RPM through the existing sensor script,
  DTOs and widget. Discover the board tachometer without a fixed hwmon index;
  omit unavailable readings, preserve valid zero RPM and other sensors, and
  log partial collection diagnostics.

* Add Linux desktop video playback to config_app with a media_kit/libmpv
  backend while retaining video_player_web for browsers. Handle gallery player
  errors, bounded initialization, seeking, late results and controller cleanup;
  stop failed video previews and guard them when a backend is unavailable.
  Hidden gallery overlays no longer intercept player controls.

* Fix replaying the welcome preview throwing a Flutter assertion during or
  after playback.

* Add configurable snapshot timeouts and localized no-image placeholders to
  special camera screens, including failed refreshes and recovery. Add separate
  bundled time/date fonts and an optional localized weekday to clock screens,
  with live configuration previews and compatible compact JSON defaults.

* Refresh config_app with adaptive navigation, shared light/dark/system themes,
  complete English/Russian localization and session appearance preferences that
  preserve the active route and draft. Add a persistent Save/Undo bar, readable
  validated forms and masked secrets. Provide adaptive live slideshow, welcome
  and special-screen previews with device-scale composition and bounded cleanup.
  Localize the media, Wi-Fi, OTA and power screens.

* Fix config_app startup getting stuck on `/splash` when authentication status
  arrives before the UI mounts. Resolve login/home from the current connection
  state and remove delayed splash navigation.

* Make backend media selection linear over a full random cycle and build disk
  indexes asynchronously with serialized selection and lifecycle guards.
  Coalesce SystemInfo requests, reuse short-lived snapshots and bound system
  commands while preserving metric DTOs and legacy missing-value behaviour.
  Reduce routine RPC/WebSocket logging.

* Keep config_app edits in an isolated in-memory draft, serialize Save/Reload,
  acknowledge successful writes and retain drafts on operation errors. Confirm
  discard on navigation, logout and reload; guard browser unload and disable
  pointer/keyboard editing during requests. Download the saved configuration
  from disk while preserving active services until an application restart.

* Stream media and manual/automatic OTA downloads into temporary files, enforce
  actual byte and concurrency limits, and await close before atomic publication.
  Authenticate legacy OTA uploads before the file body and serialize installation.

* Harden config_app WebSocket/RPC connection ownership, client close codes,
  handshake/request timeouts and cleanup. Cancel stale authentication attempts,
  handle network-operation failures and remove sensitive payloads from client
  diagnostics.

# 10.1.0+1 — 2026-10-25

* Align generated clock JSON defaults with the configured 50% time font size;
  preserve explicit sizes and compact save/reload without default drift.

* Add Noise Dissolve, circular Ripple Reveal and photo-only Water Refraction
  with localized wave-front displacement and full-quality image sampling.
  Filter transitions by media capability before selection/preparation.
* Add opt-in Ken Burns photo motion, bounded pause/sleep/resume and stable camera
  ownership across transitions; retain extra prepared pixels for zoom quality.
  Add typed configuration, localized controls and previews.

* Reduce LiquidMorph path-processing cost while preserving wave geometry,
  image sampling and source lifetimes.

* Hold the screen black for 2000 ms after a successful hardware ON before fading
  in. Preserve cancellation, duplicate-event handling and manual sleep priority
  during display warm-up.

* Reduce Canvas Mosaic/MosaicFade mask work by sorting thresholds during
  preparation and drawing exact alpha groups as points. Preserve dense grids,
  cell boundaries, original schedules and FixedAnimationController behaviour.
* Add an explicit, cancellable fadingIn screen phase after hardware wake and
  fade-out reversal. Preserve manual sleep priority and the original reveal
  deadline across brief presence changes; initialize sleeping renderers black.

# 10.0.0+2 — 2026-10-25

* Add extensible special slideshow screens with clocks and direct HTTP/HTTPS
  JPEG/PNG cameras, grid/round-robin playback, scheduling and lifecycle cleanup.
* Add config_app screen editors/previews and per-type default stripping on save.

* Fix camera cursor advancement, refresh deadlines and snapshot cancellation;
  retain pending screens and freeze transitions during pause/sleep. Preserve
  compact configuration serialization.

* Reduce ZoomOver opacity-layer bounds to the viewport while preserving visible
  pixels and animation curves.

* Reduce BlurFade compositing overhead with a composed Gaussian/alpha filter
  and explicit decal edges; preserve the original fade for zero sigma.

* Cancel screen sleep and reverse fading immediately when presence returns;
  serialize hardware power changes and ignore superseded asynchronous results.
  Preserve manual sleep priority and handle stale manual lock RPC responses.
* Replace dropped GPIO edges with immediate presence and confirmed absence;
  dispose screen timers and subscriptions.

* Improve image/video resource handling and transition rendering; preserve
  FixedAnimationController behaviour, original image quality and dense mosaic grids.
* Correct Cube, Tablet, Flip and Zoom Out transforms for the 2560×1600 display.

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
