import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tennis_app/src/pages/myTournaments_page.dart';
import 'package:tennis_app/src/pages/notifications_page.dart';
import 'package:tennis_app/src/pages/tournaments_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _titlesTabs = ["Torneos", "Mis torneos", "Notificaciones"];
  String _currentTitle = "Torneos";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            TournamentsPage(),
            MyTournamentsPage(),
            NotificationsPage()
          ])),
    );
  }

  Widget _tabBar(){
    return TabBar(
              onTap: _changeTitle,
              labelColor: Color.fromRGBO(11, 164, 93, 1.0),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  color: Colors.white),
              tabs: _getTabs(),
            );
  }


  List<Tab> _getTabs() {
    return [
      Tab(
          child: Align(
        alignment: Alignment.center,
        child: Stack(children: [
          Container(child: Icon(FontAwesomeIcons.trophy)),
          Container(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(FontAwesomeIcons.trophy))
        ]),
      )),
      Tab(
          child: Align(
        alignment: Alignment.center,
        child: Icon(FontAwesomeIcons.trophy),
      )),
      Tab(
          child: Align(
        alignment: Alignment.center,
        child: Icon(Icons.notifications_active_rounded),
      ))
    ];
  }

  void _changeTitle(int index) {
    setState(() {
      _currentTitle = _titlesTabs[index];
    });
  }
}
