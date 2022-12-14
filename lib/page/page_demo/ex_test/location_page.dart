import 'package:flutter/material.dart';
import 'package:report_app/common/util/navigator.dart';
import 'package:report_app/common/widgets/appbar.dart';
import 'package:report_app/common/widgets/mybutton.dart';
import 'package:report_app/common/widgets/mytextfield.dart';
import 'package:report_app/page/page_demo/ex_test/choose_information_page.dart';

class LocationPage extends StatefulWidget {
   VoidCallback? onTap;
  String? city;
  String? district;

   LocationPage({super.key,  this.onTap, this.city,this.district });


  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final cityController = TextEditingController();
  final districtController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // loc ten: list.contain
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          title: 'Địa chỉ mới',
          color: Colors.red,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget.onTap;
                });
              },
              icon: Icon(Icons.add),
            ),
          ]),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              navigatorPush(context, ChooseInformationPage());
            },
            child: MyTextField(
              labelText: 'Chọn tỉnh/ thành',
              enable: false,
              controller: cityController,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              navigatorPush(context, ChooseInformationPage());
            },
            child: MyTextField(
              labelText: 'Chọn quận/ huyện',
              enable: false,
              controller: districtController,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextField(
            labelText: 'Địa chỉ cụ thể',
            hintText: 'Nhập địa chỉ cụ thể (Số nhà, tên đường ...)',
          ),
          const SizedBox(
            height: 16,
          ),
          MyButton(
            textButton: 'Lưu',
            backgroundColor: Colors.red,
            onTap: () {},
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
