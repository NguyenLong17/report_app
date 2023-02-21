import 'package:flutter/material.dart';

class DemoGridView extends StatefulWidget {
  const DemoGridView({Key? key}) : super(key: key);

  @override
  State<DemoGridView> createState() => _DemoGridViewState();
}

class _DemoGridViewState extends State<DemoGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 150,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
          ),
          itemCount: 300,
          padding: EdgeInsets.all(16),
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              child: Center(child: Text('$index')),
              decoration: BoxDecoration(color: Colors.grey),
            );
          }),
    );
  }
}
