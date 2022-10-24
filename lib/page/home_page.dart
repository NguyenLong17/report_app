import 'package:flutter/material.dart';
import 'package:report_app/common/widgets/appbar.dart';
import 'package:report_app/page/drawer_page.dart';
// import 'package:report_app/page/fcm/fcm_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      // fcmManager.requestPermission();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Home Page'),
      drawer: const DrawerPage(),
      body: const Center(
        child: Text(
          'Home Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
