import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MemoryUsageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('memory'),
        ),
      ),
    );
  }
}
