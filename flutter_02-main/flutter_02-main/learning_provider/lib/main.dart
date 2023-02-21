import 'package:flutter/material.dart';
import 'package:learning_provider/counter_screen.dart';
import 'package:learning_provider/provider_base.dart';
import 'package:learning_provider/provider_change.dart';
import 'package:learning_provider/todo_list/todo_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
      create: (_) => TodoListProvider(),
      child: TodoListScreen(),
    ),
  ));

  // runApp(MaterialApp(
  //   home: MultiProvider(
  //     providers: [
  //       // Provider(
  //       //   create: (_) => Student(name: 'Nguyen van A'),
  //       // ),
  //       ChangeNotifierProvider(
  //         create: (_) => ProductProvider(name: 'Banh mi'),
  //       ),
  //       // Lắng nghe sự thay đổi của ProductProvider, chuyển tiếp sự thay đổi tới Student
  //       ProxyProvider<ProductProvider, Student>(
  //         update: (_, ProductProvider product, __) =>
  //             Student(name: product.name),
  //       ),
  //     ],
  //     child: ProviderChangeScreen(),
  //   ),
  // ));

  // runApp(Provider(
  //   create: (_) {
  //     return Student(name: 'Nguyen van A');
  //   },
  //   lazy: false,
  //   child: MaterialApp(
  //     home: ProviderBaseScreen(),
  //   ),
  // ));

  // runApp(MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(create: (_) {
  //       return ProductProvider(name: 'Banh mi');
  //     }),
  //     Provider(create: (_) {
  //       return Student(name: 'Nguyen van A');
  //     }),
  //   ],
  //   child: MaterialApp(
  //     home: ProviderChangeScreen(),
  //   ),
  // ));

  // runApp(ChangeNotifierProvider(
  //   create: (_) {
  //     return CounterProvider();
  //   },
  //   lazy: false,
  //   child: MaterialApp(
  //     home: CounterScreen(),
  //   ),
  // ));
}
