import 'package:flutter/material.dart';
import 'package:report_app/page/account/login_page.dart';
import 'package:report_app/page/home_page.dart';
import 'package:report_app/page/issue_page.dart';
import 'package:report_app/page/page_demo/ex_test/location_page.dart';
import 'package:report_app/page/page_demo/location_map_page.dart';
import 'package:report_app/page/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      // home: AccountPage(),
      // home: HomePage(),
      // home: ReportPage(),
      // home: TabBarPage(),
      // home: ContactPage(),
      // home: RegisterPage(),
      // home: ImagePickerPage(),
      // home: IssuePage(),
      home: SplashPage(),
      // home: LocationPage(),
      // home: LocationMapPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
