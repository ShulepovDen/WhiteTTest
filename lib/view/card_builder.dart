import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/entities/category_template.dart';
import 'package:extended_image/extended_image.dart';

import '../model/entities/product_template.dart';
import '../model/api/api_control.dart';
import 'extended_image_builder.dart';

Card buildCard(Product product) {
  return Card(
    child: ExpansionTile(
      title: Text(product.title),
      children: <Widget>[
        ListTile(
          leading: Container(
            width: 50,
            height: 50,
            child: buildExtendedImage(
                widthImage: 50, heightImage: 50, product: product),
          ),
          title: Text("Цена: " + product.price.toString()),
        ),
        ListTile(
          dense: true,
          visualDensity: VisualDensity(vertical: -3),
          title: Text(product.productDescription.toString() != "null"
              ? product.productDescription.toString()
              : ''),
        )
      ],
    ),
  );
}
