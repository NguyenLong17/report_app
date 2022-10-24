import 'package:flutter/material.dart';
import 'package:report_app/common/hive_manager.dart';
import 'package:report_app/common/shared_preferences_manager.dart';
import 'package:report_app/common/util/navigator.dart';
import 'package:report_app/common/widgets/mybutton.dart';
import 'package:report_app/common/widgets/mytextfield.dart';
import 'package:report_app/common/widgets/progress_dialog.dart';
import 'package:report_app/common/widgets/toast_overlay.dart';
import 'package:report_app/page/account/register_page.dart';
import 'package:report_app/page/home_page.dart';
import 'package:report_app/service/api_service.dart';
import 'package:report_app/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  SharedPreferences? pref;
  late ProgressDialog progress;

  @override
  void initState() {
    progress = ProgressDialog(context);
    sharedPrefs.getString(phoneKey).then((value) {
      _phoneNumberController.text = value ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Image.asset('assets/images/dungeon.jpg'),
          ),
          Expanded(
            flex: 6,
            child: buildBodyLogin(),
          ),
          Expanded(
            flex: 1,
            child: RichText(
              text: const TextSpan(
                text: 'HotLine: ',
                style: TextStyle(fontWeight: FontWeight.w600),
                children: <TextSpan>[
                  TextSpan(
                    text: '19005656',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBodyLogin() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          children: [
            MyTextField(
              autoFocus: true,
              controller: _phoneNumberController,
              labelText: 'Phone number',
              hintText: '+84...',
              textAlign: TextAlign.start,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 16,
            ),
            MyTextField(
              autoFocus: true,
              labelText: 'Password',
              controller: _passwordController,
              hintText: '*****',
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    textButton: 'Register',
                    textColor: Colors.black,
                    backgroundColor: Colors.grey.shade500,
                    onTap: () {
                      navigatorPush(context, const RegisterPage());
                    },
                  ),
                ),
               const SizedBox(width: 16,),
                Expanded(
                  child: MyButton(
                    textButton: 'Login',
                    textColor: Colors.red,
                    backgroundColor: Colors.green,
                    onTap: () {
                      login();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    progress.show();
    await Future.delayed(const Duration(seconds: 2));

    apiService
        .login(
      phone: _phoneNumberController.text,
      password: _passwordController.text,
    )
        .then((user) {
          sharedPrefs.setString(phoneKey, _phoneNumberController.text);

          hive.setValue(userKey, user);
          progress.hide();


          ToastOverlay(context).showToastOverlay(
          message: "Đăng nhập thành công", type: ToastType.success);

          apiService.user = user;


      navigatorPushAndRemoveUntil(context, const HomePage());
    }).catchError((e) {
      progress.show();
      ToastOverlay(context).showToastOverlay(
          message: "Có lỗi xảy ra khi đăng nhập: ${e.toString()}", type: ToastType.error);
      progress.hide();
    });
  }

}
