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
        body: Container(child: Center(child: Text("Programción"))));
  }
}
