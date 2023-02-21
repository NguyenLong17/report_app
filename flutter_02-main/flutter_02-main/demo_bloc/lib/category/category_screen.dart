import 'package:demo_bloc/category/bloc/category_cubit.dart';
import 'package:demo_bloc/category/bloc/category_state.dart';
import 'package:demo_bloc/category/category_model.dart';
import 'package:demo_bloc/category/item_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _categoryCubit = CategoryCubit();

  @override
  void initState() {
    _categoryCubit.getListCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh muc san pham'),
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        bloc: _categoryCubit,
        builder: (_, state) {
          if (state is CategoryGettingDataState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CategoryGetDataSuccessState &&
              _categoryCubit.listCategory.isNotEmpty) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 160,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 16,
                ),
                itemCount: _categoryCubit.listCategory.length,
                padding:const EdgeInsets.all(16),
                itemBuilder: (BuildContext context, int index) {
                  return CategoryItem(
                    model: _categoryCubit.listCategory[index],
                  );
                });
          }
          return const Text('Empty');
        },
      ),
    );
  }
}
