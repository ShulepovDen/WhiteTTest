import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/entities/product_template.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/entities/category_template.dart';
import '../view/extended_image_builder.dart';
import 'product_grid_page.dart';
import 'package:extended_image/extended_image.dart';

import '../model/api/api_control.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({
    super.key,
  });

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late Future<List> futureCategory;
  @override
  void initState() {
    super.initState();
    futureCategory = BaseApi().loadList(
      typeItemRequested: "category",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: FutureBuilder<List>(
          future: futureCategory,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return buildGridView(snapshot);
            } else if (snapshot.hasError) {
              return Text('ERROR: ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  GridView buildGridView(AsyncSnapshot<dynamic> snapshot) {
    return GridView.builder(
      itemBuilder: (context, index) {
        var category = snapshot.data?[index];
        return ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          title: Container(
            child: Text(
              category.title,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          subtitle: Container(
            padding: EdgeInsets.only(top: 20),
            width: 100,
            height: 100,
            alignment: Alignment.center,
            child: buildExtendedImage(
                widthImage: 100, heightImage: 100, category: category),
          ),
          onTap: () => ({openPage(context, category)}),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: snapshot.data!.length,
    );
  }

  // ExtendedImage buildExtendedImage(Category category) {
  //   return ExtendedImage.network(
  //     category.imageUrl.toString(),
  //     width: 100,
  //     height: 100,
  //     fit: BoxFit.fill,
  //     cache: false,
  //     loadStateChanged: (ExtendedImageState state) {
  //       switch (state.extendedImageLoadState) {
  //         case LoadState.loading:
  //           return Image.asset(
  //             "assets/images/istockphoto.jpg",
  //             fit: BoxFit.fill,
  //           );
  //           break;

  //         ///if you don't want override completed widget
  //         ///please return null or state.completedWidget
  //         //return null;
  //         //return state.completedWidget;
  //         case LoadState.completed:
  //           return FadeTransition(
  //             opacity: AlwaysStoppedAnimation<double>(1),
  //             child: ExtendedRawImage(
  //               image: state.extendedImageInfo?.image,
  //               width: 100,
  //               height: 100,
  //             ),
  //           );
  //           break;
  //         case LoadState.failed:
  //           return GestureDetector(
  //             child: Stack(
  //               fit: StackFit.expand,
  //               children: <Widget>[
  //                 Image.asset(
  //                   "assets/images/istockphoto.jpg",
  //                   fit: BoxFit.fill,
  //                 ),
  //                 Positioned(
  //                   bottom: 0.0,
  //                   left: 0.0,
  //                   right: 0.0,
  //                   child: Text(
  //                     "load image failed, click to reload",
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 )
  //               ],
  //             ),
  //             onTap: () {
  //               state.reLoadImage();
  //             },
  //           );
  //           break;
  //       }
  //     },
  //   );
  // }

  PreferredSizeWidget buildAppBar() => AppBar(
        title: Text('Категории'),
      );

  void openPage(context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductWidget(
          category: category,
        ),
      ),
    );
  }
}
