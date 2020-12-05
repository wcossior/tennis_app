import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/src/providers/games_group_provider.dart';
import 'package:tennis_app/src/providers/games_playoff_provider.dart';

class GamesPage extends StatefulWidget {
  final idCategory;
  final typeInfo;

  const GamesPage({Key key, @required this.idCategory, @required this.typeInfo})
      : super(key: key);

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  final Widget versusIcon = SvgPicture.asset(
    'assets/iconoVersus.svg',
    semanticsLabel: 'Versusicon',
    height: 60.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
      body: _showPlanning(widget.typeInfo),
    );
  }

  Widget _showPlanning(String typeInfo) {
    return FutureBuilder(
        future: typeInfo == "eliminatoria"
            ? gamesPlayoffProvider.getGamesPlayoffFromACategory(widget.idCategory)
            : gamesGroupProvider.getGamesGroupFromACategory(widget.idCategory),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.all(10.0),
              children: _getPlannigList(snapshot.data, context, typeInfo),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  List<Widget> _getPlannigList(
      List data, BuildContext context, String typeInfo) {
    List<Widget> planning = new List<Widget>();

    for (var item in data) {
      final info = ListTile(
        leading: versusIcon,
        title: typeInfo == "eliminatoria"
            ? Text(item.etapa)
            : Text("Grupo " + item.nombre),
        subtitle: Column(
          children: [
            SizedBox(height: 15.0),
            Text(item.jug1 + "     vs     " + item.jug2),
            SizedBox(height: 15.0),
            Text(item.horaInicio)
          ],
        ),
      );
      planning
        ..add(info)
        ..add(Divider(
          color: Color.fromRGBO(11, 164, 93, 1.0),
        ));
    }
    return planning;
  }
}
