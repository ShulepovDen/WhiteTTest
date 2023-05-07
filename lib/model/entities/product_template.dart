import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/entities/category_template.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_template.g.dart';

@JsonSerializable()
class Product {
  final String title;
  final int productId;
  final String? productDescription;
  final int price;
  final double? rating;
  final String? image;
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
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(
  //     title: json['title'],
  //     productId: json['productId'],
  //     productDescription: json['productDescription'],
  //     price: json['price'],
  //     rating: json['rating'],
  //     image: json['image'],
  //     imageUrl: json['imageUrl'],
  //     isAvailableForSale: json['isAvailableForSale'],
  //   );
  // }
}
