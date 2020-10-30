import 'package:flutter/material.dart';
import 'package:tennis_app/src/pages/games_page.dart';
import 'package:tennis_app/src/pages/playoff_page.dart';

class DetailsPlayoffPage extends StatefulWidget {
  @override
  _DetailsPlayoffPageState createState() => _DetailsPlayoffPageState();
}

class _DetailsPlayoffPageState extends State<DetailsPlayoffPage> {
  final List<String> _titlesTabs = ["Eliminación", "Partidos"];

  String _currentTitle = "Eliminación";

  @override
  Widget build(BuildContext context) {
    final tournament = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(_currentTitle),
            elevation: 0,
            backgroundColor: Color.fromRGBO(11, 164, 93, 1.0),
            bottom: _tabBar(),
            centerTitle: true,
          ),
          body: TabBarView(children: [
            PlayoffPage(),
            GamesPage(tournament: tournament, typeInfo: "eliminatoria")
          ])),
    );
  }

  Widget _tabBar() {
    return TabBar(
      onTap: _changeTitle,
      labelColor: Color.fromRGBO(11, 164, 93, 1.0),
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: Colors.white,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
          color: Colors.white),
      tabs: _getTabs(),
    );
  }

  List<Tab> _getTabs() {
    return [
      Tab(
          child: Align(
        alignment: Alignment.center,
        child: Icon(Icons.list),
      )),
      Tab(
          child: Align(
        alignment: Alignment.center,
        child: Icon(Icons.calendar_today_rounded),
      ))
    ];
  }

  void _changeTitle(int index) {
    setState(() {
      _currentTitle = _titlesTabs[index];
    });
  }
}
