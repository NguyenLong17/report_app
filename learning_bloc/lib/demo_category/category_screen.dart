import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/demo_category/category_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryCubit _categoryCubit = CategoryCubit();

  @override
  void initState() {
    _categoryCubit.createListCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Danh muc san pham'),
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        bloc: _categoryCubit,
        builder: (_, state) {
          if (state is CategoryGettingState) {
            // return Center(child: Text('Dang lay du lieu'));
            return Center(child: CircularProgressIndicator());
          }
          if (state is CategoryGetFailState) {
            return Center(child: Text('Loi lay du lieu'));
          }
          if (state is CategoryGetSuccessState &&
              _categoryCubit.listCategory.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 160, // chiều dài của một item
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return CategoryItem(
                  categoryModel: _categoryCubit.listCategory[index],
                );
              },
              itemCount: _categoryCubit.listCategory.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryItem({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          categoryModel.urlPicture ?? '',
          loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
            // return widget khi đang load ảnh
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
          errorBuilder: (
            BuildContext context,
            Object error,
            StackTrace? stackTrace,
          ) {
            // return widget khi lỗi ảnh
            return const SizedBox(
              width: 80,
              height: 80,
              child: Center(
                child: Text('Lỗi ảnh', style: TextStyle(color: Colors.red)),
              ),
            );
          },
          width: 80,
          height: 80,
        ),
        Text(
          categoryModel.name ?? '',
        ),
      ],
    );
  }
}
