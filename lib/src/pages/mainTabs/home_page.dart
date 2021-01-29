import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tennis_app/src/pages/mainTabs/notifications_page.dart';
import 'package:tennis_app/src/pages/mainTabs/tournaments_page.dart';
import 'package:tennis_app/src/providers/login_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _titlesTabs = ["Mis torneos", "Notificaciones"];
  String _currentTitle = "Mis torneos";
  final Widget trophyIcon = SvgPicture.asset(
    'assets/trophy.svg',
    semanticsLabel: 'Trophyicon',
    color: Color.fromRGBO(174, 185, 127, 1.0),
    height: 22.0,
  );

  @override
  Widget build(BuildContext context) {
    final loginBloc = LoginProvider.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
        appBar: AppBar(
          title: Text(
            _currentTitle,
            style: TextStyle(
              color: Color.fromRGBO(112, 112, 112, 1.0),
            ),
          ),
          elevation: 0,
          backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
          bottom: _tabBar(),
          actions: [
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1.0)),
                    text: loginBloc.email),
              ),
            ),
          ],
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [TournamentsPage(), NotificationsPage()],
        ),
      ),
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
    return [drawTabAllTournmaments(), drawTabNotifications()];
  }

  Widget drawTabAllTournmaments() {
    return Tab(
        child: Align(
      alignment: Alignment.center,
      child: Stack(children: [
        Container(child: trophyIcon),
        Container(
          padding: EdgeInsets.only(left: 16.0),
          child: trophyIcon,
        )
      ]),
    ));
  }

  Widget drawTabNotifications() {
    return Tab(
        child: Align(
      alignment: Alignment.center,
      child: Icon(Icons.notifications_active_rounded),
    ));
  }

  void _changeTitle(int index) {
    setState(() {
      _currentTitle = _titlesTabs[index];
    });
  }
}
