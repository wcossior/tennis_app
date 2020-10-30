import 'package:flutter/material.dart';
import 'package:tennis_app/src/pages/games_page.dart';
import 'package:tennis_app/src/pages/qualification_page.dart';

class DetailsGroupPage extends StatefulWidget {
  @override
  _DetailsGroupPageState createState() => _DetailsGroupPageState();
}

class _DetailsGroupPageState extends State<DetailsGroupPage> {
  final List<String> _titlesTabs = ["Clasificación", "Partidos"];
  String _currentTitle = "Clasificación";

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
          body:
              TabBarView(children: [
                QualificationPage(),
                GamesPage(tournament: tournament, typeInfo: "grupos")
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
