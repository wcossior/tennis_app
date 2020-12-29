import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailsGamePage extends StatefulWidget {
  final game;
  final typeGame;
  DetailsGamePage({Key key, this.game, this.typeGame}) : super(key: key);

  @override
  _DetailsGamePageState createState() => _DetailsGamePageState();
}

class _DetailsGamePageState extends State<DetailsGamePage> {
  final Widget versusIcon = SvgPicture.asset(
    'assets/versus.svg',
    semanticsLabel: 'Versusicon',
    height: 160.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Detalles partido",
            style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1.0)),
          ),
          backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
          centerTitle: true,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Color.fromRGBO(112, 112, 112, 1.0)),
        ),
        backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
        body: widget.typeGame == "eliminatoria"
            ? showGameFromPlayoffs()
            : showGameFromAGroup());
  }

  Widget showGameFromPlayoffs() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Center(child: versusIcon),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Center(
                        child: Text(
                          widget.game.etapa,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                    Divider(
                        indent: 15.0,
                        endIndent: 15.0,
                        thickness: 0.6,
                        color: Color.fromRGBO(174, 185, 127, 1.0)),
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Resultado Sets:"),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.game.jug1,
                          ),
                          Text(
                            widget.game.scoreJugador1.toString(),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.game.jug2,
                          ),
                          Text(
                            widget.game.scoreJugador2.toString(),
                          )
                        ],
                      ),
                    ),
                    Divider(
                        indent: 15.0,
                        endIndent: 15.0,
                        thickness: 0.6,
                        color: Color.fromRGBO(174, 185, 127, 1.0)),
                    ListTile(
                      title: Text("Inicia: "),
                      subtitle: Text(widget.game.horaInicio),
                    ),
                    Divider(
                        indent: 15.0,
                        endIndent: 15.0,
                        thickness: 0.6,
                        color: Color.fromRGBO(174, 185, 127, 1.0)),
                    ListTile(
                      title: Text("El partido se jugara"),
                      subtitle:
                          Text("Cancha " + widget.game.nroCancha.toString()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget showGameFromAGroup() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Center(child: versusIcon),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Center(
                        child: Text(
                          "Partido Grupo " + widget.game.nombre,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                    Divider(
                        indent: 15.0,
                        endIndent: 15.0,
                        thickness: 0.6,
                        color: Color.fromRGBO(174, 185, 127, 1.0)),
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Resultado Sets:"),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.game.jug1,
                          ),
                          Text(
                            widget.game.scoreJugador1.toString(),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.game.jug2,
                          ),
                          Text(
                            widget.game.scoreJugador2.toString(),
                          )
                        ],
                      ),
                    ),
                    Divider(
                        indent: 15.0,
                        endIndent: 15.0,
                        thickness: 0.6,
                        color: Color.fromRGBO(174, 185, 127, 1.0)),
                    ListTile(
                      title: Text("Inicia: "),
                      subtitle: Text(widget.game.horaInicio),
                    ),
                    Divider(
                        indent: 15.0,
                        endIndent: 15.0,
                        thickness: 0.6,
                        color: Color.fromRGBO(174, 185, 127, 1.0)),
                    ListTile(
                      title: Text("El partido se jugara"),
                      subtitle:
                          Text("Cancha " + widget.game.nroCancha.toString()),
                    )                    
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
