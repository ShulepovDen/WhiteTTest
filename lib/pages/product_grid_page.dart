import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/entities/category_template.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_application_2/model/variable/lists.dart';
import 'package:flutter_application_2/model/variable/offset.dart';

import '../model/entities/product_template.dart';
import '../model/api/api_control.dart';
import '../view/card_builder.dart';
import '../view/extended_image_builder.dart';
import '../view/list_view_builder.dart';

class ProductWidget extends StatefulWidget {
  final Category category;
  const ProductWidget({Key? key, required this.category});

  @override
  State<ProductWidget> createState() => _ProductWidgetState(
        this.category,
      );
}

class _ProductWidgetState extends State<ProductWidget> {
  Category category;
  late Future<List> futureProducts;
  _ProductWidgetState(this.category);
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_onScrollEvent);
    super.initState();
    futureProducts = BaseApi().loadList(
      typeItemRequested: "product",
      category: category,
    );
  }

  void _onScrollEvent() {
    final extentAfter = _controller.position.extentAfter;
    // print("Extent after: $extentAfter");
    if (extentAfter <= 10) {
      futureProducts = BaseApi().loadList(
        typeItemRequested: "product",
        category: category,
        offset: offsetProduct.toString(),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        listProduct.clear();
        offsetProduct = 0;
        return true;
      },
      child: Scaffold(
        appBar: buildAppBar(),
        body: Center(
          child: FutureBuilder<List>(
            future: futureProducts,
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return buldListView(snapshot, _controller);
              } else if (snapshot.hasError) {
                return Text('ERROR: ${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }),
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: buildAppBar(),
  //     body: Center(
  //       child: FutureBuilder<List>(
  //         future: futureProducts,
  //         builder: ((context, AsyncSnapshot snapshot) {
  //           if (snapshot.hasData) {
  //             return buldListView(snapshot);
  //           } else if (snapshot.hasError) {
  //             return Text('ERROR: ${snapshot.error}');
  //           }
  //           return const CircularProgressIndicator();
  //         }),
  //       ),
  //     ),
  //   );
  // }

  AppBar buildAppBar() => AppBar(
        title: Text(category.title),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.shopping_cart),
        //     tooltip: 'Open shopping cart',
        //     onPressed: () {
        //       futureProducts = BaseApi().loadList(
        //         typeItemRequested: "product",
        //         category: category,
        //         offset: offsetProduct.toString(),
        //       );
        //       setState(() {});
        //     },
        //   ),
        // ],
      );
}
