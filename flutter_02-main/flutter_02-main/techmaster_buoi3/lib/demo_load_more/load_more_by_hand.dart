import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:techmaster_buoi3/demo_load_more/custom_plugin.dart';

class LoadingMoreByHand extends StatefulWidget {
  const LoadingMoreByHand({Key? key}) : super(key: key);

  @override
  State<LoadingMoreByHand> createState() => _LoadingMoreByHandState();
}

class _LoadingMoreByHandState extends State<LoadingMoreByHand> {
  int _itemCount = 12;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LazyLoadScrollView(
                isLoading: _loading ? true : _itemCount >= 48,
                onEndOfPage: () {
                  print('onEndOfPage');
                  setState(() {
                    _loading = true;
                  });
                  Timer(Duration(seconds: 2), () {
                    _itemCount += 12;
                    _loading = false;
                    setState(() {});
                  });
                },
                scrollOffset: 200,
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 16),
                  // default
                  // primary: true, // == true ~ AlwaysScrollableScrollPhysics
                  // default = null when _controller==null && Axis.vertical
                  physics: const AlwaysScrollableScrollPhysics(),
                  // NeverScrollableScrollPhysics
                  scrollDirection: Axis.vertical,
                  // default
                  // controller: _controller,
                  // shrinkWrap: true,
                  reverse: false,
                  separatorBuilder: (_,index){
                    return const SizedBox(height: 12);
                  },
                  itemBuilder: (_, index) {
                    return _item(index);
                  },
                  itemCount: _itemCount,
                ),
              ),
            ),
            _loading ? CircularProgressIndicator() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _item(int id) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12)
      ),
      height: 150,
      child: Center(
        child: Text('$id'),
      ),
    );
  }
}
