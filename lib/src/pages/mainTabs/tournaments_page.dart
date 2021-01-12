import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tennis_app/src/providers/tournament_provider.dart';

import '../categories_page.dart';
import '../scheduling_page.dart';

class TournamentsPage extends StatefulWidget {
  @override
  _TournamentsPageState createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage>
    with AutomaticKeepAliveClientMixin<TournamentsPage> {
  final Widget playOffIcon =
      SvgPicture.asset('assets/playofficon.svg', semanticsLabel: 'Play Off');

  final Widget tennisIcon = SvgPicture.asset(
    'assets/tennis.svg',
    semanticsLabel: 'Tennisicon',
    height: 20.0,
  );
  @override
  bool get wantKeepAlive => true;

  List<dynamic> dataTournaments = new List<dynamic>();
  var hayInfo = true;

  @override
  void initState() {
    fetchTournaments().then((data) {
      setState(() {
        dataTournaments.addAll(data);
      });
    });
    super.initState();
  }

  Future<List<dynamic>> fetchTournaments() async {
    var resp = await tournamentProvider.getAllTournaments();
    if (resp.isEmpty) {
      setState(() {
        hayInfo = false;
      });
    }

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (hayInfo && dataTournaments.isEmpty)
      return Center(child: CircularProgressIndicator());
    return Container(
      color: Color.fromRGBO(249, 249, 249, 1.0),
      child: hayInfo == true
          ? _tournamentList()
          : Center(child: Text("No hay torneos por ahora")),
    );
  }

  Widget _tournamentList() {
    if (dataTournaments.isEmpty)
      return Center(child: CircularProgressIndicator());

    return ListView(
      padding: EdgeInsets.all(10.0),
      children: _getTournaments(context),
    );
  }

  List<Widget> _getTournaments(BuildContext context) {
    final List<Widget> tournaments = [];
    final tournamentsList = dataTournaments;

    tournamentsList.forEach((tournam) {
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
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Color.fromRGBO(112, 112, 112, 1.0)),
        ),
      ),
    );
  }

  Widget _drawButtons(BuildContext context, tournam) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonTheme(
            minWidth: double.minPositive,
            child: FlatButton(
                child: Text("VER CATEGORÍAS",
                    style:
                        TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0))),
                onPressed: () {
                  // Navigator.pushNamed(context, "categories",arguments: tournam);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CategoriesPage(tournament: tournam)));
                })),
        ButtonTheme(
            minWidth: double.minPositive,
            child: FlatButton(
              child: Text("VER PROGRAMACIÓN",
                    style:
                        TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0))),
                onPressed: () {
                  // Navigator.pushNamed(context, "categories",arguments: tournam);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SchedulingPage(tournament: tournam)));
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
}
