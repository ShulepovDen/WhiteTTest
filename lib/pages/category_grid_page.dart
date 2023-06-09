import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/api/category_api.dart';
import '../model/entities/category.dart';
import '../view/category_grid_item.dart';
import '../view/extended_image_widget.dart';
import 'category_page_model_view.dart';
import 'product_grid_page.dart';

class CategoryGridPage extends StatefulWidget {
  const CategoryGridPage({
    super.key,
  });

  @override
  State<CategoryGridPage> createState() => _CategoryGridPageState();
}

class _CategoryGridPageState extends State<CategoryGridPage> {
  late CategoryPageModelView categoryListModelView;

  bool isLoading = false;

  @override
  void initState() {
    categoryListModelView = CategoryPageModelView();
    super.initState();
    categoryListModelView.loadNextItems();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: categoryListModelView,
      child: Consumer<CategoryPageModelView>(
        builder: (context, value, child) {
          return mainScaffold();
        },
      ),
    );
  }

  Scaffold mainScaffold() {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: (categoryListModelView.shouldShowListLoader)
            ? const CircularProgressIndicator()
            : mainGrid(),
      ),
    );
  }

  GridView mainGrid() {
    return GridView.builder(
      itemBuilder: (context, index) {
        var category = categoryListModelView.categories[index];
        return CategoryGridItem(
          category: category,
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: categoryListModelView.categories.length,
    );
  }

  PreferredSizeWidget buildAppBar() => AppBar(
        title: Text('Категории'),
      );
}
