import '../entities/category.dart';
import '../entities/product.dart';
import 'base_api.dart';

class ProductApi extends BaseApi {
  Future<List<Product>> loadProducts({
    Category? parentCategory,
    int? offset,
  }) async {
    var params = await prepareParams(
      params: {
        "offset": offset?.toString() ?? "",
        "categoryId": parentCategory?.categoryId.toString() ?? "",
      },
    );
    var uri = await createAbsoluteUrl(
      pathTo: "/api/common/product/list",
      params: params,
    );
    var jsonResponse = await sendGetRequest(
      relativeUrl: uri,
    );
    final List<Product> list = [];
    var dataJson = jsonResponse['data'];
    if (dataJson != null) {
      for (var categoryJson in dataJson) {
        var categoryItem = Product.fromJson(categoryJson);
        list.add(categoryItem);
      }
    }
    return list;
  }
}
