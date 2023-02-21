import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/todo_list/bloc/todo_list_bloc.dart';
import 'package:learning_bloc/todo_list/bloc/todo_list_state.dart';
import 'package:learning_bloc/todo_list/todo_list_util.dart';
import 'package:learning_bloc/todo_list/todo_model.dart';
import 'package:learning_bloc/todo_list/widgets/todo_list_item.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final _todoListCubit = TodoListCubit();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TodoModel? _todoModelSelected;
  FocusNode inputNode = FocusNode();
  String _name = '';

  @override
  void initState() {
    _todoListCubit.getDataFromLocal();
    super.initState();
  }

  void _onRemove() {
    if (_todoModelSelected != null) {
      _todoListCubit.removeItemTodo(_todoModelSelected!.id ?? '');
    }
  }

  void _onCreate() {
    if (validateAndSave(_formKey)) {
      return;
    }
    _todoListCubit.createItemTodo(_nameController.text);
    _nameController.text = '';
  }

  void _onItemTap(TodoModel model) {
    if (_todoModelSelected?.id == model.id) {
      // bo chon
      _todoModelSelected = null;
      _nameController.text = '';

      // tat ban phim
      FocusScope.of(context).requestFocus(FocusNode());
    } else {
      // chon
      _todoModelSelected = model;
      _nameController.text = model.name ?? '';

      // set con trỏ về cuối
      _nameController.selection = TextSelection.fromPosition(
          TextPosition(offset: _nameController.text.length));

      // bật bàn phím
      FocusScope.of(context).requestFocus(inputNode);
    }
    _todoListCubit.emitToUpdateUi();
  }

  void _onUpdate() {
    if (_todoModelSelected == null) {
      return;
    }
    _todoListCubit.updateItemInListToDo(
      _todoModelSelected!,
      _nameController.text,
    );
    _todoModelSelected = null;
    _nameController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TodoList'),
        actions: [
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: _onUpdate,
          ),
          BlocBuilder(
            bloc: _todoListCubit,
            builder: (_, state) {
              if (state is TodoListCreatingState) {
                return const SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: _onCreate,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: _onRemove,
          ),
        ],
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    // c2
                    // onChanged: (String? value) {
                    //   print('nguoi dung dang nhap: $value');
                    //   _name = value ?? '';
                    // },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui long nhap ten';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Nhap ten todo'),
                    focusNode: inputNode,
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: BlocBuilder<TodoListCubit, TodoListState>(
            bloc: _todoListCubit,
            builder: (_, state) {
              if (state is TodoListLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (_todoListCubit.listTodo.isNotEmpty) {
                _todoListCubit.listTodo.sort(
                    (a, b) => (b.dateTime ?? 0).compareTo((a.dateTime ?? 0)));
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (_, index) {
                    final itemModel = _todoListCubit.listTodo[index];
                    return TodoListItem(
                      todoModel: _todoListCubit.listTodo[index],
                      onTap: _onItemTap,
                      selected: _todoModelSelected?.id == itemModel.id,
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 12);
                  },
                  itemCount: _todoListCubit.listTodo.length,
                );
              }
              return const Center(
                child: Text('Chua co du lieu'),
              );
            },
          ))
        ],
      ),
    );
  }
}
