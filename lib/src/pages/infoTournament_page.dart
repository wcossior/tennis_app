import 'package:flutter/material.dart';

class InfoTournamentPage extends StatefulWidget {
  final _tournament;
  InfoTournamentPage(this._tournament);

  @override
  _InfoTournamentPageState createState() =>
      _InfoTournamentPageState(_tournament);
}

class _InfoTournamentPageState extends State<InfoTournamentPage> {
  var _tournament;
  _InfoTournamentPageState(this._tournament);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(11, 164, 93, 1.0),
        title: Text("Informacion torneo " + _tournament['nombre'][19]),
      ),
      backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
      body: _showPlanning(),
    );
  }

  Widget _showPlanning() {
    return ListView(children: _getPlannigList());
  }

  List<Widget> _getPlannigList() {
    final getPlanning = _tournament["programacion_fase_grupos"];
    List<Widget> planning = new List<Widget>();

    for (var item in getPlanning) {
      final info = ListTile(
        title: Text(item["nombre"]),
        subtitle: Column(
          children: [
            Text(item['jugador1'] + " vs " + item['jugador2']),
            Text(item["fecha"])
          ],
        ),
      );
      planning..add(info)..add(Divider());
    }
    return planning;
  }
}
