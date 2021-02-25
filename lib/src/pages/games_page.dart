import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/src/preferences/preferences_user.dart';
import 'package:tennis_app/src/providers/games_group_provider.dart';
import 'package:tennis_app/src/providers/games_playoff_provider.dart';
import 'package:tennis_app/src/providers/games_provider.dart';

import 'details_game.dart';

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
  final _formKey = GlobalKey<FormState>();
  final prefs = new PreferenciasUsuario();


  @override
  bool get wantKeepAlive => true;
  List<dynamic> dataGames = new List<dynamic>();
  List<dynamic> dataGamesForDisplay = new List<dynamic>();
  var hayInfo = true;

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

    if (hayInfo && dataGames.isEmpty)
      return Container(
          child: Center(child: CircularProgressIndicator()),
          color: Color.fromRGBO(249, 249, 249, 1.0));

    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
      body: hayInfo == true
          ? _showPlanning(context)
          : Center(child: Text("No hay partidos por ahora")),
    );
  }

  Future<List<dynamic>> fetchGames() async {
    var resp;

    if (widget.typeInfo == "eliminatoria") {
      resp = await gamesPlayoffProvider
          .getGamesPlayoffFromACategory(widget.idCategory);
      if (resp.isEmpty) {
        setState(() {
          hayInfo = false;
        });
      }
    } else {
      resp = await gamesGroupProvider
          .getGamesGroupFromACategory(widget.idCategory);
      if (resp.isEmpty) {
        setState(() {
          hayInfo = false;
        });
      }
    }

    return resp;
  }

  searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLength: 20,
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

  Widget _showPlanning(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index) {
          return index == 0 ? searchBar() : listItem(index - 1);
        },
        itemCount: dataGamesForDisplay.length + 1);
  }

  listItem(index) {
    return Column(
      children: [
        ListTile(
          leading: versusIcon,
          title: widget.typeInfo == "eliminatoria"
              ? Text(dataGamesForDisplay[index].etapa)
              : Text("Grupo " + dataGamesForDisplay[index].nombre),
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
                          text: dataGamesForDisplay[index].jug1),
                    ),
                  ),
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
                          text: dataGamesForDisplay[index].jug2),
                    ),
                  ),
                  Text(dataGamesForDisplay[index].scoreJugador2.toString()),
                ],
              ),
            ],
          ),
        ),
        ButtonBar(children: [
          prefs.token["role"]=="Arbitro"?
          FlatButton(
            child: const Text('Cambiar Score',
                style: TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0))),
            onPressed: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  child: await showModalForChangeScore(index));
            },
          ):Container(),
          FlatButton(
            child: const Text('Ver detalles',
                style: TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0))),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsGamePage(
                      game: dataGamesForDisplay[index],
                      typeGame: widget.typeInfo)));
            },
          ),
        ]),
        Divider(thickness: 1.0, color: Color.fromRGBO(174, 185, 127, 1.0))
      ],
    );
  }

  Future<AlertDialog> showModalForChangeScore(index) async {
    return AlertDialog(
      title: Text("Editar Score"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            processScoreJug1(index),
            processScoreJug2(index),
          ],
        ),
      ),
      actions: [
        FlatButton(
            child: const Text("Cancelar"),
            onPressed: () {
              Navigator.pop(context);
            }),
        FlatButton(
            child: const Text("Ok"),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                try {
                  Navigator.pop(context);
                  var resp = await gamesProvider.updateScoreFromAgame(
                      dataGamesForDisplay[index].id,
                      dataGamesForDisplay[index].scoreJugador1,
                      dataGamesForDisplay[index].scoreJugador2);
                  if (resp == "score actualizado") {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Color.fromRGBO(174, 185, 127, 1.0),
                        content: Text('Score actualizado')));
                  }
                } catch (e) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Color.fromRGBO(246, 108, 94, 1.0),
                      content: Text('Hubo un error')));
                }
              }
            }),
      ],
    );
  }

  TextFormField processScoreJug2(index) {
    return TextFormField(
      maxLength: 3,
      initialValue: dataGamesForDisplay[index].scoreJugador2.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      onSaved: (value) {
        setState(() {
          dataGamesForDisplay[index].scoreJugador2 = int.parse(value);
        });
      },
      decoration: InputDecoration(
          icon: const Icon(Icons.sports_baseball),
          hintText: 'Ingrese el score del jugador 2',
          labelText: "Score ${dataGamesForDisplay[index].jug2}"),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor ingrese el score 2';
        }
        return null;
      },
    );
  }

  TextFormField processScoreJug1(index) {
    return TextFormField(
      maxLength: 3,
      initialValue: dataGamesForDisplay[index].scoreJugador1.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      onSaved: (value) {
        setState(() {
          dataGamesForDisplay[index].scoreJugador1 = int.parse(value);
        });
      },
      decoration: InputDecoration(
        icon: const Icon(Icons.sports_baseball),
        hintText: 'Ingrese el score del jugador 1',
        labelStyle: TextStyle(),
        labelText: 'Score ${dataGamesForDisplay[index].jug1}',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor ingrese el score 1';
        }
        return null;
      },
    );
  }
}
