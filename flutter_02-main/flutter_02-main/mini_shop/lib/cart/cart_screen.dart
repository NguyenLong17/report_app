import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/list_product/list_product_cubit.dart';
import 'package:mini_shop/list_product/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final listProductCubit = BlocProvider.of<ListProductCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gio hang'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<ListProductCubit, ProductState>(
        builder: (_, state) {
          int tongTien = 0;
          for (ProductModel obj in listProductCubit.listProductSelected) {
            tongTien += obj.price ?? 0;
          }
          return Column(
            children: [
              Text('Tong tien: $tongTien'),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (_, index) {
                  ProductModel model =
                      listProductCubit.listProductSelected[index];
                  return _itemWidget(model, () {
                    listProductCubit.onRemoveItemSelected(model);
                  });
                },
                itemCount: listProductCubit.listProductSelected.length,
              ))
            ],
          );
        },
      ),
    );
  }

  Widget _itemWidget(ProductModel model, Function onRemove) {
    return Row(
      children: [
        Expanded(child: Text('${model.name}')),
        InkWell(
          onTap: () {
            onRemove();
          },
          child: Icon(Icons.remove_circle),
        )
      ],
    );
  }
}
