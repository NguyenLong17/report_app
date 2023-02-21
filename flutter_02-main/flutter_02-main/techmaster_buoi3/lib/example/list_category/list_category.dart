import 'package:flutter/material.dart';
import 'package:techmaster_buoi3/example/list_category/category_model.dart';
import 'package:techmaster_buoi3/example/list_category/item_category.dart';

class ListCategory extends StatefulWidget {
  const ListCategory({Key? key}) : super(key: key);

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  List<CategoryModel> _categories = [];

  @override
  void initState() {
    jsonCategory.forEach((element) {
      _categories.add(CategoryModel.fromJson(element));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 160,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
          ),
          itemCount: _categories.length,
          padding: EdgeInsets.all(16),
          itemBuilder: (BuildContext context, int index) {
            return CategoryItem(
              model: _categories[index],
            );
          }),
    );
  }
}
