import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TodoModel? _modelSelected;
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          Consumer(
            builder: (_, TodoListProvider todoListProvider, __) {
              if (todoListProvider.currentStatus == Status.creating) {
                return SizedBox(
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
                onPressed: () {
                  context
                      .read<TodoListProvider>()
                      .createNewTodo(_controller.text);
                  _controller.text = '';
                },
                icon: Icon(Icons.add),
              );
            },
          ),
          IconButton(
            onPressed: () {
              if (_modelSelected != null) {
                context.read<TodoListProvider>().onRemove(_modelSelected!);
              }
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Vui long nhap ten'),
          ),
          Expanded(
            child:
                Consumer(builder: (_, TodoListProvider todoListProvider, __) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  return _itemWidget(
                      todoListProvider.listTodos[index], todoListProvider);
                },
                itemCount: todoListProvider.listTodos.length,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _itemWidget(TodoModel model, TodoListProvider todoListProvider) {
    return InkWell(
      onTap: () {
        if (_modelSelected?.dateTime == model.dateTime) {
          _modelSelected = null;
        } else {
          _modelSelected = model;
        }
        todoListProvider.notiToUpdateUI();
      },
      child: Container(
        decoration: BoxDecoration(
            color: model.dateTime == _modelSelected?.dateTime
                ? Colors.green
                : Colors.grey),
        child: Column(
          children: [
            Text(model.name),
            Text(
                DateTime.fromMillisecondsSinceEpoch(model.dateTime).toString()),
          ],
        ),
      ),
    );
  }
}

class TodoListProvider extends ChangeNotifier {
  List<TodoModel> listTodos = [];
  Status currentStatus = Status.init;

  void notiToUpdateUI() {
    notifyListeners();
  }

  void createNewTodo(String name) async {
    currentStatus = Status.creating;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    int dateTime = DateTime.now().millisecondsSinceEpoch;
    TodoModel todoModel = TodoModel(name, dateTime);
    listTodos.add(todoModel);
    currentStatus = Status.created;
    notifyListeners();
  }

  void onRemove(TodoModel todoModel) {
    // c1 - Xóa phần tử trong list
    // for(int i=0;i<listTodos.length;i++){
    //   if(listTodos[i].dateTime==todoModel.dateTime){
    //     listTodos.removeAt(i);
    //   }
    // }

    //c2 Xóa phần tử trong list
    listTodos.removeWhere((element) => element.dateTime == todoModel.dateTime);
    notifyListeners();
  }
}

enum Status {
  init,
  creating,
  created,
  getSuccess,
  getFail,
  createFail,
}

class TodoModel {
  String name;
  int dateTime;

  TodoModel(this.name, this.dateTime);
}
