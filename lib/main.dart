import 'package:flutter/material.dart';
import 'package:tennis_app/src/pages/home_page.dart';
import 'package:tennis_app/src/pages/details_group_page.dart';
import 'package:tennis_app/src/pages/details_playoff_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => HomePage(),
        "details_group": (BuildContext context) => DetailsGroupPage(),
        "details_playoff": (BuildContext context) => DetailsPlayoffPage(),
      },
    );
  }
}
