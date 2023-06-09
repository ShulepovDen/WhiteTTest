import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/entities/category.dart';
import 'package:extended_image/extended_image.dart';

import '../model/entities/product.dart';

class ExtendedImageWidget extends StatelessWidget {
  final double widthImage;
  final double heightImage;
  Product? product;
  Category? category;
  ExtendedImageWidget({
    super.key,
    this.product,
    this.category,
    required this.widthImage,
    required this.heightImage,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      product?.imageUrl.toString() ??
          category?.imageUrl.toString() ??
          "assets/images/istockphoto.jpg",
      width: widthImage,
      height: heightImage,
      fit: BoxFit.fill,
      cache: false,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Image.asset(
              "assets/images/retrowave.gif",
              fit: BoxFit.fill,
            );
            break;

          ///if you don't want override completed widget
          ///please return null or state.completedWidget
          //return null;
          //return state.completedWidget;
          case LoadState.completed:
            return FadeTransition(
              opacity: AlwaysStoppedAnimation<double>(1),
              child: ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                width: 50,
                height: 50,
              ),
            );
            break;
          case LoadState.failed:
            return GestureDetector(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    "assets/images/istockphoto.jpg",
                    fit: BoxFit.fill,
                  ),
                  const Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Text(
                      "failed, click to reload",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
            break;
        }
      },
    );
  }
}
