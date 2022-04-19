import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/src/page/system_info_widget/system_info_widget.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebugWidget extends StatelessWidget {
  final FrontendService _frontendService;

  const DebugWidget(this._frontendService, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      const SystemInfoWidget(),
      Positioned(
        top: 10.0,
        right: 70.0,
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () => _frontendService.pushButton(ButtonType.pause),
              child: const Icon(Icons.pause, size: 40.0),
            ),
            ElevatedButton(
              onPressed: () => _frontendService.pushButton(ButtonType.screentoggle),
              child: const Icon(Icons.screenshot, size: 40.0),
            ),
            ElevatedButton(
              onPressed: () => _frontendService.pushButton(ButtonType.menu),
              child: const Icon(Icons.menu, size: 40.0),
            ),
            ElevatedButton(
              onPressed: () => _frontendService.pushButton(ButtonType.select),
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
