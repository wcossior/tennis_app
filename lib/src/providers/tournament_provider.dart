import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tennis_app/src/models/tournament_model.dart';

class _TournamentProvider {
  List<dynamic> tournaments = [];
  String _url = "tennisapi.herokuapp.com";

  Future<List<Tournament>> _processResp(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final tournaments = new Tournaments.fromJsonList(decodeData);

    return tournaments.items;
  }

  Future<List<dynamic>> getAllTournaments() async {

    final url = Uri.https(_url, "/torneos");

    return await _processResp(url);
  }
}

final tournamentProvider = new _TournamentProvider();
