import 'dart:math';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/list_product/product_model.dart';

class ListProductCubit extends Cubit<ProductState> {
  ListProductCubit() : super(ProductInitState());

  List<ProductModel> listProduct = [];
  List<ProductModel> listProductSelected = [];

  void addItemToCart(ProductModel model) {
    if (!listProductSelected.contains(model)) {
      listProductSelected.add(model);
      emit(ProductGetSuccessState());
    }
  }

  // xóa 1 item trong list product đã chọn
  void onRemoveItemSelected(ProductModel model){
    listProductSelected.remove(model);
    emit(ProductGetSuccessState());
  }

  void updateDataSelectedNew(List<ProductModel> newSelected) {
    listProductSelected = newSelected;
    emit(ProductGetSuccessState());
  }

  void convertListStringToListModel() async {
    // phát tín hiệu đang xử lý
    emit(ProductGettingState());
    await Future.delayed(Duration(seconds: 2));
    for (int i = 0; i < itemNames.length; i++) {
      String item = itemNames[i];
      // Tạo Product model rỗng
      ProductModel model = ProductModel();

      // gán dữ liệu cho model rỗng vừa tạo
      model.name = item;
      model.price = 12;
      Random random = Random();
      model.color = Color.fromRGBO(
          random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);

      // thêm model vừa convert vào list
      listProduct.add(model);
    }

    // phát tín hiệu đã xử lý xong
    emit(ProductGetSuccessState());
  }

  List<String> itemNames = [
    'Gà KFC',
    'Trà sữa',
    'Vịt quay bắc kinh',
    'Sữa chua hạ long',
    'Gà ủ muối',
    'Bia Tiger',
    'Spaghetti',
    'Pizza',
    'Bánh mì hội an',
    'Phở thìn',
    'Chân gà',
    'Coffee',
    'Trà',
    'Xôi',
    'Cơm',
  ];
}

class ProductState {}

class ProductInitState extends ProductState {}

// tins hiệu đang xử lý dữ liệu
class ProductGettingState extends ProductState {}

// Tín hiệu đã xử lý thành công dữ liệu
class ProductGetSuccessState extends ProductState {}
