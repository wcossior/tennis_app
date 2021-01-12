import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/src/models/tournament_model.dart';

class SchedulingPage extends StatefulWidget {
  final Tournament tournament;

  SchedulingPage({Key key, this.tournament}) : super(key: key);

  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  final Widget versusIcon = SvgPicture.asset(
    'assets/versus.svg',
    semanticsLabel: 'Versusicon',
    height: 60.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Programción " + widget.tournament.nombre,
          style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1.0)),
        ),
        backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
        centerTitle: true,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color.fromRGBO(112, 112, 112, 1.0)),
      ),
      backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
      body: ListView(
        children: [
          Container(
              child: Column(
                children: [
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
                                "Hoy",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            subtitle: Center(
                              child: Text(
                                "A horas 09:00 am",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Benjamin Calisaya",
                                ),
                                Text(
                                  "Andres Cartagena",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("09:00 am"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 2"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Jorge Chavez",
                                ),
                                Text(
                                  "Jose Villarroel",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("09:00 am"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 3"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                              ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Josue Solano",
                                ),
                                Text(
                                  "Andres Arana",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("09:00 am"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 7"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                              ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ronald Arnes",
                                ),
                                Text(
                                  "Carlos Ruiz",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("09:00 am"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 5"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),











                              ListTile(
                            title: Center(
                              child: Text(
                                "Hoy",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            subtitle: Center(
                              child: Text(
                                "A continuación",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Julio Gimenez",
                                ),
                                Text(
                                  "Carlos Andres Guzman",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 1 partido"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 2"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Kevin Torrez",
                                ),
                                Text(
                                  "Marcelo Valencia",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 1 partido"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 3"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                              ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Armando Mendoza",
                                ),
                                Text(
                                  "Mario Calderón",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 1 partido"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 7"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                              ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Nicolas Mora",
                                ),
                                Text(
                                  "Ramiro Sanchez",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 1 partido"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 5"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                          






                            ListTile(
                            title: Center(
                              child: Text(
                                "Hoy",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            subtitle: Center(
                              child: Text(
                                "A continuación",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rodolfo Acosta",
                                ),
                                Text(
                                  "Carlos Andrade",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 2 partidos"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 2"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Samuel Castillo",
                                ),
                                Text(
                                  "David Mendez",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 2 partidos"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 3"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                              ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Leo Velarde",
                                ),
                                Text(
                                  "Jaime Morillo",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 2 partidos"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 7"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                              ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Alvaro Martinez",
                                ),
                                Text(
                                  "Joel Montero",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 2 partidos"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 5"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                              




                              ListTile(
                            title: Center(
                              child: Text(
                                "Hoy",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            subtitle: Center(
                              child: Text(
                                "A continuación",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Alejandro Zabalaga",
                                ),
                                Text(
                                  "Mateo Vargas",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 3 partidos"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 2"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rodrigo Reque",
                                ),
                                Text(
                                  "Douglas Bascope",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 3 partidos"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 3"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                              ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hugo Ochoa",
                                ),
                                Text(
                                  "Gonzalo Lopez",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 3 partidos"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 7"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                              ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pablo Gallardo",
                                ),
                                Text(
                                  "Santiago Aristegui",
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Inicia: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("En 3 partidos"),
                                ]),
                                Column(children: [
                                  Text("En: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("Cancha nro 5"),
                                ])
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                              indent: 15.0,
                              endIndent: 15.0,
                              thickness: 0.6,
                              color: Color.fromRGBO(174, 185, 127, 1.0)),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
              
        ],
      ),
    );
  }
}
