import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  static final _manager = HiveManager._internal();

  factory HiveManager() => _manager;

  HiveManager._internal();

  var _currentBox = 'config';

  Future init() async{
    await Hive.initFlutter();
    await Hive.openBox(_currentBox);
  }

  Future<dynamic> getValue(String key) async{
    final box = Hive.box(_currentBox);
    final value = box.get(key);
    if (value != null){
      return jsonDecode(value);
    }
    return null;
  }

  Future<void> setValue(String key, dynamic value) async{
    final box = Hive.box(_currentBox);
    if (value == null){
      box.put(key, null);
    }else{
      box.put(key, jsonEncode(value));
    }

  }

  Future remove(String key) async{
    final box = Hive.box(_currentBox);
    await  box.delete(userKey);
  }


}

const userKey = 'userKey';


final hive = HiveManager();
