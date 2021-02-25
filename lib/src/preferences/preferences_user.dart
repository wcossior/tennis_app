import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/src/blocs/provider.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get token {
    var token = _prefs.getString('token') ?? '';

    // String hola = """{"nombre": "Juan", "apellido": "Perez"}""";
    // print(hola);

    var resp = jsonDecode("""$token""");
    // print("en prefs");
    return resp;
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  logout(BuildContext context) {
    _prefs.remove("token");
    final bloc = Provider.loginOf(context);
    bloc.changeUser("");
    bloc.changePassword("");
  }

  isLogged() {
    return _prefs.containsKey("token");
  }

}
