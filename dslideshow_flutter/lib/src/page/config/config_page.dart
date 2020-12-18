import 'dart:math';

import 'package:injector/injector.dart';
import 'package:dslideshow_flutter/src/page/common/common_header.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_storage_status_action.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logging/logging.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ConfigPage extends StatefulWidget {
  ConfigPage({Key key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage>{
  static final Logger _log = Logger('_ConfigPageState');
  static final String _urlData = "http://localhost:8181/test";
  static final Random rnd = new Random();
  final FrontendService _frontendService = Injector.appInstance.get<FrontendService>();

  @override
  void initState() {
    super.initState();
    _frontendService.startWebServer();
  }

  @override
  void dispose() {
    _frontendService.stopWebServer();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          CommonHeaderWidget(),
          QrImage(
            backgroundColor: Colors.white,
            data: _urlData,
            size: 300.0,
          ),
          Text(_urlData),
          StoreConnector<GlobalState, VoidCallback>(
              converter: (store) => () => store.dispatch(ChangeStorageStatusAction(
                  StorageStatusEnum.values.elementAt(rnd.nextInt(StorageStatusEnum.values.length - 1)))),
              builder: (context, callback) => RaisedButton(
                    onPressed: callback,
                    child: Text('StorageChange'),
                  )),
          RaisedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/slideshow');
            },
            child: Text('SlideShow'),
          ),
        ],
      ),
    );
  }
}
