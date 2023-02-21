import 'package:flutter/material.dart';
import 'package:learning_provider/provider_base.dart';
import 'package:provider/provider.dart';

class ProviderChangeScreen extends StatefulWidget {
  const ProviderChangeScreen({Key? key}) : super(key: key);

  @override
  State<ProviderChangeScreen> createState() => _ProviderChangeScreenState();
}

class _ProviderChangeScreenState extends State<ProviderChangeScreen> {
  @override
  Widget build(BuildContext context) {
    // print('_ProviderChangeScreenState build');
    // BlocProvider.of<ProductProvider>(context);
    // context.watch<ProductProvider>()
    print('on Build');
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Chỉ lấy thể hiện của ProductProvider và ko có công dụng lắng nghe sự thay đổi
            /// của ProductProvider.
            // Text('ProductProvider: ${context.read<ProductProvider>().name}'),

            /// Lắng nghe sự thay đổi của ProductProvider và gọi làm hàm build
            /// của widget chứa context
            // Text('ProductProvider: ${context.watch<ProductProvider>().name}'),
            // Text('Student: ${context.watch<Student>().name}'),
            Consumer(
              builder: (_, Student product, __) {
                print('on builder');
                return Text('${product.name}');
              },
            ),
            Consumer(
              builder: (_, ProductProvider product, __) {
                print('on builder');
                return Text('${product.name}');
              },
            ),

            InkWell(
              onTap: () {
                context.read<ProductProvider>().updateName('Bun cha');
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Cap nhat product'),
              ),
            )
            // Consumer<ProductProvider>(
            //   builder: (context, model, _) {
            //     // chỉ được gọi khi ProductProvider thay đổi
            //     print('builder');
            //     if(model.currentStatus=='A'){
            //       return CircularProgressIndicator();
            //     }
            //     if(model.currentStatus=='B'){
            //       return ListView();
            //     }
            //     return Text('${model.name}');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class DisplayContent extends StatelessWidget {
  const DisplayContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? name = context.watch<ProductProvider>().name;
    return Column(
      children: [
        Text(name ?? ''),

      ],
    );
  }
}

class ProductProvider extends ChangeNotifier {
  String? name;
  int currentStatus = 0;

  ProductProvider({this.name});

  void updateName(String newName) {
    name = newName;
    // thay đổi ProductProvider và truyền tín hiệu tới tất cả những thằng đang lắng nghe nó
    notifyListeners();
  }
}
