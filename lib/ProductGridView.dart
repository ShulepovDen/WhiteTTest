import 'package:flutter/material.dart';
import 'package:flutter_application_2/CategoryList.dart';

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
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      'assets/images/istockphoto.jpg')),
                              // Image.network(product.imageUrl,
                              //     fit: BoxFit.cover,
                              //     errorBuilder: (context, error, stackTrace) {
                              //   return Image.asset(
                              //       'assets/images/istockphoto.jpg',
                              //       fit: BoxFit.fitWidth);
                              // })
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

// class SimpleWidget extends StatelessWidget {
//   SimpleWidget({Key? key}) : super(key: key) {
//     // loadProduct();
//   }
//   final items = List.generate(50, (index) => index);
//   // loadProduct() async {
//   //   final results = await ProductService().getProduct();
//   //   print(results.length);
//   //   results.forEach((element) {
//   //     print(element.title);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Product')),
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
