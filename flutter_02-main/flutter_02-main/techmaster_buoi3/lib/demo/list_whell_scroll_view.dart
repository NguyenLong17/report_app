import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class DemoListWheelScrollView extends StatefulWidget {
  const DemoListWheelScrollView({Key? key}) : super(key: key);

  @override
  _DemoListWheelScrollViewState createState() =>
      _DemoListWheelScrollViewState();
}

class _DemoListWheelScrollViewState extends State<DemoListWheelScrollView> {
  double _diameterRatio = 2;

  double _offAxisFraction = 0;

  double _magnification = 1;
  final heightItem = 100.0;
  bool onFocusing = false;

  final ScrollController _controller = ScrollController();

  initListData(_) async {
    // _controller.jumpTo();
  }

  @override
  void initState() {
    super.initState();
  }

  void _onTestTimeLine() async {
    Timeline.startSync('_onTestTimeLine');
    print('handle _onTestTimeLine');
    Timeline.finishSync();
  }

  int onGetCurrentIndex(double currentPosition, double heightItem) {
    double indexDouble = currentPosition / heightItem;
    int indexInt = indexDouble.toInt();
    return indexInt + ((indexDouble - indexInt) > 0.5 ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListWheelScrollView demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 600,
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                    // print('_onStartScroll');
                    // _onStartScroll(scrollNotification.metrics);
                  } else if (scrollNotification is ScrollUpdateNotification) {
                    // _onUpdateScroll(scrollNotification.metrics);
                    // print('_onUpdateScroll');
                  } else if (scrollNotification is ScrollEndNotification) {
                    // _onEndScroll(scrollNotification.metrics);
                    print('_onEndScroll ${_controller.position.pixels} ');
                    Timer(Duration(milliseconds: 20), () {
                      int _currentIndex = onGetCurrentIndex(
                          _controller.position.pixels, heightItem);
                      print('_currentIndex: $_currentIndex');
                      if (!onFocusing) {
                        onFocusing = true;
                        _controller.jumpTo(_currentIndex * heightItem);
                        Timer(Duration(milliseconds: 50), () {
                          onFocusing = false;
                        });
                      }
                    });
                  }
                  return false;
                },
                child: ListWheelScrollView(
                  useMagnifier: true,
                  controller: _controller,
                  magnification: 1.2,
                  diameterRatio: 1.4,
                  onSelectedItemChanged: (index) {
                    print('onSelectedItemChanged $index');
                  },
                  itemExtent: heightItem,
                  children: <Widget>[
                    for (int i = 0; i < 10; i++)
                      MyItem(
                        index: i + 1,
                        width: heightItem,
                        height: heightItem,
                      )
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 300,
            //   child: ListWheelScrollView(
            //     useMagnifier: true,
            //     magnification: 1.5,
            //     diameterRatio: 2,
            //     onSelectedItemChanged: (index) {
            //       print('$index ne');
            //     },
            //     itemExtent: 100,
            //     children: <Widget>[
            //       for (int i = 0; i < 10; i++) MyItem(index: i + 1)
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class MyItem extends StatelessWidget {
  final int index;
  final double? height;
  final double? width;

  MyItem({required this.index, Key? key, this.height, this.width})
      : super(key: key);

  static const colors = [
    Colors.pink,
    Colors.indigo,
    Colors.grey,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    print('MyItem: $index');
    return Container(
      width: width,
      height: height,
      color: colors[index % colors.length],
      child: Center(
          child: Text(
        '$index',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
