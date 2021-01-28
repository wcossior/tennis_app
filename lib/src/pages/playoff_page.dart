import 'package:flutter/material.dart';
import 'package:tennis_app/src/providers/games_playoff_provider.dart';

class PlayoffPage extends StatefulWidget {
  final idCategory;

  const PlayoffPage({Key key, this.idCategory}) : super(key: key);

  @override
  _PlayoffPageState createState() => _PlayoffPageState();
}

class _PlayoffPageState extends State<PlayoffPage>
    with AutomaticKeepAliveClientMixin<PlayoffPage> {
  List<dynamic> dataGames = [];
  List<dynamic> dataGamesForDisplay = [];
  String dropdownValue = "Todo";
  Map<int, String> filterOptions = {1: "Todo"};

  var hasData = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    fetchGames().then((data) {
      setState(() {
        dataGames = data;
        dataGamesForDisplay = dataGames;
        getEtapas();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (hasData && dataGames.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    if (dataGames.length == 0) {
      return Center(child: Text("No hay partidos por ahora"));
    }
    return Scaffold(
        backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
        body: _showPlanning(context));
  }

  void getEtapas() {
    var index = 2;

    for (var i = 0; i < dataGames.length; i++) {
      if (!filterOptions.containsValue(dataGames[i].etapa)) {
        filterOptions[index] = dataGames[i].etapa;
        index++;
      }
    }
  }

  Future<List<dynamic>> fetchGames() async {
    var resp;
    resp = await gamesPlayoffProvider
        .getGamesPlayoffFromACategory(widget.idCategory);
    if (resp.isEmpty) {
      setState(() {
        hasData = false;
      });
    }
    return resp;
  }

  void filter(String text) {
    setState(() {
      dropdownValue = text;
      if (text == "Todo") {
        dataGamesForDisplay = dataGames;
      } else {
        dataGamesForDisplay = dataGames.where((game) {
          var etapaGame = game.etapa;

          return etapaGame.contains(text);
        }).toList();
      }
    });
  }

  Widget filterDropDown() {
    return Center(
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down,
            color: Color.fromRGBO(174, 185, 127, 1.0)),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1.0)),
        underline: Container(
          height: 2,
          color: Color.fromRGBO(174, 185, 127, 1.0),
        ),
        onChanged: (String text) => filter(text),
        items:
            filterOptions.values.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _showPlanning(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index) {
          return index == 0 ? filterDropDown() : listItem(index - 1);
        },
        itemCount: dataGamesForDisplay.length + 1);
  }

  Widget listItem(index) {
    String namePlayer1 = dataGamesForDisplay[index].jug1;
    String scorePlayer1 = dataGamesForDisplay[index].scoreJugador1.toString();

    String namePlayer2 = dataGamesForDisplay[index].jug2;
    String scorePlayer2 = dataGamesForDisplay[index].scoreJugador2.toString();

    return Column(
      children: [
        ListTile(
          title: Text(dataGamesForDisplay[index].etapa),
          subtitle: Column(
            children: [
              SizedBox(height: 15.0),
              drawLabelResults(),
              drawPlayer(namePlayer1, scorePlayer1),
              SizedBox(height: 8.0),
              drawPlayer(namePlayer2, scorePlayer2),
            ],
          ),
        ),
        Divider(thickness: 1.0, color: Color.fromRGBO(174, 185, 127, 1.0))
      ],
    );
  }

  Widget drawPlayer(String name, String score) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1.0)),
                text: name),
          ),
        ),
        Text(score),
      ],
    );
  }

  Container drawLabelResults() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Resultado Sets:"),
        ],
      ),
    );
  }
}
