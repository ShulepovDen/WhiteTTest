import 'package:flutter/material.dart';
import '../model/entities/category.dart';
import '../view/extended_image_widget.dart';
import 'product_grid_page.dart';

import '../model/api/base_api.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({
    super.key,
  });

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final CategoryApi categoryApi = CategoryApi();
  final List<Category> categories = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadNextItems();
  }

  Future<void> reloadData() async {
    categories.clear();
    loadNextItems();
  }

  Future<void> loadNextItems() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    List<Category> newCategories = await categoryApi.loadCategories();
    categories.addAll(newCategories);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: (isLoading && categories.isEmpty)
            ? const CircularProgressIndicator()
            : buildGridView(),
      ),
    );
    ;
  }

  GridView buildGridView() {
    return GridView.builder(
      itemBuilder: (context, index) {
        var category = categories[index];
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
            child: ExtendedImageWidget(
                widthImage: 100, heightImage: 100, category: category),
          ),
          onTap: () => ({openPage(context, category)}),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: categories.length,
    );
  }

  PreferredSizeWidget buildAppBar() => AppBar(
        title: Text('Категории'),
      );

  void openPage(context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductListPage(
          category: category,
        ),
      ),
    );
  }
}
