import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tennis_app/src/pages/mainTabs/myTournaments_page.dart';
import 'package:tennis_app/src/pages/mainTabs/notifications_page.dart';
import 'package:tennis_app/src/pages/mainTabs/tournaments_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _titlesTabs = ["Torneos", "Mis torneos", "Notificaciones"];
  String _currentTitle = "Torneos";
  final Widget trophyIcon = SvgPicture.asset(
    'assets/trophy.svg',
    semanticsLabel: 'Trophyicon',
    color: Color.fromRGBO(174, 185, 127, 1.0),
    height: 22.0,
  );


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
          appBar: AppBar(
            title: Text(_currentTitle, style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1.0)),),
            elevation: 0,
            backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
            bottom: _tabBar(),
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
              labelColor: Color.fromRGBO(174, 185, 127, 1.0),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Color.fromRGBO(174, 185, 127, 1.0),  
              indicatorColor: Color.fromRGBO(174, 185, 127, 1.0),            
              tabs: _getTabs(),
            );
  }


  List<Tab> _getTabs() {
    return [
      Tab(
          child: Align(
        alignment: Alignment.center,
        child: Stack(children: [
          Container(child: trophyIcon),
          Container(
              padding: EdgeInsets.only(left: 16.0),
              child: trophyIcon)
        ]),
      )),
      Tab(
          child: Align(
        alignment: Alignment.center,
        child: trophyIcon,
      )),
      Tab(
          child: Align(
        alignment: Alignment.center,
        child: Icon(Icons.notifications_active_rounded),
      ))
    ];
  }

  void _changeTitle(int index) {
    if(mounted)
    setState(() {
      _currentTitle = _titlesTabs[index];
    });
  }
}
