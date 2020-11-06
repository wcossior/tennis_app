import 'package:flutter/material.dart';

class MyTournamentsPage extends StatefulWidget {
  MyTournamentsPage({Key key}) : super(key: key);

  @override
  _MyTournamentsPageState createState() => _MyTournamentsPageState();
}

class _MyTournamentsPageState extends State<MyTournamentsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("Mis torneos"),
    );
  }
}