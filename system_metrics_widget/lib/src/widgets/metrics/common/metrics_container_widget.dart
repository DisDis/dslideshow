import 'package:flutter/material.dart';

class MetricsContainerWidget extends StatelessWidget {
  final Color backgroundColor;
  final IconData iconData;
  final Widget child;
  final Color iconColor;

  const MetricsContainerWidget({
    required this.iconData,
    required this.backgroundColor,
    required this.child,
    super.key,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Container(
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  iconData,
                  color: iconColor,
                  size: 20.0,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Container(
              color: backgroundColor,
              child: Padding(padding: const EdgeInsets.only(top: 4, left: 8, right: 4, bottom: 8), child: child),
            ),
          ),
        ],
      );
}
