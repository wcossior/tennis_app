import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/src/providers/games_group_provider.dart';
import 'package:tennis_app/src/providers/games_playoff_provider.dart';
import 'package:tennis_app/src/providers/games_provider.dart';

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

  @override
  bool get wantKeepAlive => true;

  List<dynamic> dataGames = new List<dynamic>();
  List<dynamic> dataGamesForDisplay = new List<dynamic>();
  var hayData = true;

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
    Future.delayed(Duration(seconds: 6), () {
      if (dataGames.isEmpty)
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
              SizedBox(height: 15.0),
              Text(dataGamesForDisplay[index].horaInicio),
            ],
          ),
        ),
        FlatButton(
          child: const Text('Cambiar Score',
              style: TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0))),
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                child: AlertDialog(
                  title: Text(
                      "Soy un modal"), //akjshdlkfjalksdjflkñajsñdlkfjlñkasjdlkfjaslkdjf
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          initialValue: dataGamesForDisplay[index]
                              .scoreJugador1
                              .toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onSaved: (value) {
                            setState(() {
                              dataGamesForDisplay[index].scoreJugador1 =
                                  int.parse(value);
                            });
                          },
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.sports_baseball),
                            hintText: 'Ingrese el score del jugador 1',
                            labelText: 'Score 1',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor ingrese el score 1';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: dataGamesForDisplay[index]
                              .scoreJugador2
                              .toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onSaved: (value) {
                            setState(() {
                              dataGamesForDisplay[index].scoreJugador2 =
                                  int.parse(value);
                            });
                          },
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.sports_baseball),
                            hintText: 'Ingrese el score del jugador 2',
                            labelText: 'Score 2',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor ingrese el score 2';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    FlatButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                          // Scaffold.of(context).showSnackBar(
                          //     SnackBar(content: Text('Processing Data')));
                        }),
                    FlatButton(
                        child: const Text("Ok"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            try {
                              Navigator.pop(context);
                              var resp =
                                  await gamesProvider.updateScoreFromAgame(
                                      dataGamesForDisplay[index].id,
                                      dataGamesForDisplay[index].scoreJugador1,
                                      dataGamesForDisplay[index].scoreJugador2);
                              if (resp == "score actualizado") {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:
                                        Color.fromRGBO(174, 185, 127, 1.0),
                                    content: Text('Score actualizado')));
                              }
                            } catch (e) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:
                                      Color.fromRGBO(174, 185, 127, 1.0),
                                  content: Text('Hubo un error')));
                            }
                          }
                        }),
                  ],
                ));
          },
        ),
        Divider(thickness: 1.0, color: Color.fromRGBO(174, 185, 127, 1.0))
      ],
    );
  }
}
