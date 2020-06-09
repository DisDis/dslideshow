import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SystemInfoMetrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      staggeredTiles: [
        StaggeredTile.fit(1),
        StaggeredTile.fit(3),
        StaggeredTile.fit(2),
        StaggeredTile.fit(2),
        StaggeredTile.fit(1),
      ],
      crossAxisCount:4,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          color: Colors.green,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('1'),
            ),
          ),
        ),
        Container(
          color: Colors.green,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('2'),
            ),
          ),
        ),
        Container(
          color: Colors.green,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('3'),
            ),
          ),
        ),
        Container(
          color: Colors.yellow,
          height: 200,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('4'),
            ),
          ),
        ),
        Container(
          color: Colors.green,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('5'),
            ),
          ),
        ),
      ],
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
