import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/variable/offset.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';

import '../entities/category_template.dart';
import '../entities/product_template.dart';
import '../variable/lists.dart';

// class CategoryApi {
//   Future<List> loadCategoryList() async {
//     var params = {
//       "appKey":
//           "phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF"
//     };
//     var url = Uri.http(
//         "ostest.whitetigersoft.ru", "/api/common/category/list", params);
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       final List<Category> list = [];
//       var dataJson = data['data'];
//       var categoriesJson = dataJson['categories'];
//       for (var categoryJson in categoriesJson) {
//         var category = Category.fromJson(categoryJson);
//         list.add(category);
//       }
//       return list;
//     } else {
//       throw Exception('HTTP failed');
//     }
//   }
// }

class BaseApi {
  Future<List> loadList({
    required String typeItemRequested,
    Category? category,
    String? offset,
  }) async {
    var params = {
      if (offset != null) "offset": offset,
      if (category != null) "categoryId": category.categoryId.toString(),
      "appKey":
          "phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF"
    };
    var url = Uri.http("ostest.whitetigersoft.ru",
        "/api/common/$typeItemRequested/list", params);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var dataJson = data['data'];
      var lists;
      if (typeItemRequested == "product") {
        // final List<Product> list = [];
        for (var productJson in dataJson) {
          var productItem = Product.fromJson(productJson);
          listProduct.add(productItem);
        }
        lists = listProduct;
        offsetProduct += 15;
      } else if (typeItemRequested == "category") {
        final List<Category> list = [];
        var dataJson = data['data'];
        var categoriesJson = dataJson['categories'];
        for (var categoryJson in categoriesJson) {
          var categoryItem = Category.fromJson(categoryJson);
          listCategory.add(categoryItem);
        }
        lists = listCategory;
        offsetCategory += 15;
      }
      return lists;
    } else {
      throw Exception('HTTP failed');
    }
  }
}
