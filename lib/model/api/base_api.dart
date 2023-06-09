import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entities/category.dart';
import '../entities/product.dart';

class BaseApi {
  final urlTigerSoft = "ostest.whitetigersoft.ru";

  Future<Map<String, dynamic>> sendGetRequest({
    required Uri relativeUrl,
  }) async {
    final response = await http.get(relativeUrl);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('HTTP failed');
    }
  }

  Future<Uri> createAbsoluteUrl({
    String? pathTo,
    Map<String, String>? params,
  }) async {
    var url = Uri.http(urlTigerSoft, pathTo ?? "", params ?? {});
    return url;
  }

  Future<Map<String, String>> prepareParams({
    Map<String, String>? params,
  }) async {
    Map<String, String> returnParams = {};
    returnParams.addEntries(params!.entries);
    returnParams.addAll({
      "appKey":
          "phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF"
    });
    return returnParams;
  }
}
