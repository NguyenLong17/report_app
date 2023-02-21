import 'package:feature_demo_app/app_color.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: appColor.primaryColor,

        title: Text('Demo Page'),
      ),
      body: Container(
        color: appColor.backgroundColor,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  appColor.isDarkMode = !appColor.isDarkMode;
                });
              },
              child: Text('Theme'),
            ),
            SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () {},
              child: Text('Font'),
            ),
            SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () {},
              child: Text('Language'),
            ),
          ],
        ),
      ),
    );
  }
}
