import 'package:dslideshow_flutter/environment.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/blink_animation.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonHeaderWidget extends StatelessWidget {
  const CommonHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SlideshowBloc, SlideshowState, IndicatorState>(selector: (state) {
      return IndicatorState(
          storageStatus: state.storageStatus, isDebug: state.isDebug, isPaused: state.isPaused, isMenu: state.isMenu, hasInternet: state.hasInternet);
    }, builder: (context, state) {
      return Stack(
        children: <Widget>[
          if (!isLinuxEmbedded)
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  final bloc = BlocProvider.of<SlideshowBloc>(context);
                  bloc.add(SlideshowDebugEvent(!state.isDebug));
                },
                child: Container(color: Colors.transparent, width: 30, height: 30),
              ),
            ),
          Row(
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
                    color: Colors.white,
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
        ],
      );
    });
  }
}
