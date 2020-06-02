import 'package:dslideshow_flutter/src/page/common/mainmenu.dart';
import 'package:dslideshow_flutter/src/page/common/system_info_widget.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_pause_action.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class DebugWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalState, Store<GlobalState>>(
        converter: (store) => store,
        builder: (context, Store<GlobalState> store) => Column(children: <Widget>[
              if (store.state.isDebug) SystemInfoWidget(),
              if (store.state.isDebug)
                SizedBox(
                  height: 300,
                  child: MainMenuWidget(),
                ),
              if (store.state.isDebug)
                RaisedButton(
                  onPressed: () => store.dispatch(new ChangePauseAction(!store.state.isPaused)),
                  child: Text('Pause'),
                ),
              if (store.state.isDebug)
                RaisedButton(
                  child: Text('Config'),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/config');
                  },
                ),
            ]));
  }
}
