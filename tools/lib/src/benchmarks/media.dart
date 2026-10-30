import 'dart:io';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as image;
import 'package:path/path.dart' as p;

import 'json_io.dart';

image.Image benchmarkPhoto(int width, int height, int tone, math.Random random) {
  final photo = image.Image(width: width, height: height);
  for (var y = 0; y < height; y++) {
    image.drawLine(
      photo,
      x1: 0,
      y1: y,
      x2: width - 1,
      y2: y,
      color: image.ColorRgb8(30 + (y / height * 180).toInt(), 75 + tone * 80, 190 - tone * 90),
    );
  }
  for (var i = 0; i < 2400; i++) {
    final x = random.nextInt(width), y = random.nextInt(height), radius = random.nextInt(48) + 2;
    color() {
      return image.ColorRgb8(random.nextInt(256), random.nextInt(256), random.nextInt(256));
    }

    image.fillCircle(photo, x: x + radius ~/ 2, y: y + radius ~/ 2, radius: radius ~/ 2, color: color());
  }
  final white = image.ColorRgb8(255, 255, 255);
  for (var x = 0; x < width; x += 64) {
    image.drawLine(photo, x1: x, y1: 0, x2: x, y2: height - 1, color: white);
  }
  for (var y = 0; y < height; y += 64) {
    image.drawLine(photo, x1: 0, y1: y, x2: width - 1, y2: y, color: white);
  }
  image.drawRect(
    photo,
    x1: width ~/ 3,
    y1: height ~/ 3,
    x2: width * 2 ~/ 3,
    y2: height * 2 ~/ 3,
    color: white,
    thickness: 12,
  );
  return photo;
}

Future<Map<String, dynamic>> generateMedia(Directory folder) async {
  folder.createSync(recursive: true);
  final random = math.Random(42), entries = <Map<String, dynamic>>[];
  for (final (name, width, height, tone) in [
    ('photo_a.jpg', 4032, 3024, 0),
    ('photo_b.jpg', 6000, 4000, 1),
    ('photo_large.jpg', 8000, 6000, 0),
  ]) {
    final photo = benchmarkPhoto(width, height, tone, random);
    File(p.join(folder.path, name))
        .writeAsBytesSync(image.encodeJpg(photo, quality: 93, chroma: image.JpegChroma.yuv444));
    entries.add({'name': name, 'kind': 'image', 'width': width, 'height': height, 'role': p.withoutExtension(name)});
  }
  final encoder = image.GifEncoder(repeat: 0);
  for (var i = 0; i < 24; i++) {
    final frame = image.Image(width: 480, height: 270);
    image.fill(frame, color: image.ColorRgb8(15, 25, 60));
    for (var j = 0; j < 8; j++) {
      final x = (190 + 150 * math.cos((i + j * 3) / 24 * 2 * math.pi)).toInt(),
          y = (110 + 70 * math.sin((i + j * 3) / 24 * 2 * math.pi)).toInt();
      image.fillRect(
        frame,
        x1: x,
        y1: y,
        x2: x + 70,
        y2: y + 50,
        color: image.ColorRgb8(30 * j, 200 - j * 15, 150 + j * 10),
      );
    }
    encoder.addFrame(frame, duration: 10);
  }
  File(p.join(folder.path, 'animation.gif')).writeAsBytesSync(encoder.finish()!);
  entries.add({'name': 'animation.gif', 'kind': 'gif', 'width': 480, 'height': 270, 'frames': 24});
  for (final (name, filter) in [('video_a.mp4', 'null'), ('video_b.mp4', 'hflip,hue=h=45')]) {
    final args = [
      '-hide_banner',
      '-loglevel',
      'error',
      '-y',
      '-f',
      'lavfi',
      '-i',
      'testsrc2=size=1920x1080:rate=30',
      '-t',
      '8',
      '-vf',
      filter,
      '-c:v',
      'libx264',
      '-threads',
      '2',
      '-preset',
      'veryfast',
      '-crf',
      '25',
      '-pix_fmt',
      'yuv420p',
      '-movflags',
      '+faststart',
      '-an',
      p.join(folder.path, name),
    ];
    final process = await Process.run('ffmpeg', args);
    if (process.exitCode != 0) {
      throw ProcessException('ffmpeg', args, 'Fixture video encoding failed', process.exitCode);
    }
    entries.add({
      'name': name,
      'kind': 'video',
      'width': 1920,
      'height': 1080,
      'fps': 30,
      'duration_seconds': 8,
      'codec': 'h264',
      'pixel_format': 'yuv420p',
    });
  }
  for (final entry in entries) {
    final file = File(p.join(folder.path, entry['name'] as String));
    entry['bytes'] = file.lengthSync();
    entry['sha256'] = (await sha256.bind(file.openRead()).first).toString();
  }
  final manifest = {
    'seed': 42,
    'generator': 'dart-image-v2',
    'random_algorithm': 'Dart Random, pinned SDK',
    'files': entries,
  };
  writeJson(File(p.join(folder.path, 'manifest.json')), manifest);
  return {
    'files': entries.length,
    'total_bytes': entries.fold<int>(0, (n, e) => n + (e['bytes'] as int)),
    'generator': 'dart-image-v2',
  };
}
