import 'package:flutter/material.dart';
import 'package:flutter_demo/common/widgets/MyButton.dart';
import 'package:flutter_demo/common/widgets/MyTextField.dart';
import 'package:flutter_demo/module/account/profile_page.dart';
import 'package:flutter_demo/module/area/select_area_page.dart';
import 'package:flutter_demo/util/navigator.dart';

class AreaPage extends StatefulWidget {
  const AreaPage({Key? key}) : super(key: key);

  @override
  State<AreaPage> createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> {
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    cityController.dispose();
    districtController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Địa chỉ mới'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('_AreaPageState.build');
                      navigatorPush(
                        context,
                        SelectAreaPage(
                          onDone: onDone,
                        ),
                      );
                    },
                    behavior: HitTestBehavior.translucent,
                    child: IgnorePointer(
                      ignoring: true,
                      child: MyTextField(
                        controller: cityController,
                        labelText: 'Tỉnh/Thành phố',
                        hintText: 'Chọn tỉnh/thành phố',
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      navigatorPush(
                        context,
                        SelectAreaPage(
                          onDone: onDone,
                        ),
                      );
                    },
                    behavior: HitTestBehavior.translucent,
                    child: IgnorePointer(
                      child: MyTextField(
                        controller: districtController,
                        labelText: 'Quận/Huyện',
                        hintText: 'Chọn quận/huyện',
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: addressController,
                    labelText: 'Địa chỉ',
                    hintText: 'abc...',
                  ),
                ],
              ),
            ),
          ),
          MyButton(text: 'Lưu', onTap: () {})
        ],
      ),
    );
  }

  void onDone(city, district) {
    print('city: ${city.name}');
    print('district: ${district.name}');

    cityController.text = city.name ?? '';
    districtController.text = district.name ?? '';
  }
}
