import 'package:flutter/material.dart';

import '../model/entities/category.dart';
import '../pages/product_grid_page.dart';
import 'extended_image_widget.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  const CategoryGridItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      title: Container(
        child: Text(
          category.title,
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
      subtitle: Container(
        padding: EdgeInsets.only(top: 20),
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: ExtendedImageWidget(
            widthImage: 100, heightImage: 100, category: category),
      ),
      onTap: () => openPage(context, category),
    );
  }
}

void openPage(context, Category category) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductListPage(
        category: category,
      ),
    ),
  );
}
