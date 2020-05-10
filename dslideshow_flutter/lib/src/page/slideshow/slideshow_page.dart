
import 'dart:io';

import 'package:dslideshow_flutter/src/page/common/common_header.dart';
import 'package:dslideshow_flutter/src/page/slideshow/timer_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:dslideshow_flutter/environment.dart' as environment;

class SlideShowPage extends StatefulWidget {
  SlideShowPage({Key key}) : super(key: key);

  @override
  _SlideShowPageState createState() => _SlideShowPageState();
}

class _SlideShowPageState extends State<SlideShowPage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  int _listItemCount = 2;
  // Outside build method
  PageController _pageController ;

  final Directory _externalStorage = environment.externalStorage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1,keepPage: false);
    controller = AnimationController(duration: const Duration(seconds: 5), vsync: this);
    controller.addListener((){
      setState(() {});
    });
    controller.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      _changeImage();
      controller.reset();
      controller.forward();
    }
    });
    controller.forward();
  }
  void _changeImage() {
    print('Change image');
    _pageController.animateToPage(_pageController.page.toInt() + 1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    //    _externalStorage = await getApplicationDocumentsDirectory();
    return
      Container(
          child:

          new Stack(
            children: <Widget>[
              new Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                color: Colors.black,
                  child: PageView.builder(
                    controller: _pageController,
                    itemBuilder: (context, position) {
                      _listItemCount = position+2;
                      return Center(
                        child:
//                        Image.file(new File(path.join(
//                            _externalStorage.path, 'images', /*'1.jpg'*/ '4.gif'))),
                    Image.file(new File(path.join(
                        _externalStorage.path, 'images', '$position.jpg'))),

                      );
                    },
                    itemCount: _listItemCount,
                  ),
              ),
              new Container(
                child: CommonHeaderWidget(),
              ),
              new Container(
                  child: Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child:
                      CustomPaint(
                        size: Size(MediaQuery
                            .of(context)
                            .size
                            .width, 3),
                        painter: TimerProgressBarPainter(
                            controller.value * 100),
                      ))
              ),
              RaisedButton(onPressed: () {
                Navigator.pushReplacementNamed(context, '/config');
              },),

//              Text(
//                'You have times:',
//                style: TextStyle(color: Colors.white, fontSize: 10),
//              ),
            ],
          ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    controller.dispose();
    super.dispose();
  }
}

