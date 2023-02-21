import 'package:demo_bloc/todo_list/bloc/todo_list_state.dart';
import 'package:demo_bloc/todo_list/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListInitState());
  List<TodoModel> listTodo = [];

  void createItemTodo(String name) async {
    for (final obj in listTodo) {
      if (obj.name == name) {
        showToast('Đã bị trùng tên');
        return;
      }
    }
    emit(TodoListCreatingState());
    final model = TodoModel(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      dateTime: DateTime.now().toString(),
    );
    await Future.delayed(const Duration(seconds: 2));
    listTodo.add(model);
    emit(TodoListCreatedState());
  }

  void removeItemTodo(String id) {
    listTodo.removeWhere((element) => element.id == id);
    emit(TodoListCreatedState());
  }
}

