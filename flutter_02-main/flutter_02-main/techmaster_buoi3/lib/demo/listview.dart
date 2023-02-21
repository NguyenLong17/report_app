import 'dart:async';

import 'package:flutter/material.dart';

class DemoListView extends StatefulWidget {
  const DemoListView({Key? key}) : super(key: key);

  @override
  State<DemoListView> createState() => _DemoListViewState();
}

class _DemoListViewState extends State<DemoListView> {
  GlobalKey _keyAppBar = GlobalKey();
  ValueKey valueKey = ValueKey('1');
  ScrollController _controller = ScrollController();
  Completer<void> _refreshCompleter = Completer();

  Future _onRefresh() async {
    Timer(Duration(seconds: 2), () {
      _refreshCompleter.complete();
      _refreshCompleter = Completer();
    });
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          key: _keyAppBar,
          padding: const EdgeInsets.only(top: 16),
          // default
          primary: true,
          // == true ~ AlwaysScrollableScrollPhysics
          // default = null when _controller==null && Axis.vertical
          physics: const AlwaysScrollableScrollPhysics(),
          // NeverScrollableScrollPhysics
          scrollDirection: Axis.vertical,
          // default
          // controller: _controller,
          shrinkWrap: true,
          reverse: false,
          children: [
            Container(
              height: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 100),
            TextFormField(
              initialValue: 'Hello world',
            ),
            const SizedBox(height: 100),
            const Text('Hello everyBody'),
            const SizedBox(height: 100),
            const FlutterLogo(
              size: 100,
            ),
            const SizedBox(height: 100),
            const Icon(Icons.favorite),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      primary: true,
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: _controller,
      shrinkWrap: true,
      reverse: false,
      children: [],
    );
  }
}
