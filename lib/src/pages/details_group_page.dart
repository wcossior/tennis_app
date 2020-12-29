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
    final idCategory = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text(
                _currentTitle,
                style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1.0)),
              ),
              elevation: 0,
              backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
              bottom: _tabBar(),
              centerTitle: true,
              iconTheme:
                  IconThemeData(color: Color.fromRGBO(112, 112, 112, 1.0))),
          body: TabBarView(children: [
            QualificationPage(),
            GamesPage(idCategory: idCategory, typeInfo: "grupos")
          ])),
    );
  }

  Widget _tabBar() {
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
