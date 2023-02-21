import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderBaseScreen extends StatefulWidget {
  const ProviderBaseScreen({Key? key}) : super(key: key);

  @override
  State<ProviderBaseScreen> createState() => _ProviderBaseScreenState();
}

class _ProviderBaseScreenState extends State<ProviderBaseScreen> {
  @override
  Widget build(BuildContext context) {
    // Student student1 = Student('name');
    // Student student1 = Student(name: 'hoc sinh 2',id: '1',tuoi: '19');
    // Student student1 = Student('hoc sinh 2','fdf','fdf');
    // student1.name = 'hoc sinh';
    return Scaffold(
      body: Container(
        child: Center(
          child: InkWell(
            onTap: () {
              Student student = context.read<Student>();
            },
            child: Text('Bat dau su dung student'),
          ),
        ),
      ),
    );
  }
}

class Student {
  String? name;
  String? tuoi;
  String? id;

  // Student(this.name,this.tuoi,this.id);
  Student({this.name,this.tuoi,this.id});
  // Student([this.name,this.tuoi,this.id]);
}
