import 'package:flutter/material.dart';
import 'package:report_app/common/util/navigator.dart';
import 'package:report_app/common/widgets/appbar.dart';
import 'package:report_app/page/page_demo/ex_test/location_page.dart';
import 'package:report_app/page/page_demo/ex_test/model/city.dart';
import 'package:report_app/page/page_demo/ex_test/model/district.dart';
import 'package:report_app/page/page_demo/ex_test/service/city_service.dart';

class ChooseInformationPage extends StatefulWidget {
  const ChooseInformationPage({Key? key}) : super(key: key);

  @override
  State<ChooseInformationPage> createState() => _ChooseInformationPageState();
}

class _ChooseInformationPageState extends State<ChooseInformationPage> {
  final List<City> listCity = [];
  final List<District> listDistrict = [];
  String? idCitySelected;
  String? citySelected;
  String? districtSelected;

  @override
  void initState() {
    super.initState();
    if (idCitySelected == null) {
      getListCity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildAppBar(context: context, title: 'Chọn ...', color: Colors.red),
      body: Column(
        children: [
          if (idCitySelected == null) ...{
            Expanded(
              child: buildBodyCity(),
            ),
          } else if (idCitySelected != null) ...{
            Expanded(
              child: buildBodyDistrict(),
            ),
          },
        ],
      ),
    );
  }

  Widget buildBodyCity() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final city = listCity[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              idCitySelected = city.id;
              citySelected = city.name;
            });
          },
          child: Container(
            height: 32,
            child: Text(
              city.name ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: listCity.length,
    );
  }

  void getListCity() {
    apiCity.getListCity().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          listCity.addAll(value);
        });
      }
    }).catchError((e) {
      print('Co loi xay ra: ${e.toString()}');
    });
  }

  Widget buildBodyDistrict() {
    print('Day la man list District');
    if (listDistrict.isEmpty) {
      getListDistrict();
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final district = listDistrict[index];
        return GestureDetector(
          onTap: () {
            print('District : ${district.name}');
            districtSelected = district.name;
            navigatorPushAndRemoveUntil(
                context,
                LocationPage(
                  onTap: () {},
                  city: citySelected,
                  district: districtSelected,
                ));
          },
          child: Container(
            height: 32,
            child: Text(
              district.name ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: listDistrict.length,
    );
  }

  void getListDistrict() {
    print('Lay danh sach District');
    apiCity.getListDistrict(idCity: idCitySelected).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          listDistrict.addAll(value);
          print('list huyen ${listDistrict.length}');
        });
      }
    }).catchError((e) {
      print('Co loi xay ra: ${e.toString()}');
    });
  }
}
