import 'dart:async';

import 'package:flutter_demo/models/area.dart';
import 'package:flutter_demo/service/api_service.dart';
import 'package:flutter_demo/service/area_service.dart';

class SelectAreaBloc{

  final streamController = StreamController<List<Area>>.broadcast();
  Stream<List<Area>> get stream => streamController.stream;

  final _list = <Area>[];
  final _listFilter = <Area>[];
  Area? citySelected;


  SelectAreaBloc(){
  }

  void dispose(){
    streamController.close();
  }

  Future getCities() async{
    apiService.getCities().then((value){
      _list.clear();
      _listFilter.clear();
      _list.addAll(value);
      _listFilter.addAll(value);

      print('SelectAreaBloc.getCities ${value.length}');
      streamController.add(_listFilter);
    }).catchError((e){
      print('e $e');
    });
  }

  Future getDistricts({required String cityId}) async{
    apiService.getDistricts(cityId: cityId).then((value){
      _list.clear();
      _listFilter.clear();
      _list.addAll(value);
      _listFilter.addAll(value);

      streamController.add(_listFilter);
    }).catchError((e){

    });
  }

  void onFilter(String keyword){
    _listFilter.clear();
    _listFilter.addAll(_list.where((element) => element.name?.toLowerCase().contains(keyword.toLowerCase()) == true).toList());
    streamController.add(_listFilter);
  }
}