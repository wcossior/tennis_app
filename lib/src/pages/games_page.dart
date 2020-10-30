import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  final tournament;
  final typeInfo;

  const GamesPage({Key key, @required this.tournament, @required this.typeInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
      body: _showPlanning(),
    );
  }

  Widget _showPlanning() {
    return Container( padding: EdgeInsets.all(15.0),child: ListView(children: _getPlannigList()));
  }

  List<Widget> _getPlannigList() {
    List getPlanning = new List();

    if (typeInfo == "grupos") {
      getPlanning = tournament["programacion_fase_grupos"];
    } else {
      getPlanning = tournament["programacion_fase_eliminatoria"];
    }

    List<Widget> planning = new List<Widget>();

    for (var item in getPlanning) {
      final info = ListTile(
        title: Text(item["nombre"]),
        subtitle: Column(
          children: [
            SizedBox(height: 15.0),
            Text(item['jugador1'] + "     vs     " + item['jugador2']),
            SizedBox(height: 15.0),
            Text(item["fecha"])
          ],
        ),
      );
      planning..add(info)..add(Divider(color: Color.fromRGBO(11, 164, 93, 1.0),));
    }
    return planning;
  }
}
