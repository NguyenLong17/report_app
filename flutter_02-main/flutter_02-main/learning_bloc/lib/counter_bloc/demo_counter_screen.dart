import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/counter_bloc/counter_bloc.dart';
import 'package:learning_bloc/counter_bloc/counter_bloc_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final _counterCubit = CounterCubit();
  final _counterCubit2 = CounterCubit2();
  late SharedPreferences prefs;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _initSharePreference();
    super.initState();
  }

  void _initSharePreference() async {
    prefs = await SharedPreferences.getInstance();
    testSaveDataLocal();
  }

  void testSaveDataLocal() async {
    await prefs.setInt('counter', 10);
// Save an boolean value to 'repeat' key.
    await prefs.setBool('repeat', true);
// Save an double value to 'decimal' key.
    await prefs.setDouble('decimal', 1.5);
// Save an String value to 'action' key.
    await prefs.setString('action', 'Start');
// Save an list of strings to 'items' key.
    await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);

    print('DataInt: ${prefs.getInt('counter')} \n'
        'DataBool: ${prefs.getBool('repeat')} \n'
        'DataDouble: ${prefs.getDouble('decimal')} \n'
        'DataString: ${prefs.getString('action')} \n'
        'DataStringList: ${prefs.getStringList('items')} \n');
    prefs.remove('key');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Counter')),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CounterCubit>(create: (_) => _counterCubit),
          BlocProvider<CounterCubit2>(create: (_) => _counterCubit2),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<CounterCubit, int>(
              bloc: _counterCubit,
              listener: (context, count) {
                if (count.runtimeType == int && count % 5 == 0) {
                  print('lucky number');
                }
              },
            ),
            BlocListener<CounterCubit2, int>(
              bloc: _counterCubit2,
              listener: (context, count) {},
            ),
          ],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // BlocListener<CounterCubit2, int>(
              //   bloc: _counterCubit2,
              //   listener: (context, count) {},
              //   child: BlocListener<CounterCubit, int>(
              //     bloc: _counterCubit,
              //     listener: (context, count) {
              //       if (count.runtimeType == int && count % 5 == 0) {
              //         print('lucky number');
              //       }
              //     },
              //     child: BlocBuilder<CounterCubit, int>(
              //       builder: (context, count) => Center(child: Text('$count')),
              //       bloc: _counterCubit,
              //     ),
              //   ),
              // ),
              // BlocConsumer<CounterCubit, int>(
              //     bloc: _counterCubit,
              //     builder: (context, count) => Center(child: Text('$count')),
              //     listener: (context, count) {
              //       if (count.runtimeType == int && count % 5 == 0) {
              //         print('lucky number');
              //       }
              //     }),
              InkWell(
                child: Text('Luu du lieu'),
                onTap: () async {
                  String data =
                      'Toi da o day luc ${DateTime.now().hour} ${DateTime.now().minute} ${DateTime.now().second}';
                  SharedPreferences preferance =
                      await SharedPreferences.getInstance();
                  preferance.setString('TestLuuString', data);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: Text('Lay du lieu'),
                onTap: () async {
                  SharedPreferences preferance =
                      await SharedPreferences.getInstance();
                  String duLieuDaLuu =
                      preferance.getString('TestLuuString') ?? '';
                  print('duLieuDaLuu: $duLieuDaLuu');
                },
              ),
            ],
          ),
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
