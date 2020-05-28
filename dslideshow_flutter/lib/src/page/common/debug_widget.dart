import 'package:dslideshow_flutter/src/app_reducer.dart';
import 'package:dslideshow_flutter/src/data_model/global_state.dart';
import 'package:dslideshow_flutter/src/page/common/mainmenu.dart';
import 'package:dslideshow_flutter/src/page/common/system_info_widget.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DebugWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<GlobalState, Store<GlobalState>>(
        converter: (store) => store,
        builder: (context,  Store<GlobalState> store) =>
            Column(
              children: <Widget>[
                if (store.state.isDebug) SystemInfoWidget(),
                /*if (store.state.isDebug) SizedBox(
                      height: 300,
                      child:  MainMenuWidget()),*/
                RaisedButton(
                  onPressed: () => store.dispatch(new ChangeDebugAction(!store.state.isDebug)),
                  child: Text('Debug'),
                ),

              ],
            )
    );
  }

}