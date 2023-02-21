import 'package:flutter/material.dart';
import 'package:techmaster_buoi3/common/cache_image.dart';
import 'package:techmaster_buoi3/example/list_category/category_model.dart';

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
        CustomCacheImageNetwork(
          url: model.urlPicture ?? '',
          height: 80,
          width: 80,
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
