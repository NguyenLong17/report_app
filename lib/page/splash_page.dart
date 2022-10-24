import 'package:flutter/material.dart';
import 'package:report_app/common/flutter_secure_storage.dart';
import 'package:report_app/common/hive_manager.dart';
import 'package:report_app/common/shared_preferences_manager.dart';
import 'package:report_app/common/util/navigator.dart';
import 'package:report_app/model/user.dart';
import 'package:report_app/page/account/login_page.dart';
import 'package:report_app/page/home_page.dart';
import 'package:report_app/service/api_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }

  Future initData() async {
    await sharedPrefs.init();
    await secureStorage.init();

    await hive.init();

    final userJson = await hive.getValue(userKey);
    if (userJson != null) {
      final user = User.fromJson(userJson);
      // apiService.token = user.token ?? '';

      apiService.user = user;


      navigatorPushAndRemoveUntil(context, const HomePage());
    } else {
      navigatorPushAndRemoveUntil(context, const LoginPage());
    }
  }
}
