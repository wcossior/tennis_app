import 'package:flutter/material.dart';
import 'package:tennis_app/src/models/tournament_model.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'package:tennis_app/src/providers/tournament_provider.dart';

import '../categories_page.dart';
import '../scheduling_page.dart';

class TournamentsPage extends StatefulWidget {
  @override
  _TournamentsPageState createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage>
    with AutomaticKeepAliveClientMixin<TournamentsPage> {
  @override
  bool get wantKeepAlive => true;

  List<Tournament> dataTournaments = new List<Tournament>();
  var hayTorneos = true;

  @override
  void initState() {
    fetchTournaments().then((data) {
      setState(() {
        dataTournaments.addAll(data);
      });
    });
    super.initState();
  }

  Future<List<Tournament>> fetchTournaments() async {
    var resp = await tournamentProvider.getAllTournaments();
    if (resp.isEmpty) {
      setState(() {
        hayTorneos = false;
      });
    }

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (hayTorneos && dataTournaments.isEmpty)
      return Center(child: CircularProgressIndicator());

    return Container(
      color: Color.fromRGBO(249, 249, 249, 1.0),
      child: hayTorneos == true
          ? _tournamentList()
          : Center(child: Text("No hay torneos por ahora")),
    );
  }

  Widget _tournamentList() {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: _getTournaments(),
    );
  }

  List<Widget> _getTournaments() {
    final List<Widget> tournaments = [];
    final tournamentsList = dataTournaments;

    tournamentsList.forEach((tournam) {
      final widgetTemp = Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            _drawTitle(context, tournam),
            _drawInformationCard(tournam),
            Divider(),
            _drawButtons(context, tournam),
            SizedBox(height: 8.0)
          ],
        ),
      );
      tournaments.add(widgetTemp);
    });
    return tournaments;
  }

  Widget _drawTitle(BuildContext context, Tournament tournam) {
    return ListTile(
      title: Center(
        child: Text(
          tournam.nombre,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Color.fromRGBO(112, 112, 112, 1.0),
          ),
        ),
      ),
    );
  }

  Widget _drawButtons(BuildContext context, Tournament tournam) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        drawButtonVerCategorias(tournam),
        drawButtonVerProgramcion(tournam),
      ],
    );
  }

  Widget drawButtonVerCategorias(Tournament tournam) {
    return ButtonTheme(
      minWidth: double.minPositive,
      child: FlatButton(
        child: Text("VER CATEGORÍAS",
            style: TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0))),
        onPressed: () {
          // Navigator.pushNamed(context, "categories",arguments: tournam);
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => CategoriesPage(tournament: tournam)),
          );
        },
      ),
    );
  }

  Widget drawButtonVerProgramcion(Tournament tournam) {
    return ButtonTheme(
      minWidth: double.minPositive,
      child: FlatButton(
        child: Text("VER PROGRAMACIÓN",
            style: TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0))),
        onPressed: () {
          // Navigator.pushNamed(context, "categories",arguments: tournam);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SchedulingPage(tournament: tournam),
            ),
          );
        },
      ),
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
