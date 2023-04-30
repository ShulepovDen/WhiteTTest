import 'package:flutter/material.dart';
import 'package:flutter_application_2/ProductList.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'CategoryList.dart';
import 'ProductGridView.dart';
import 'package:extended_image/extended_image.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late Future<List<Category>> futureCategorys;
  @override
  void initState() {
    super.initState();
    futureCategorys = CategoryService().getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Категории')),
        body: Center(
          child: FutureBuilder<List<Category>>(
            future: futureCategorys,
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemBuilder: (context, index) {
                    Category category = snapshot.data?[index];
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
                        child: ExtendedImage.network(
                          category.imageUrl.toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                          cache: false,
                          loadStateChanged: (ExtendedImageState state) {
                            switch (state.extendedImageLoadState) {
                              case LoadState.loading:
                                return Image.asset(
                                  "assets/images/istockphoto.jpg",
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
                                    width: 100,
                                    height: 100,
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
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Text(
                                          "load image failed, click to reload",
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
                      onTap: () => ({openPage(context, category)}),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data!.length,
                );
              } else if (snapshot.hasError) {
                return Text('ERROR: ${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }),
          ),
        ));
  }

  openPage(context, Category category) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductWidget(
                  category: category,
                )));
  }
}

// class SimpleWidget extends StatelessWidget {
//   SimpleWidget({Key? key}) : super(key: key) {
//     // loadCategory();
//   }
//   final items = List.generate(50, (index) => index);
//   // loadCategory() async {
//   //   final results = await CategoryService().getCategory();
//   //   print(results.length);
//   //   results.forEach((element) {
//   //     print(element.title);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Category')),
//       body: ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             final item = items[index];
//             return ListTile(
//               title: Text('Item $item'),
//               subtitle: const Text('my subtitle'),
//               onTap: () => {},
//               trailing: const Icon(Icons.chevron_right_outlined),
//             );
//           }),
//     );
//   }
// }
