import 'package:demo_bloc/category/bloc/category_state.dart';
import 'package:demo_bloc/category/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitState());
  List<CategoryModel> listCategory = [];

  void getListCategory() async {
    emit(CategoryGettingDataState());
    for (var element in jsonCategory) {
      listCategory.add(CategoryModel.fromJson(element));
    }
    await Future.delayed(const Duration(seconds: 2));
    emit(CategoryGetDataSuccessState());
  }
}

const jsonCategory = [
  {
    "Name": "Thời trang",
    "UrlPicture":
        "https://bizweb.dktcdn.net/100/431/474/collections/icon-thiet-ke-linh-vuc-logo-thuong-hieu-thoi-trang-my-pham-lam-dep-spa-baa-brand-1-400x400.png?v=1626059167330",
    "ID": 255
  },
  {
    "Name": "Phụ kiện",
    "UrlPicture": "https://thoxe.vn/wp-content/uploads/2019/08/Web_Icon.png",
    "ID": 259
  },
  {
    "Name": "Hoá mỹ phẩm",
    "UrlPicture":
        "https://png.pngtree.com/png-vector/20190831/ourlarge/pngtree-cosmetics-icon-design-vector-png-image_1710712.jpg",
    "ID": 263
  },
  {
    "Name": "Thực phẩm",
    "UrlPicture":
        "http://ptdtnttinhquangninh.edu.vn/wp-content/uploads/2018/08/Photo-basket-icon-300x295.png",
    "ID": 266
  },
  {
    "Name": "Đồ uống",
    "UrlPicture":
        "https://png.pngtree.com/element_our/20190531/ourlarge/pngtree-cartoon-juice-icon-download-image_1277511.jpg",
    "ID": 272
  },
  {
    "Name": "Văn phòng phẩm- lưu niệm",
    "UrlPicture":
        "https://png.pngtree.com/png-clipart/20190904/original/pngtree-stationery-tool-icon-png-image_4490939.jpg",
    "ID": 275
  },
  {
    "Name": "Sản phẩm sức khoẻ",
    "UrlPicture":
        "http://hongsamhanquocbmt.vn/upload/product/iconcssk-removebg-preview-1966.png",
    "ID": 278
  },
  {
    "Name": "Mẹ và bé",
    "UrlPicture":
        "https://thaikymevabe.com/wp-content/uploads/2019/08/khach_hang_icon.png",
    "ID": 284
  },
  {
    "Name": "Thiết bị điện tử",
    "UrlPicture":
        "https://png.pngtree.com/png-vector/20191017/ourlarge/pngtree-icon-set-of-electronic-tool-png-image_1821457.jpg",
    "ID": 287
  },
  {
    "Name": "Bất động sản",
    "UrlPicture":
        "https://png.pngtree.com/png-clipart/20190614/original/pngtree-real-estate-vector-icon-png-image_3746115.jpg",
    "ID": 291
  },
  {
    "Name": "Phương tiện",
    "UrlPicture":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Circle-icons-car.svg/1200px-Circle-icons-car.svg.png",
    "ID": 295
  },
  {
    "Name": "Dịch vụ",
    "UrlPicture":
        "https://img.lovepik.com/free-png/20210919/lovepik-customer-service-personnel-icon-png-image_400960936_wh1200.png",
    "ID": 299
  },
];
