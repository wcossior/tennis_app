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

class _GamesPageState extends State<GamesPage>
    with AutomaticKeepAliveClientMixin<GamesPage> {
  final Widget versusIcon = SvgPicture.asset(
    'assets/iconoVersus.svg',
    semanticsLabel: 'Versusicon',
    height: 60.0,
  );

  @override
  bool get wantKeepAlive => true;

  List<dynamic> dataGames = new List<dynamic>();
  List<dynamic> dataGamesForDisplay = new List<dynamic>();

  @override
  void initState() {
    fetchGames().then((data) {
      setState(() {
        dataGames.addAll(data);
        dataGamesForDisplay = dataGames;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
      body: _showPlanning(context),
    );
  }

  Future<List<dynamic>> fetchGames() async {
    var resp;
    if (widget.typeInfo == "eliminatoria") {
      resp = await gamesPlayoffProvider
          .getGamesPlayoffFromACategory(widget.idCategory);
    } else {
      resp = await gamesGroupProvider
          .getGamesGroupFromACategory(widget.idCategory);
    }

    return resp;
  }

  searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Ingrese el nombre del jugador'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            dataGamesForDisplay = dataGames.where((game) {
              var gamePlayer1 = game.jug1.toLowerCase();
              var gamePlayer2 = game.jug2.toLowerCase();

              return gamePlayer1.contains(text) || gamePlayer2.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  // Widget _showPlanning(String typeInfo) {
  //   return FutureBuilder(
  //       future: typeInfo == "eliminatoria"
  //           ? gamesPlayoffProvider
  //               .getGamesPlayoffFromACategory(widget.idCategory)
  //           : gamesGroupProvider.getGamesGroupFromACategory(widget.idCategory),
  //       builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
  //         if (snapshot.hasData) {
  //           return ListView(
  //             padding: EdgeInsets.all(10.0),
  //             children: _getPlannigList(snapshot.data, context, typeInfo),
  //           );
  //         } else {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //       });
  // }

  Widget _showPlanning(BuildContext context) {
    if (dataGames.isEmpty) return Center(child: CircularProgressIndicator());

    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index) {
          return index == 0 ? searchBar() : listItem(index - 1);
        },
        itemCount: dataGamesForDisplay.length + 1);
  }

  listItem(index) {
    return ListTile(
      leading: versusIcon,
      title: widget.typeInfo == "eliminatoria"
          ? Text(dataGamesForDisplay[index].etapa)
          : Text("Grupo " + dataGamesForDisplay[index].nombre),
      subtitle: Column(
        children: [
          SizedBox(height: 15.0),
          Text(dataGamesForDisplay[index].jug1 +
              "     vs     " +
              dataGamesForDisplay[index].jug2),
          SizedBox(height: 15.0),
          Text(dataGamesForDisplay[index].horaInicio)
        ],
      ),
    );
  }
}
