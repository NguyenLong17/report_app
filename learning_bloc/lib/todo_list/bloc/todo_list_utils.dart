import 'dart:convert';

import 'package:learning_bloc/todo_list/todo_model.dart';

class TodoListUtils {
  // bước 1: chuyển Model to Map
  Map<String, dynamic> convertModelToJson(TodoModel model) {
    Map<String, dynamic> dataJson = Map<String, dynamic>();
    dataJson['name'] = model.name;
    dataJson['id'] = model.id;
    dataJson['dateTime'] = model.dateTime;
    return dataJson;
  }

  // bước 2: chuyển Map về dạng String

  String convertMapToString(Map<String, dynamic> inputData) {
    String result = jsonEncode(inputData);
    return result;
  }


}
