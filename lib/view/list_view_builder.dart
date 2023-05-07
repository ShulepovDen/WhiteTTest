import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/entities/category_template.dart';
import 'package:extended_image/extended_image.dart';

import '../model/entities/product_template.dart';
import '../model/api/api_control.dart';
import 'card_builder.dart';

ListView buldListView(AsyncSnapshot<dynamic> snapshot, _controller) {
  return ListView.separated(
      controller: _controller,
      itemBuilder: (context, index) {
        var product = snapshot.data?[index];
        return buildCard(product);
      },
      separatorBuilder: ((context, index) {
        return const Divider(color: Colors.black26);
      }),
      itemCount: snapshot.data!.length);
}
