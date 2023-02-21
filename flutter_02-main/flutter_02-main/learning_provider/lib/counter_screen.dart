import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    print('on Build');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(builder: (_, CounterProvider model, __) {

            print('on builder');
            return Text('${model.counter}');
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  context.read<CounterProvider>().increase();
                },
                child: Text('Cong'),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: (){
                  context.read<CounterProvider>().deIncrease();
                },
                child: Text('Tru'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CounterProvider extends ChangeNotifier {
  int counter = 0;

  void increase() {
    counter = counter + 1;
    notifyListeners();
  }

  void deIncrease() {
    counter = counter - 1;
    notifyListeners();
  }
}
