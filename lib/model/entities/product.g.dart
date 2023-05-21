// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      title: json['title'] as String,
      productId: json['productId'] as int,
      productDescription: json['productDescription'] as String?,
      price: json['price'] as int,
      rating: (json['rating'] as num?)?.toDouble(),
      image: json['image'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isAvailableForSale: json['isAvailableForSale'] as int,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'title': instance.title,
      'productId': instance.productId,
      'productDescription': instance.productDescription,
      'price': instance.price,
      'rating': instance.rating,
      'image': instance.image,
      'imageUrl': instance.imageUrl,
      'isAvailableForSale': instance.isAvailableForSale,
    };
