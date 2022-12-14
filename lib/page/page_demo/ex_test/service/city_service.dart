import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:report_app/common/const/const.dart';
import 'package:report_app/model/issue.dart';
import 'package:report_app/model/user.dart';
import 'package:report_app/page/page_demo/ex_test/model/city.dart';
import 'package:report_app/page/page_demo/ex_test/model/district.dart';

class APICity {
  static final _service = APICity._internal();

  factory APICity() => _service;

  APICity._internal();

  Future request({
    Method method = Method.get,
    required String path,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse(path);
    http.Response response;

    switch (method) {
      case Method.get:
        response = await http.get(
          uri,
        );
        break;
      default:
        response = await http.post(uri, body: body, encoding: utf8);
        break;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);

      if (json['code'] == 0) {
        final data = json['data'];
        return data;
      } else {
        throw Exception(json['message']);
      }
    }

    throw Exception('Có lỗi xảy ra, http status code: ${response.statusCode}');
  }

  Future<List<City>> getListCity() async {
    final result = await request(
      path: 'https://apiv3.thegioisim.com/api/area/cities',
      method: Method.get,
    );

    final listCity = List<City>.from(result.map((e) => City.fromJson(e)));
    print('danh sach city: ${listCity.length}');
    return listCity;
  }

  Future<List<District>> getListDistrict({
    required String? idCity,
  }) async {
    final result = await request(
      path: 'https://apiv3.thegioisim.com/api/area/districts?cityId=$idCity',
      method: Method.get,
    );

    final listDistrict = List<District>.from(result.map((e) => District.fromJson(e)));
    return listDistrict;
  }


}

final apiCity = APICity();

enum Method { get, post, put, delete }
