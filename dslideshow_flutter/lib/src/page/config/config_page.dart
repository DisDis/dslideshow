import 'dart:math';

import 'package:dslideshow_flutter/src/page/common/common_header.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_storage_status_action.dart';
import 'package:dslideshow_flutter/src/redux/data_model/global_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ConfigPage extends StatelessWidget {
  static final String _urlData = "http://localhost:8181/test";
  static final Random rnd = new Random();

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
          new StoreConnector<GlobalState, VoidCallback>(
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
