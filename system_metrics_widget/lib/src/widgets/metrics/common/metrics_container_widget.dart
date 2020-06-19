import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MetricsContainerWidget extends StatelessWidget {
  final Color backgroundColor;
  final IconData iconData;
  final Widget child;

  MetricsContainerWidget({
    @required this.iconData,
    @required this.backgroundColor,
    @required this.child,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Container(
              color: backgroundColor,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Container(
              color: backgroundColor,
              child: Padding(padding: EdgeInsets.only(top: 4, left: 8, right: 4, bottom: 8), child: child),
            ),
          ),
        ],
      );
}
