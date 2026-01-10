import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_event.dart';
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
          child: Column(
            children: [
              Row(
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
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    child: const Icon(Icons.settings, size: 40.0),
                    onPressed: () {
                      context.read<RouteBloc>().add(
                        ChangePageEvent(RoutePage.config),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Icon(Icons.update, size: 40.0),
                    onPressed: () {
                      context.read<RouteBloc>().add(
                        ChangePageEvent(RoutePage.ota),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Icon(Icons.update_sharp, size: 40.0, color:Colors.blue),
                    onPressed: () {
                      _setOTAState(context.read<OtaBloc>(),
                      OTAStatus.uploading, 50.0
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Icon(Icons.update_sharp, size: 40.0, color:Colors.yellow),
                    onPressed: () {
                      _setOTAState(context.read<OtaBloc>(),
                      OTAStatus.instaling, 100.0
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Icon(Icons.update_sharp, size: 40.0, color: Colors.green,),
                    onPressed: () {
                      _setOTAState(context.read<OtaBloc>(),
                      OTAStatus.finished, 100.0
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Icon(Icons.update_sharp, size: 40.0, color: Colors.red,),
                    onPressed: () {
                      _setOTAState(context.read<OtaBloc>(),
                      OTAStatus.issue, 100.0
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _setOTAState(OtaBloc bloc, OTAStatus status, double uploadingPercent) {
    bloc.add(
      OtaUpdateInfoEvent(
        OTAInfo(
          status: status,
          uploadingPercent: uploadingPercent,
          code: "123456",
        ),
      ),
    );

    bloc.add(OtaAddTextToTerminalEvent('Change state -> $status\n\r'));
  }
}
