import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class _TournamentProvider {
  List<dynamic> tournaments = [];

  _TournamentProvider() {
    uploadData();
  }

  Future<List<dynamic>> uploadData() async {
    final resp = await rootBundle.loadString("data/torneos.json");

    Map dataMap = json.decode(resp);
    tournaments = dataMap["torneos"];

    return tournaments;
  }
}

final tournamentProvider = new _TournamentProvider();
