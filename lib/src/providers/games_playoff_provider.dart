import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tennis_app/src/models/games_playoff_model.dart';

class _GamesPlayoffProvider {
  List<dynamic> gamesPlayoff = [];
  String _url = "tennisapi.herokuapp.com";

  Future<List<GamePlayoff>> _processResp(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final gamesPlayoff = new GamesPlayoff.fromJsonList(decodeData);

    return gamesPlayoff.items;
  }

  Future<List<dynamic>> getGamesPlayoffFromACategory(String id) async {

    final url = Uri.https(_url, "/partidoscuadro/$id");

    return await _processResp(url);
  }
}

final gamesPlayoffProvider = new _GamesPlayoffProvider();