import 'package:demo_bloc/category/category_model.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel model;

  const CategoryItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          model.urlPicture ?? '',
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10),
        Text(
          model.name ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
