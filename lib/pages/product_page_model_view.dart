import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/entities/category.dart';

import '../model/api/product_api.dart';
import '../model/entities/product.dart';

class ProductPageModelView extends ChangeNotifier {
  final Category? category;
  final ProductApi productApi = ProductApi();
  final List<Product> products = [];
  bool isLoading = false;

  ProductPageModelView({
    this.category,
  });

  Future<void> reloadData() async {
    products.clear();
    isLoading = false;
    loadNextItems();
  }

  Future<void> loadNextItems() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    notifyListeners();

    var nextProducts = await productApi.loadProducts(
      parentCategory: category,
      offset: products.length,
    );
    products.addAll(nextProducts);
    isLoading = false;
    notifyListeners();
  }

  bool get shouldShowListLoader => (isLoading && products.isEmpty);
}
