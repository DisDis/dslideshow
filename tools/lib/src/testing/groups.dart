import 'dart:io';

import 'package:path/path.dart' as p;

enum TestGroup {
  effects,
  slideshowMedia,
  gallery,
  ota,
  network,
  settings,
  hardware,
  localization,
  toolingProtocol,
  unclassified,
}

extension TestGroupName on TestGroup {
  String get cliName => switch (this) {
    TestGroup.slideshowMedia => 'slideshow-media',
    TestGroup.toolingProtocol => 'tooling-protocol',
    _ => name,
  };
}

TestGroup? parseTestGroup(String value) {
  for (final group in TestGroup.values) {
    if (group.cliName == value) return group;
  }
  return null;
}

const testPackages = [
  'common',
  'rpc_serializers_generator',
  'backend',
  'tools',
  'i18n',
  'system_metrics_widget',
  'dslideshow_flutter',
  'config_app',
];

// Primary contracts are assigned explicitly. A file can belong to one group;
// unknown files remain visible until their contract is added to this catalogue.
const _contracts = <String, Map<TestGroup, List<String>>>{
  'common': {
    TestGroup.effects: ['effect_presets', 'effects'],
    TestGroup.gallery: ['gallery_management', 'gallery_catalog'],
    TestGroup.toolingProtocol: ['encode_decode', 'rpc_capacity', 'log', 'rpc_telemetry'],
  },
  'rpc_serializers_generator': {
    TestGroup.toolingProtocol: ['builder'],
  },
  'backend': {
    TestGroup.effects: ['effects_config', 'photo_motion_config'],
    TestGroup.slideshowMedia: [
      'frame_state',
      'frame_commands',
      'frame_state_reader',
      'special_screen_config',
      'app_storage',
      'disk_storage',
      'cloud_storage_hardware',
      'disk_storage_hidden',
      'googlephoto_hidden',
      'storage_provider_registry',
      'yandex_drive_provider_commands',
      'yandex_drive_scheduler',
      'yandex_drive_storage',
    ],
    TestGroup.gallery: [
      'gallery_tool_runner',
      'gallery_googlephoto_publication',
      'cloud_storage_publication',
      'gallery_config',
      'gallery_media_tools',
      'ffmpeg_thumbnail_worker',
      'gallery_file_operations',
      'gallery_http',
      'gallery_catalog_admission',
      'media_file_responder',
      'gallery_catalog',
      'thumbnail_service',
      'streaming_upload',
      'gallery_png_rotation',
      'gallery_duplicate_service',
      'gallery_metadata_reader',
      'gallery_management_http',
      'gallery_duplicate_cli',
      'media_upload',
      'gallery_hidden',
    ],
    TestGroup.ota: ['ota_config_transfer', 'ota', 'ota_upload'],
    TestGroup.network: [
      'frame_discovery',
      'web_socket_config',
      'web_socket_user',
      'wifi_rpc_completion',
      'mqtt_service',
      'ifconfig_parsing',
      'web_server_control',
      'wifi_service',
      'wifi_service_diagnostics',
      'yandex_drive_api',
      'yandex_drive_service',
    ],
    TestGroup.settings: ['config', 'saved_config_repository'],
    TestGroup.hardware: [
      'system_command_runner',
      'device_event_bindings',
      'presence_filter',
      'system_info_service',
      'screen_service',
      'system_info_rpc',
      'hardware_screen',
      'screen_power',
    ],
    TestGroup.toolingProtocol: ['rpc_telemetry_protocol', 'json_parsing', 'serializers', 'json_strip', 'drive_rpc'],
  },
  'i18n': {
    TestGroup.localization: ['localizations'],
  },
  'system_metrics_widget': {
    TestGroup.hardware: ['os_info_widget', 'sensors_info_widget'],
  },
  'dslideshow_flutter': {
    TestGroup.effects: [
      'wave_origin',
      'effect_slide_input',
      'effect_parameter_rendering',
      'composition_effect',
      'effect_settings',
      'photo_shader_effects',
      'effect_regression',
      'zoom_blur_effect',
      'effect_rotation_coverage',
      'premiere_transitions',
      'new_visual_effects',
      'creative_transitions',
      'radial_blur_effect',
      'scaling_sampling',
      'effect_perspective_bounds',
      'mosaic_optimization',
      'retained_filter_cache',
      'photo_motion_renderer',
    ],
    TestGroup.slideshowMedia: [
      'buttons_hint',
      'camera_snapshot_client',
      'frame_frontend_controller',
      'slide_session',
      'slideshow_storage_error',
      'transition_media_selection',
      'special_screen_scheduler',
      'frontend_service',
      'special_screen_widget',
      'video_session',
      'slideshow_renderer_lifecycle',
      'screen_transition',
      'clock_screen_widget',
      'special_slideshow',
      'image_preparation',
      'special_screen_lifecycle',
      'camera_unavailable',
      'main_menu_bloc',
    ],
    TestGroup.ota: [
      'terminal_backend',
      'ota_bloc',
      'ota_terminal_panel',
      'ota_ready_paint',
      'ota_failure_return',
      'ota_view',
    ],
    TestGroup.settings: ['config_bloc', 'config_access_session', 'config_view', 'config_timeout', 'config_ready_paint'],
    TestGroup.localization: ['frame_language'],
  },
  'config_app': {
    TestGroup.effects: [
      'premiere_transitions_preview',
      'visual_editor_preview',
      'effects_editor',
      'effect_settings_validation',
      'argb_color_field',
      'slideshow_preview',
    ],
    TestGroup.slideshowMedia: [
      'special_screens',
      'asset_photo_slide_session',
      'linux_video_player',
      'special_screen_options',
      'video_backend',
      'single_video_player',
    ],
    TestGroup.gallery: [
      'gallery_mutation_confirmation',
      'gallery_trash_bulk',
      'upload_screen',
      'gallery_duplicates_bloc',
      'gallery_comparison_metadata_ui',
      'gallery_duplicate_diagnostics',
      'gallery_http_transport',
      'gallery_notifications',
      'gallery_selection_visual',
      'video_grid_item',
      'upload_queue_bloc',
      'gallery_management_repository',
      'gallery_repository',
      'gallery_video_visibility',
      'gallery_undo_bloc',
      'gallery_image_widget',
      'single_item_viewer_page',
      'gallery_viewer_design',
      'gallery_image_loader',
      'gallery_viewport',
      'gallery_management_bloc',
      'gallery_dialog',
      'gallery_fullscreen_revision',
      'gallery_viewer_bloc',
      'gallery_encoded_cache',
      'gallery_file_size',
      'gallery_group_comparison_bloc',
      'gallery_file_path',
      'upload_picker',
      'gallery_bloc',
      'gallery_management_ui',
      'gallery_duplicates_compact_ui',
      'gallery_hidden',
      'android_documents',
      'upload_selection',
    ],
    TestGroup.ota: ['ota_panel_widget', 'ota_client', 'ota_panel_bloc'],
    TestGroup.network: [
      'frame_discovery_bloc',
      'backend_version',
      'login_discovery',
      'client_service',
      'wifi_tab_bloc',
      'web_client',
      'authentication_repository',
      'authentication_bloc',
      'login_bloc',
      'android_frame_discovery',
    ],
    TestGroup.settings: [
      'config_navigation',
      'config_bloc',
      'config_screen',
      'app_preferences',
      'settings_widgets_ui',
      'settings_forms',
      'config_draft',
      'app_startup',
      'yandex_drive_settings',
    ],
    TestGroup.hardware: ['device_page', 'media_device_ui', 'device_monitor', 'power_bloc'],
    TestGroup.toolingProtocol: ['rpc_rates', 'rpc_telemetry_widget'],
  },
};

