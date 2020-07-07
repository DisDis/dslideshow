import 'package:dslideshow_flutter/src/page/system_info_widget/system_info_widget.dart';
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
      builder: (context, Store<GlobalState> store) => Stack(
        children: <Widget>[
          SystemInfoWidget(),
          Positioned(
            top: 10.0,
            right: 70.0,
            child: RaisedButton(
              onPressed: () => store.dispatch(new ChangePauseAction(!store.state.isPaused)),
              child: Text('Pause'),
            ),
          ),
          Positioned(
            top: 10.0,
            right: 170.0,
            child: RaisedButton(
              child: Text('Config'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/config');
              },
            ),
          ),
        ],
      ),
    );
  }
}
