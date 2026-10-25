import 'dart:math' as math;

import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';

import '../sessions/cameras_screen_session.dart';

class CamerasScreenWidget extends StatelessWidget {
  final CamerasScreenSession session;
  const CamerasScreenWidget({super.key, required this.session});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: session,
    builder: (_, _) {
      final options = session.options;
      if (options.cameras.isEmpty) {
        return const ColoredBox(
          color: Colors.black,
          child: Center(child: Icon(Icons.videocam_off, color: Colors.white)),
        );
      }
      return ColoredBox(
        color: Colors.black,
        child: LayoutBuilder(
          builder: (_, constraints) {
            if (options.mode == CameraDisplayMode.sequence) {
              return _tile(
                session.cameraIndex % options.cameras.length,
                constraints.maxWidth,
              );
            }
            final count = options.cameras.length;
            final columns = options.columns > 0
                ? options.columns.clamp(1, count)
                : count <= 4
                ? (count == 1 ? 1 : 2)
                : math
                      .sqrt(
                        count * constraints.maxWidth / constraints.maxHeight,
                      )
                      .round()
                      .clamp(1, count);
            final rows = (count / columns).ceil();
            return Column(
              children: List.generate(
                rows,
                (row) => Expanded(
                  child: Row(
                    children: List.generate(columns, (col) {
                      final index = row * columns + col;
                      return Expanded(
                        child: index < count
                            ? Padding(
                                padding: const EdgeInsets.all(2),
                                child: _tile(
                                  index,
                                  constraints.maxWidth / columns,
                                ),
                              )
                            : const SizedBox(),
                      );
                    }),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
  Widget _tile(int index, double width) {
    final camera = session.options.cameras[index];
    final bytes = session.images[index];
    final unavailable = session.failed.contains(index);
    Widget placeholder() =>
        const Center(child: Icon(Icons.videocam_off, color: Colors.white54));
    return Stack(
      fit: StackFit.expand,
      children: [
        if (bytes == null)
          placeholder()
        else
          Image.memory(
            bytes,
            gaplessPlayback: true,
            fit: session.options.fit == CameraImageFit.cover
                ? BoxFit.cover
                : BoxFit.contain,
            errorBuilder: (_, _, _) => placeholder(),
          ),
        if (unavailable && bytes != null)
          const Positioned(
            top: 8,
            right: 8,
            child: Icon(Icons.sync_problem, color: Colors.amber),
          ),
        if (session.options.showNames && camera.name.isNotEmpty)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ColoredBox(
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  camera.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: (width * .04).clamp(10, 32),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
