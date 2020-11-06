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
        future: tournamentProvider.getAllTournaments(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.all(10.0),
              children: _getTournaments(snapshot.data, context),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
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
              _drawInformationCard(tournam),
              Divider(),
              _drawButtons(context, tournam),
              SizedBox(height: 8.0)
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
      tournam.nombre,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    )));
  }

  Widget _drawButtons(BuildContext context, tournam) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonTheme(
            minWidth: double.minPositive,
            child: FlatButton(
                child: Text("VER CATEGORÍAS",
                    style: TextStyle(color: Color.fromRGBO(11, 164, 93, 1.0))),
                onPressed: () {
                  Navigator.pushNamed(context, "categories",
                      arguments: tournam);
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
          Icon(Icons.date_range, color: Colors.black26),
          Text("Fecha inicio\n" + tournam.fechaInicio),
          Icon(Icons.date_range, color: Colors.black26),
          Text("Fecha fin\n" + tournam.fechaFin)
        ],
      ),
    );
  }

  Widget _isRobin(tournam, BuildContext context) {
    if (tournam["tipo"] == "Robin") {
      return ButtonTheme(
          minWidth: double.minPositive,
          child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Color.fromRGBO(255, 169, 0, 1.0),
              child: Icon(
                FontAwesomeIcons.layerGroup,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "details_group",
                    arguments: tournam);
              }));
    } else {
      return Container();
    }
  }
}
