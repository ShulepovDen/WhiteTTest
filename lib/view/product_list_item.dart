import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/entities/product.dart';
import 'extended_image_widget.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  const ProductListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(product.title),
        children: <Widget>[
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              child: ExtendedImageWidget(
                  widthImage: 50, heightImage: 50, product: product),
            ),
            title: Text("Цена: " + product.price.toString()),
          ),
          if (product.productDescription?.isNotEmpty ?? false)
            ListTile(
              dense: true,
              visualDensity: VisualDensity(vertical: -3),
              title: Text(product.productDescription ?? ""),
            )
        ],
      ),
    );
  }
}
