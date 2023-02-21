import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/cart/cart_screen.dart';
import 'package:mini_shop/list_product/list_product_cubit.dart';
import 'package:mini_shop/list_product/product_model.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  bool _runFirstTime = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listProductCubit = BlocProvider.of<ListProductCubit>(context);
    if (_runFirstTime) {
      _runFirstTime = false;
      listProductCubit.convertListStringToListModel();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sach san pham'),
        actions: [
          InkWell(
            onTap: () async {
              // await để chờ lấy dữ liệu trả về từ màn hình giỏ hàng
              final data = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );

              // check nếu có dữ liệu trả về khác null thì cập nhật lại giao list selected
              // và cập nhật lại giao diện
              if (data != null) {
                listProductCubit.updateDataSelectedNew(data);
              }
            },
            child: BlocBuilder<ListProductCubit, ProductState>(
              // khi Cubit đc cung cấp bởi BlocProvider ở widget cha thì ko cần dòng này nữa
              // bloc: _listProductCubit,
              builder: (_, state) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.shopping_cart),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                              '${listProductCubit.listProductSelected.length}'),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<ListProductCubit, ProductState>(
        builder: (_, ProductState state) {
          // đang lấy dữ liệu
          if (state is ProductGettingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // lấy dữ liệu thành công
          if (state is ProductGetSuccessState &&
              listProductCubit.listProduct.isNotEmpty) {
            List<ProductModel> listProducts = listProductCubit.listProduct;
            return ListView.separated(
              itemBuilder: (context, index) {
                return ItemProductWidget(
                  productModel: listProducts[index],
                  onAddItem: (ProductModel model) {
                    listProductCubit.addItemToCart(model);
                  },
                  isSelected: listProductCubit.listProductSelected
                      .contains(listProducts[index]),
                );
              },
              itemCount: listProducts.length,
              separatorBuilder: (_, index) {
                return SizedBox(height: 12);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class ItemProductWidget extends StatelessWidget {
  final ProductModel productModel;
  final Function(ProductModel productModel) onAddItem;
  final bool isSelected;

  const ItemProductWidget({
    Key? key,
    required this.productModel,
    required this.onAddItem,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          color: productModel.color ?? Colors.grey,
        ),
        const SizedBox(width: 16),
        Expanded(child: Text('${productModel.name}')),
        isSelected
            ? Icon(Icons.check)
            : InkWell(
                child: Text('Them'),
                onTap: () {
                  onAddItem(productModel);
                },
              ),
      ],
    );
  }
}
