import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/entities/category.dart';

import '../model/api/category_api.dart';
import '../model/api/product_api.dart';
import '../model/entities/product.dart';

class CategoryPageModelView extends ChangeNotifier {
  final CategoryApi categoryApi = CategoryApi();
  final List<Category> categories = [];
  bool isLoading = false;

  CategoryPageModelView();

  Future<void> reloadData() async {
    categories.clear();
    isLoading = false;
    loadNextItems();
  }

  Future<void> loadNextItems() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    notifyListeners();
    var newCategories = await categoryApi.loadCategories();
    categories.addAll(newCategories);

    isLoading = false;
    notifyListeners();
  }

  bool get shouldShowListLoader => (isLoading && products.isEmpty);
}
