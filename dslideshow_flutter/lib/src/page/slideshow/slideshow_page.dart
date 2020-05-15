
import 'dart:io';

import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/page/common/common_header.dart';
import 'package:dslideshow_flutter/src/page/slideshow/timer_progress_bar.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_backend/src/service/storage/storage.dart';

class SlideShowPage extends StatefulWidget {
  SlideShowPage({Key key}) : super(key: key);

  @override
  _SlideShowPageState createState() => _SlideShowPageState();
}

class _SlideShowPageState extends State<SlideShowPage> with SingleTickerProviderStateMixin {
  static final Logger _log = new Logger('_SlideShowPageState');
  AnimationController controller;
  int _listItemCount = 2;
  // Outside build method
  PageController _pageController ;

  final Directory _externalStorage = environment.externalStorage;
  final FrontendService _frontendService = injector.get(FrontendService) as FrontendService;

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
  void _changeImage() async{
    print('Change image');
    await _frontendService.storageNext();
    _pageController.animateToPage(_pageController.page.toInt() + 1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  Future<String> _getCurrentImage() async{
    var item = await _frontendService.getStorageCurrentItem();
    return item.uri.path;
  }
  Future<String> _getNextImage() async {
    var item = await _frontendService.getStorageNextItem();
    return item.uri.path;
  }

  Map<int, String> _imageCache =  new Map<int, String>();
  Future<String> _getImage(int position, int length) async{
    var item = _imageCache[position];
    if (item!=null){
      return item;
    }
    item = await (length == position ? _getCurrentImage() : _getNextImage());
    if (_imageCache.length>10){
      _imageCache.clear();
    }
    _imageCache[position] = item;
    return item;
  }


  @override
  Widget build(BuildContext context) {
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
                    _listItemCount = position + 2;
                    return Center(
                      child: FutureBuilder<String>(
                          future: _getImage(position, _pageController.page.toInt()),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return Image.file(new File(snapshot.data));
                            } else {
                              return  SizedBox(
                                child: CircularProgressIndicator(),
                                width: 60,
                                height: 60,
                              );
                            }
                          }),

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

