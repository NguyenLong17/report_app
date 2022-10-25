import 'package:flutter/material.dart';
import 'package:report_app/common/util/navigator.dart';
import 'package:report_app/common/widgets/appbar.dart';
import 'package:report_app/common/widgets/mybutton.dart';
import 'package:report_app/common/widgets/mytextfield.dart';
import 'package:report_app/common/widgets/toast_overlay.dart';
import 'package:report_app/page/account/login_page.dart';
import 'package:report_app/service/api_service.dart';
import 'package:report_app/service/user_service.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Đổi mật khẩu'),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          MyTextField(
            labelText: 'OldPassword',
            controller: _oldPasswordController,
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextField(
            labelText: 'NewPassword',
            controller: _newPasswordController,
          ),
          const SizedBox(
            height: 16,
          ),
          MyButton(
              textButton: 'Save', backgroundColor: Colors.green, onTap: () {
                changePassword();
          }),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  void changePassword() {
    apiService
        .changePassword(
            oldPassword: _oldPasswordController.text,
            newPassword: _newPasswordController.text)
        .then((value) {
          ToastOverlay(context).showToastOverlay(message: 'Đổi mật khẩu thành công', type: ToastType.success);
          navigatorPushAndRemoveUntil(context, LoginPage());
    })
        .catchError((e) {
      ToastOverlay(context).showToastOverlay(message: 'Có lỗi xảy ra: ${e.toString()}', type: ToastType.error);

    });
  }

}
