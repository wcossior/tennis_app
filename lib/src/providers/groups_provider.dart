import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tennis_app/src/models/group_model.dart';

class _GroupProvider {
  List<dynamic> groups = [];
  String _url = "tennisapi.herokuapp.com";

  Future<List<Group>> _processResp(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final groups = new Groups.fromJsonList(decodeData);

    return groups.items;
  }

  Future<List<dynamic>> getGroupsFromACategory(String id) async {

    final url = Uri.https(_url, "/grupos/$id");

    return await _processResp(url);
  }
}

final groupProvider = new _GroupProvider();