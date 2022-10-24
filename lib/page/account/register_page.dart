import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:report_app/common/hive_manager.dart';
import 'package:report_app/common/util/navigator.dart';
import 'package:report_app/common/widgets/appbar.dart';
import 'package:report_app/common/widgets/mybutton.dart';
import 'package:report_app/common/widgets/mytextfield.dart';
import 'package:report_app/common/widgets/toast_overlay.dart';
import 'package:report_app/page/home_page.dart';
import 'package:report_app/service/api_service.dart';
import 'package:report_app/service/user_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Register Page'),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          MyTextField(
            labelText: 'Name',
            controller: _nameController,
          ),
          const SizedBox(
            height: 32,
          ),
          MyTextField(
            labelText: 'PhoneNumber',
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(
            height: 32,
          ),
          MyTextField(
            labelText: 'Password',
            controller: _passwordController,
            obscureText: true,
          ),
          const SizedBox(
            height: 32,
          ),
          MyTextField(
            labelText: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 32,
          ),
          MyButton(
              textButton: 'Register',
              textColor: Colors.black,
              backgroundColor: Colors.green,
              onTap: () {
                register();
              }),
        ],
      ),
    );
  }

  void register() {
    apiService
        .register(
      name: _nameController.text,
      phone: _phoneNumberController.text,
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((user) {
      navigatorPush(context, HomePage());
      hive.setValue(userKey, user);
      ToastOverlay(context).showToastOverlay(
          message: "Đăng ký thành công", type: ToastType.success);
      apiService.user = user;

      navigatorPushAndRemoveUntil(context, const HomePage());
    }).catchError((e) {
      ToastOverlay(context).showToastOverlay(
          message: "Có lỗi xảy ra: ${e.toString()}", type: ToastType.error);
    });
  }
}
