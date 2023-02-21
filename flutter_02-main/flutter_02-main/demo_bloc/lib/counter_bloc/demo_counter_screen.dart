import 'package:demo_bloc/counter_bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final _counterCubit = CounterCubit();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Counter')),
      body: BlocListener<CounterCubit, int>(
        bloc: _counterCubit,
        listener: (context, count) {
          if (count.runtimeType == int && count % 5 == 0) {
            print('lucky number');
          }
        },
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, count) => Center(child: Text('$count')),
          bloc: _counterCubit,
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _counterCubit.increment(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => _counterCubit.decrement(),
          ),
        ],
      ),
    );
  }
}
