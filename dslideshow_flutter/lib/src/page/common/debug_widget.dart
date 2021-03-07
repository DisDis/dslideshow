import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/src/page/system_info_widget/system_info_widget.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_pause_action.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class DebugWidget extends StatelessWidget {
  final FrontendService _frontendService;

  const DebugWidget(this._frontendService, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SystemInfoWidget(),
      Positioned(
         top: 10.0,
          right: 70.0,
        child:
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _frontendService.pushButton(ButtonType.pause),
                child: Text('P'),
              ),
              ElevatedButton(
                onPressed: () => _frontendService.pushButton(ButtonType.screentoggle),
                child: Text('S'),
              ),
              ElevatedButton(
                onPressed: () => _frontendService.pushButton(ButtonType.menu),
                child: Text('M'),
              ),
              ElevatedButton(
                child: Text('Config'),
                onPressed: () {Navigator.pushReplacementNamed(context, '/config');},
             ),
          ],
        ),
    )]);
  }
}
