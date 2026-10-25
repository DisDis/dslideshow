import 'dart:math';

import 'package:flutter/foundation.dart';

enum MosaicDirection { random, topLeft, topRight, bottomLeft, bottomRight }

enum MosaicBackend { canvas, shader }

/// Immutable schedule shared by the Canvas and GPU implementations.
@immutable
class MosaicSchedule {
  final int gridSize;
  final double fadeFraction;
  final List<double> startTimes;
  late final List<int> _canvasOrder = List.unmodifiable(
    List.generate(startTimes.length, (i) => i)
      ..sort((a, b) => startTimes[a].compareTo(startTimes[b])),
  );

  /// Reused by Canvas masks; callers can warm the order before animation starts.
  /// Shader masks need no sorted CPU data and leave it unallocated.
  List<int> prepareCanvasOrder() => _canvasOrder;

  MosaicSchedule({
    int gridSize = 100,
    double fadeFraction = 0.3,
    MosaicDirection direction = MosaicDirection.random,
    int? seed,
  }) : assert(gridSize > 0),
       assert(fadeFraction >= 0 && fadeFraction <= 1),
       gridSize = gridSize,
       fadeFraction = fadeFraction,
       startTimes = List.unmodifiable(
         _generate(gridSize, fadeFraction, direction, seed),
       );

  static List<double> _generate(
    int grid,
    double fade,
    MosaicDirection direction,
    int? seed,
  ) {
    final random = Random(seed);
    return List.generate(grid * grid, (index) {
      final col = index % grid;
      final row = index ~/ grid;
      if (direction == MosaicDirection.random) {
        return random.nextDouble() * (1 - fade);
      }
      final distance = switch (direction) {
        MosaicDirection.topLeft => col + row,
        MosaicDirection.topRight => grid - 1 - col + row,
        MosaicDirection.bottomLeft => col + grid - 1 - row,
        MosaicDirection.bottomRight => 2 * (grid - 1) - col - row,
        MosaicDirection.random => 0,
      };
      final position = grid == 1 ? 0.0 : distance / (2 * (grid - 1));
      return (position * 0.8 + random.nextDouble() * 0.2) * (1 - fade);
    });
  }

  int alphaAt(int index, double progress) {
    if (progress <= 0) return 255;
    if (progress >= 1) return 0;
    final start = startTimes[index];
    if (fadeFraction == 0) return progress < start ? 255 : 0;
    return ((1 - (progress - start) / fadeFraction).clamp(0.0, 1.0) * 255)
        .round();
  }

  /// 24-bit threshold precision; the texture is uploaded only once per mask.
  Uint8List encodeThresholds() {
    final bytes = Uint8List(startTimes.length * 4);
    for (var i = 0; i < startTimes.length; i++) {
      final value = (startTimes[i] * 0xffffff).round();
      bytes[i * 4] = value >> 16;
      bytes[i * 4 + 1] = value >> 8;
      bytes[i * 4 + 2] = value;
      bytes[i * 4 + 3] = 255;
    }
    return bytes;
  }
}
