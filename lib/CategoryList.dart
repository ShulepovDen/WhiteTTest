import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';

class Category {
  final int categoryId;
  final String title;
  final String? imageUrl;
  final int hasSubcategories;
  final String fullName;
  final String? categoryDescription;
  // "categoryId": 1774,
  //       "title": "СПЕЦ ИНСТРУМЕНТ ",
  //       "imageUrl": "https://www.klimat4you.ru/upload/iblock/b17/b17359516e1f46912e57f3ba458c5c49.jpg",
  //       "hasSubcategories": 1,
  //       "fullName": "СПЕЦ ИНСТРУМЕНТ ",
  //       "categoryDescription": null

  const Category({
    required this.categoryId,
    required this.title,
    required this.imageUrl,
    required this.hasSubcategories,
    required this.fullName,
    required this.categoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      hasSubcategories: json['hasSubcategories'],
      fullName: json['fullName'],
      categoryDescription: json['categoryDescription'],
    );
  }
}

class CategoryService {
  Future<List<Category>> getCategory() async {
    final response = await http.get(Uri.parse(
        "http://ostest.whitetigersoft.ru/api/common/category/list?appKey=phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Category> list = [];
      for (var i = 0; i < data['data']['categories'].length; i++) {
        final entry = data['data']['categories'][i];
        list.add(Category.fromJson(entry));
      }
      return list;
    } else {
      throw Exception('HTTP failed');
    }
  }
}
