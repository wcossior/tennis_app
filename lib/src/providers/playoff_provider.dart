import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tennis_app/src/models/playoff_model.dart';

class _PlayoffProvider {
  List<dynamic> playoffs = [];
  String _url = "tennisapi.herokuapp.com";

  Future<List<Playoff>> _processResp(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final playoffs = new Playoffs.fromJsonList(decodeData);

    return playoffs.items;
  }

  Future<List<dynamic>> getPlayoffsFromACategory(String id) async {

    final url = Uri.https(_url, "/cuadros/$id");

    return await _processResp(url);
  }
}

final playoffProvider = new _PlayoffProvider();