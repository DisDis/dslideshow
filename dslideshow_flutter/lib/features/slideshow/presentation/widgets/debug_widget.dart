import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebugWidget extends StatelessWidget {
  final FrontendService _frontendService;
  final AppConfig appConfig;

  const DebugWidget(this._frontendService, this.appConfig, {super.key});
  IconData getIconDataBySlideshowAction(SlideshowAction action) {
    switch (action) {
      case SlideshowAction.none:
        return Icons.cancel;
      case SlideshowAction.pause:
        return Icons.pause;
      case SlideshowAction.showInfo:
        return Icons.info;
      case SlideshowAction.showMenu:
        return Icons.menu;
      case SlideshowAction.toggleScreen:
        return Icons.power_off;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 10.0,
          right: 70.0,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () =>
                    _frontendService.emulatePushButton(ButtonType.button0),
                child: Icon(
                  getIconDataBySlideshowAction(
                    appConfig.slideshow.buttons.button0.action,
                  ),
                  size: 40.0,
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    _frontendService.emulatePushButton(ButtonType.button1),
                child: Icon(
                  getIconDataBySlideshowAction(
                    appConfig.slideshow.buttons.button1.action,
                  ),
                  size: 40.0,
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    _frontendService.emulatePushButton(ButtonType.button2),
                child: Icon(
                  getIconDataBySlideshowAction(
                    appConfig.slideshow.buttons.button2.action,
                  ),
                  size: 40.0,
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    _frontendService.emulatePushButton(ButtonType.button3),
                child: Icon(
                  getIconDataBySlideshowAction(
                    appConfig.slideshow.buttons.button3.action,
                  ),
                  size: 40.0,
                ),
              ),
              ElevatedButton(
                child: const Icon(Icons.settings, size: 40.0),
                onPressed: () {
                  context.read<RouteBloc>().add(
                    ChangePageEvent(RoutePage.config),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
