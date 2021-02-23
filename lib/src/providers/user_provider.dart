import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tennis_app/src/preferences/preferences_user.dart';

class _UserProvider {
  String _url = "tennisapi.herokuapp.com";
  final _prefs = new PreferenciasUsuario();

  Future login(String user, String password) async {
    final authData = {"user": user, "password": password};
    final url = Uri.https(_url, "/login");

    final resp = await http.post(url, body: authData);

    Map decodeData = json.decode(resp.body);
    if (!decodeData.containsKey("msg")) {
      _prefs.token = resp.body;
    }

    return decodeData;
  }
}

final userProvider = new _UserProvider();
