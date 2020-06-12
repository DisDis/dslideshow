import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DiskUsageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('disk'),
        ),
      ),
    );
  }
}
