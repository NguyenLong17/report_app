import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ListViewBuilder extends StatefulWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  final ScrollController _controller = ScrollController();
  int _itemCount = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyLoadScrollView(
        isLoading: _itemCount >= 48,
        onEndOfPage: () {
          print('onEndOfPage');
          Timer(Duration(seconds: 2), () {
            _itemCount += 12;
            setState(() {});
          });
        },
        scrollOffset: 200,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          primary: true,
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: _controller,
          shrinkWrap: true,
          reverse: false,
          itemBuilder: (_, index) {
            return _item(index);
          },
          itemCount: _itemCount,
        ),
      ),
    );
  }

  Widget _item(int id) {
    Random random = Random();
    Color color = Color.fromARGB(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1,
    );
    print('_itemRebuild: $id');
    return Container(
      width: double.infinity,
      height: 150,
      color: color,
      child: Center(
        child: Text('$id'),
      ),
    );
  }
}
