import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/src/models/tournament_model.dart';
import 'package:tennis_app/src/providers/category_provider.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final Widget tournamenticon = SvgPicture.asset(
    'assets/tournament.svg',
    semanticsLabel: 'Tournament',
    color: Color.fromRGBO(11, 164, 93, 1.0),
    width: 40.0,
  );

  List<dynamic> tournaments = [];

  void uploadData() async {
    final resp = await rootBundle.loadString("data/torneos.json");

    Map dataMap = json.decode(resp);
    tournaments = dataMap["torneos"];
  }

  @override
  Widget build(BuildContext context) {
    final Tournament tournament = ModalRoute.of(context).settings.arguments;
    uploadData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorías"),
        backgroundColor: Color.fromRGBO(11, 164, 93, 1.0),
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
      body: _showCategories(tournament),
    );
  }

  Widget _showCategories(tournament) {
    return FutureBuilder(
        future: categoryProvider.getCategoriesfromThisTournament(tournament.id),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.all(10.0),
              children: _readCategories(snapshot.data, context),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
    
  }

  List<Widget> _showInformation(category) {
    if (category.tipo == "cuadroAvance") {
      return [
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Text("Tipo: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.tipo),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          children: [
            Text("Número de jugadores: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.numeroJugadores.toString()),
          ],
        ),
      ];
    } else {
      return [
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Text("Tipo: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.tipo),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          children: [
            Text("Número de jugadores: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.numeroJugadores.toString()),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          children: [
            Text("Número de grupos: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.numeroGrupos.toString()),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          children: [
            Text("Número de jugadores por grupo: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.numeroJugadoresGrupo.toString()),
          ],
        ),
      ];
    }
  }

  List<Widget> _readCategories(List data, BuildContext context) {
    final categories = data;
    List<Widget> readedCategories = new List<Widget>();

    for (var item in categories) {
      final info = Container(
        padding: EdgeInsets.all(10.0),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          contentPadding: EdgeInsets.all(10.0),
          leading: tournamenticon,
          title: Text(item.nombre, style: TextStyle(fontSize: 20.0)),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Color.fromRGBO(11, 164, 93, 1.0)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _showInformation(item),
          ),
          onTap: () {
            if (item.tipo == "cuadroAvance") {
              Navigator.pushNamed(context, "details_playoff", arguments: tournaments[1]);
            } else {
              Navigator.pushNamed(context, "details_group", arguments: tournaments[0]);
            }
          },
        ),
      );
      readedCategories
        ..add(info)
        ..add(Divider(
          thickness: 1.0,
        ));
    }
    return readedCategories;
  }
}
