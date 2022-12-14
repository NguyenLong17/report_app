import 'package:flutter/material.dart';
import 'package:report_app/common/widgets/appbar.dart';
import 'package:report_app/common/widgets/mybutton.dart';

class LocationMapPage extends StatefulWidget {
  const LocationMapPage({Key? key}) : super(key: key);

  @override
  State<LocationMapPage> createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Locaion Map Page'),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            MyButton(
              textButton: 'Get Current Location',
              backgroundColor: Colors.green,
              onTap: () {
                print('_LocationMapPageState.build');
              },
            ),
          ],
        ),
      ),
    );
  }
}
