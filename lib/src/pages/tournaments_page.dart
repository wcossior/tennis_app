import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tennis_app/src/providers/tournament_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TournamentsPage extends StatelessWidget {
  final Widget playOffIcon =
      SvgPicture.asset('assets/playofficon.svg', semanticsLabel: 'Play Off');

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(249, 249, 249, 1.0), child: _tournamentList());
  }

  Widget _tournamentList() {
    return FutureBuilder(
        future: tournamentProvider.uploadData(),
        initialData: [], //opcional
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(
            padding: EdgeInsets.all(10.0),
            children: _getTournaments(snapshot.data, context),
          );
        });
  }

  List<Widget> _getTournaments(List data, BuildContext context) {
    final List<Widget> tournaments = [];

    data.forEach((tournam) {
      final widgetTemp = Card(
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            children: [
              _drawTitle(context, tournam),
              _drawButtons(context, tournam),
              Divider(),
              _drawInformationCard(tournam)
            ],
          ));
      tournaments.add(widgetTemp);
    });
    return tournaments;
  }

  Widget _drawTitle(BuildContext context, tournam) {
    return ListTile(
        title: Center(
            child: Text(
      tournam["nombre"],
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    )));
  }

  Widget _drawButtons(BuildContext context, tournam) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _isRobin(tournam, context),
        SizedBox(width: 12.0),
        ButtonTheme(
            minWidth: double.minPositive,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Color.fromRGBO(255, 169, 0, 1.0),
                child: playOffIcon,
                onPressed: () {
                  Navigator.pushNamed(context, "details_playoff", arguments: tournam);                  
                }))
      ],
    );
  }

  Widget _drawInformationCard(tournam) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.grid_view, color: Colors.black26),
          Text("Categoria \n Absoluto"),
          Icon(Icons.date_range, color: Colors.black26),
          Text("Fecha inicio\n" + tournam["fecha_ini"]),
          Icon(Icons.date_range, color: Colors.black26),
          Text("Fecha fin\n" + tournam["fecha_fin"])
        ],
      ),
    );
  }

  Widget _isRobin(tournam, BuildContext context) {
    if (tournam["tipo"] == "Robin") {
      return ButtonTheme(
          minWidth: double.minPositive,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Color.fromRGBO(255, 169, 0, 1.0),
              child: Icon(
                FontAwesomeIcons.layerGroup,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "details_group", arguments: tournam);
              }));
    } else {
      return Container();
    }
  }
}
