import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

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

  delete() {
    _prefs.remove("token");
  }

  isLogged(){
    return _prefs.containsKey("token");
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}
