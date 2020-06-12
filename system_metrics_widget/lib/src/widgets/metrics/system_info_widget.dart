import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SystemInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('system info'),
        ),
      ),
    );
  }
}
