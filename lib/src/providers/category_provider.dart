import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tennis_app/src/models/category_model.dart';

class _CategoryProvider {
  List<dynamic> categories = [];
  String _url = "tennisapi.herokuapp.com";

  Future<List<Category>> _processResp(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final categories = new Categories.fromJsonList(decodeData);

    return categories.items;
  }

  Future<List<dynamic>> getCategoriesfromThisTournament(String id) async {
    final url = Uri.https(_url, "/categorias/$id");

    return await _processResp(url);
  }
}

final categoryProvider = new _CategoryProvider();
