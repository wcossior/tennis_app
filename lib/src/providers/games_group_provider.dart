import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tennis_app/src/models/games_group_model.dart';

class _GamesGroupProvider {
  List<dynamic> gamesGroup = [];
  String _url = "tennisapi.herokuapp.com";

  Future<List<GameGroup>> _processResp(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final gamesGroup = new GamesGroup.fromJsonList(decodeData);

    return gamesGroup.items;
  }

  Future<List<dynamic>> getGamesGroupFromACategory(String id) async {

    final url = Uri.https(_url, "/partidosgrupo/$id");

    return await _processResp(url);
  }
}

final gamesGroupProvider = new _GamesGroupProvider();