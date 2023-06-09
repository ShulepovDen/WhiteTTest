import '../entities/category.dart';
import 'base_api.dart';

class CategoryApi extends BaseApi {
  Future<List<Category>> loadCategories({
    Category? parentCategory,
    int? offset,
  }) async {
    var params = await prepareParams(
      params: {
        "offset": offset?.toString() ?? "",
      },
    );
    var uri = await createAbsoluteUrl(
      pathTo: "/api/common/category/list",
      params: params,
    );
    var jsonResponse = await sendGetRequest(
      relativeUrl: uri,
    );
    final List<Category> list = [];
    var dataJson = jsonResponse['data'];
    var categoriesJson = dataJson['categories'];
    if (categoriesJson != null) {
      for (var categoryJson in categoriesJson) {
        var categoryItem = Category.fromJson(categoryJson);
        list.add(categoryItem);
      }
    }
    return list;
  }
}
