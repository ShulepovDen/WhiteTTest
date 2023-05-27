import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/entities/category.dart';
import 'package:flutter_application_2/pages/product_page_model_view.dart';

import '../model/api/product_api.dart';
import '../model/entities/product.dart';
import '../view/product_list_item.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  final Category? category;

  const ProductListPage({
    super.key,
    required this.category,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductPageModelView productListModelView;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    productListModelView = ProductPageModelView(
      category: widget.category,
    );

    _controller.addListener(_onScrollEvent);
    super.initState();
    productListModelView.loadNextItems();
  }

  void _onScrollEvent() {
    final extentAfter = _controller.position.extentAfter;
    if (extentAfter <= 10) {
      productListModelView.loadNextItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productListModelView,
      child: Consumer<ProductPageModelView>(
        builder: (context, value, child) {
          return buildScaffold();
        },
      ),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: (productListModelView.shouldShowListLoader)
            ? const CircularProgressIndicator()
            : mainList(),
      ),
    );
  }

  ListView mainList() {
    return ListView.separated(
      controller: _controller,
      itemBuilder: (context, index) {
        var product = productListModelView.products[index];
        return ProductListItem(
          product: product,
        );
      },
      separatorBuilder: ((context, index) {
        return const Divider(
          color: Colors.black26,
        );
      }),
      itemCount: productListModelView.products.length,
    );
  }

  AppBar buildAppBar() => AppBar(
        title: Text(widget.category?.title ?? ""),
      );
}
