import 'dart:convert';

import 'package:http/http.dart' as http;

class _GamesProvider {
  String _url = "tennisapi.herokuapp.com";

  Future<String> _processResp(Uri url) async {
    final resp = await http.put(url);
    final decodeData = json.decode(resp.body);
    return decodeData;
  }

  Future<String> updateScoreFromAgame(
      String idPartido, int scoreJug1, int scoreJug2) async {
    final url = Uri.https(_url, "/partidos/$idPartido/$scoreJug1/$scoreJug2");

    return await _processResp(url);
  }
}

final gamesProvider = new _GamesProvider();
