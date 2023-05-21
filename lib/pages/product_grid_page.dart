import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/entities/category.dart';

import '../model/entities/product.dart';
import '../model/api/base_api.dart';
import '../view/product_list_item.dart';

class ProductListPage extends StatefulWidget {
  final Category? category;
  const ProductListPage({super.key, required this.category});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductApi productApi = ProductApi();
  final List<Product> products = [];
  bool isLoading = false;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_onScrollEvent);
    super.initState();
    loadNextItems();
  }

  Future<void> reloadData() async {
    products.clear();
    loadNextItems();
  }

  Future<void> loadNextItems() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    List<Product> newProducts = await productApi.loadProducts(
      parentCategory: widget.category,
      offset: products.length,
    );
    products.addAll(newProducts);

    setState(() {
      isLoading = false;
    });
  }

  void _onScrollEvent() {
    final extentAfter = _controller.position.extentAfter;
    if (extentAfter <= 10) {
      loadNextItems();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: buildAppBar(),
        body: Center(
          child: (isLoading && products.isEmpty)
              ? const CircularProgressIndicator()
              : buldListView(),
        ),
      ),
    );
  }

  ListView buldListView() {
    return ListView.separated(
        controller: _controller,
        itemBuilder: (context, index) {
          var product = products[index];
          return ProductListItem(product: product);
        },
        separatorBuilder: ((context, index) {
          return const Divider(color: Colors.black26);
        }),
        itemCount: products.length);
  }

  Future<List<Product>> appendElements(Future<List<Product>> listFuture,
      Future<List<Product>> elementsToAdd) async {
    final list = await listFuture;
    final listAdd = await elementsToAdd;
    list.addAll(listAdd);
    return list;
  }

  AppBar buildAppBar() => AppBar(
        title: Text(widget.category != null ? widget.category!.title : ""),
      );
}
