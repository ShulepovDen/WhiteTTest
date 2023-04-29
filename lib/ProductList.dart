import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/CategoryList.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';

class Product {
  final String title;
  final int productId;
  final String? productDescription;
  final int price;
  final double? rating;
  final Image? image;
  final String? imageUrl;
  final int isAvailableForSale;

  const Product({
    required this.title,
    required this.productId,
    required this.productDescription,
    required this.price,
    required this.rating,
    required this.image,
    required this.imageUrl,
    required this.isAvailableForSale,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      productId: json['productId'],
      productDescription: json['productDescription'],
      price: json['price'],
      rating: json['rating'],
      image: json['image'],
      imageUrl: json['imageUrl'],
      isAvailableForSale: json['isAvailableForSale'],
    );
  }
}

class ProductService {
  Future<List<Product>> getProduct(Category category) async {
    final response = await http.get(Uri.parse(
        "http://ostest.whitetigersoft.ru/api/common/product/list?categoryId=${category.categoryId}&appKey=phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Product> list = [];
      for (var i = 0; i < data['data'].length; i++) {
        final entry = data['data'][i];
        list.add(Product.fromJson(entry));
      }
      return list;
    } else {
      throw Exception('HTTP failed');
    }
  }
}