/// Normalizes reporter file URIs and package-relative paths, rejecting escapes.
String? normalizeTestSuite(Directory root, String package, String value) {
  if (!testPackages.contains(package)) return null;
  var path = value;
  final uri = Uri.tryParse(value);
  if (uri != null && uri.hasScheme) {
    if (uri.scheme != 'file' || uri.host.isNotEmpty) return null;
    try {
      path = uri.toFilePath();
    } on ArgumentError {
      return null;
    }
  }
  final packagePath = p.normalize(p.absolute(root.path, package));
  final absolute = p.normalize(p.isAbsolute(path) ? path : p.join(packagePath, path));
  if (!p.isWithin(p.join(packagePath, 'test'), absolute) || !absolute.endsWith('_test.dart')) return null;
  return p.posix.joinAll(p.split(p.relative(absolute, from: packagePath)));
}

TestGroup testGroupForSuite(Directory root, String package, String suite) {
  final normalized = normalizeTestSuite(root, package, suite);
  if (normalized == null) return TestGroup.unclassified;
  // This package's contracts are tools and their protocols, except the sensor
  // script contract. Nested tooling suites remain tooling when added later.
  if (package == 'tools') {
    return normalized == 'test/system/sensors_test.dart' ? TestGroup.hardware : TestGroup.toolingProtocol;
  }
  for (final entry in (_contracts[package] ?? {}).entries) {
    if (entry.value.any((name) => normalized == 'test/${name}_test.dart')) return entry.key;
  }
  return TestGroup.unclassified;
}

List<String> allTestSuites(Directory root, String package) {
  if (!testPackages.contains(package)) throw ArgumentError.value(package, 'package', 'Unknown package');
  final directory = Directory(p.join(root.path, package, 'test'));
  if (!directory.existsSync()) return [];
  final paths =
      directory
          .listSync(recursive: true, followLinks: false)
          .whereType<File>()
          .map((file) => normalizeTestSuite(root, package, file.absolute.path))
          .whereType<String>()
          .toList()
        ..sort();
  return paths;
}

List<String> testSuitesForGroup(Directory root, String package, TestGroup group) =>
    allTestSuites(root, package).where((suite) => testGroupForSuite(root, package, suite) == group).toList();
