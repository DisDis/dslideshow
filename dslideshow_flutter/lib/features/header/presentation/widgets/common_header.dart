import 'package:dslideshow_flutter/environment.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/blink_animation.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonHeaderWidget extends StatelessWidget {
  const CommonHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (!isLinuxEmbedded)
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                final bloc = BlocProvider.of<SlideshowStatusBloc>(context);
                bloc.add(SlideshowDebugEvent(!bloc.state.isDebug));
              },
              child: Container(color: Colors.transparent, width: 30, height: 30),
            ),
          ),
        BlocBuilder<SlideshowStatusBloc, SlideshowStatusState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                if (state.storageStatus == StorageStatusEnum.off)
                  const BlinkAnimation(
                    key: Key('cloud_off'),
                    hideAfterBlink: false,
                    child: Icon(
                      Icons.cloud_off,
                      size: 24.0,
                      color: Colors.red,
                    ),
                  )
                else if (state.storageStatus == StorageStatusEnum.download)
                  const BlinkAnimation(
                    key: Key('cloud_download'),
                    child: Icon(
                      Icons.cloud_download,
                      size: 24.0,
                      color: Colors.green,
                    ),
                  )
                else if (state.storageStatus == StorageStatusEnum.done)
                  const BlinkAnimation(
                      key: Key('cloud_done'),
                      child: Icon(
                        Icons.cloud_done,
                        size: 24.0,
                        color: Colors.white,
                      )),
                if (state.hasInternet)
                  const BlinkAnimation(
                      key: Key('hasInternet'),
                      child: Icon(
                        Icons.signal_wifi_4_bar,
                        size: 24.0,
                        color: Colors.white,
                      ))
                else
                  const BlinkAnimation(
                    key: Key('noInternet'),
                    hideAfterBlink: false,
                    child: Icon(
                      Icons.signal_wifi_off,
                      size: 24.0,
                      color: Colors.red,
                    ),
                  ),
                if (state.isPaused)
                  const BlinkAnimation(
                    key: Key('isPaused'),
                    hideAfterBlink: false,
                    child: Icon(
                      Icons.pause_circle,
                      size: 24.0,
                      color: Colors.red,
                    ),
                  )
              ],
            ),
          );
        }),
      ],
    );
  }
}
