import 'package:media_kit/media_kit.dart';

import 'linux_video_player.dart';

void registerLinuxVideoBackend() {
  MediaKit.ensureInitialized();
  ConfigAppLinuxVideoPlayer.registerWith();
}
