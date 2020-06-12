import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NetworkUsageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('network'),
        ),
      ),
    );
  }
}
