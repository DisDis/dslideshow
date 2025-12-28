import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebugWidget extends StatelessWidget {
  final FrontendService _frontendService;

  const DebugWidget(this._frontendService, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned(
        top: 10.0,
        right: 70.0,
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () => _frontendService.emulatePushButton(ButtonType.button0,),
              child: const Icon(Icons.pause, size: 40.0),
            ),
            ElevatedButton(
              onPressed: () => _frontendService.emulatePushButton(ButtonType.button2),
              child: const Icon(Icons.screenshot, size: 40.0),
            ),
            ElevatedButton(
              onPressed: () => _frontendService.emulatePushButton(ButtonType.button1),
              child: const Icon(Icons.menu, size: 40.0),
            ),
            ElevatedButton(
              onPressed: () => _frontendService.emulatePushButton(ButtonType.button3),
              child: const Icon(Icons.select_all_outlined, size: 40.0),
            ),
            ElevatedButton(
              child: const Icon(Icons.settings, size: 40.0),
              onPressed: () {
                context.read<RouteBloc>().add(ChangePageEvent(RoutePage.config));
              },
            ),
          ],
        ),
      )
    ]);
  }
}
