import 'package:flutter/material.dart';
import 'package:flutter_application_2/CategoryList.dart';
import 'package:extended_image/extended_image.dart';

import 'ProductList.dart';

class ProductWidget extends StatefulWidget {
  final Category category;
  const ProductWidget({Key? key, required this.category});

  @override
  State<ProductWidget> createState() => _ProductWidgetState(this.category);
}

class _ProductWidgetState extends State<ProductWidget> {
  Category category;
  late Future<List<Product>> futureProducts;
  _ProductWidgetState(this.category);
  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().getProduct(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(category.title)),
        body: Center(
          child: FutureBuilder<List<Product>>(
            future: futureProducts,
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      Product product = snapshot.data?[index];
                      return Card(
                        child: ExpansionTile(
                          title: Text(product.title),
                          children: <Widget>[
                            ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                child: ExtendedImage.network(
                                  product.imageUrl.toString(),
                                  width: 50,
                                  height: 50,
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
                                          opacity:
                                              AlwaysStoppedAnimation<double>(1),
                                          child: ExtendedRawImage(
                                            image:
                                                state.extendedImageInfo?.image,
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
                                ),
                              ),
                              title: Text("Цена: " + product.price.toString()),
                            ),
                            ListTile(
                              dense: true,
                              visualDensity: VisualDensity(vertical: -3),
                              title: Text(
                                  product.productDescription.toString() !=
                                          "null"
                                      ? product.productDescription.toString()
                                      : ''),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: ((context, index) {
                      return const Divider(color: Colors.black26);
                    }),
                    itemCount: snapshot.data!.length);
              } else if (snapshot.hasError) {
                return Text('ERROR: ${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }),
          ),
        ));
  }
}
