import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entities/category.dart';
import '../entities/product.dart';

class CategoryApi extends BaseApi {
  Future<List<Category>> loadCategories({
    Category? parentCategory,
    int? offset,
  }) async {
    var params = await prepareParams(
      offset: offset != null ? offset.toString() : "",
    );
    var uri = await createAbsoluteUrl(
      pathTo: "/api/common/category/list",
      params: params,
    );
    var jsonResponse = await sendGetRequest(
      relativeUrl: uri,
    );
    final List<Category> list = [];
    var dataJson = jsonResponse['data'];
    var categoriesJson = dataJson['categories'];
    for (var categoryJson in categoriesJson) {
      var categoryItem = Category.fromJson(categoryJson);
      list.add(categoryItem);
    }
    return list;
  }
}

class ProductApi extends BaseApi {
  Future<List<Product>> loadProducts({
    Category? parentCategory,
    int? offset,
  }) async {
    var params = await prepareParams(
      offset: offset != null ? offset.toString() : "",
      categoryId:
          parentCategory != null ? parentCategory.categoryId.toString() : "",
    );
    var uri = await createAbsoluteUrl(
      pathTo: "/api/common/product/list",
      params: params,
    );
    var jsonResponse = await sendGetRequest(
      relativeUrl: uri,
    );
    final List<Product> list = [];
    var dataJson = jsonResponse['data'];
    for (var categoryJson in dataJson) {
      var categoryItem = Product.fromJson(categoryJson);
      list.add(categoryItem);
    }
    return list;
  }
}

class BaseApi {
  final urlTigerSoft = "ostest.whitetigersoft.ru";
  Future<Map<String, dynamic>> sendGetRequest({
    required Uri relativeUrl,
  }) async {
    final response = await http.get(relativeUrl);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('HTTP failed');
    }
  }

  Future<Uri> createAbsoluteUrl({
    String? pathTo,
    Map<String, String>? params,
  }) async {
    var url = Uri.http(urlTigerSoft, (pathTo != null) ? pathTo : "",
        (params != null) ? params : {});
    return url;
  }

  Future<Map<String, String>> prepareParams({
    String? offset,
    String? categoryId,
    Map<String, String>? additionalParams,
  }) async {
    var params = {
      if (offset != null) "offset": offset,
      if (categoryId != null) "categoryId": categoryId,
      "appKey":
          "phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF"
    };
    return params;
  }
}
