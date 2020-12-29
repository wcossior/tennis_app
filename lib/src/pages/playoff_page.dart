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

  var hayData = true;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    fetchGames().then((data) {
      if(mounted)
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

    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
      body: _showPlanning(context),
    );
  }

  getEtapas() {
    var etapa = "";
    var index = 2;

    for (var i = 0; i < dataGames.length; i++) {
      if (dataGames[i].etapa != etapa) {
        etapa = dataGames[i].etapa;
        filterOptions[index] = dataGames[i].etapa;
        index++;
      }
    }
  }

  Future<List<dynamic>> fetchGames() async {
    var resp;
    resp = await gamesPlayoffProvider
        .getGamesPlayoffFromACategory(widget.idCategory);

    return resp;
  }

  filterDropDown() {
    return Center(
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String text) {
          if(mounted)
          setState(() {
            dropdownValue = text;
          });
          if(mounted)
          setState(() {
            if (text == "Todo") {
              dataGamesForDisplay = dataGames;
            } else {
              dataGamesForDisplay = dataGames.where((game) {
                var etapaGame = game.etapa;

                return etapaGame.contains(text);
              }).toList();
            }
          });
        },
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
    Future.delayed(Duration(seconds: 6), () {
      if (dataGames.isEmpty)
        if(mounted)
        setState(() {
          hayData = false;
        });
    });

    if (dataGames.isEmpty && hayData == true)
      return Center(child: CircularProgressIndicator());

    if (hayData == false)
      return Center(child: Text("No hay partidos por ahora"));

    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index) {
          return index == 0 ? filterDropDown() : listItem(index - 1);
        },
        itemCount: dataGamesForDisplay.length + 1);
  }

  listItem(index) {
    return Column(
      children: [
        ListTile(
          title: Text(dataGamesForDisplay[index].etapa),
          subtitle: Column(
            children: [
              SizedBox(height: 15.0),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Resultado Sets:"),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 1.0)),
                              text: dataGamesForDisplay[index].jug1))),
                  Text(dataGamesForDisplay[index].scoreJugador1.toString()),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 1.0)),
                              text: dataGamesForDisplay[index].jug2))),
                  Text(dataGamesForDisplay[index].scoreJugador2.toString()),
                ],
              ),
            ],
          ),
        ),
        Divider(thickness: 1.0, color: Color.fromRGBO(174, 185, 127, 1.0))
      ],
    );
  }
}
