import 'package:flutter/material.dart';
import 'package:tennis_app/src/pages/categories_page.dart';
import 'package:tennis_app/src/pages/details_game.dart';
import 'package:tennis_app/src/pages/mainTabs/home_page.dart';
import 'package:tennis_app/src/pages/details_group_page.dart';
import 'package:tennis_app/src/pages/details_playoff_page.dart';
import 'package:tennis_app/src/pages/mainTabs/login_page.dart';
import 'package:tennis_app/src/pages/manageAuspices_page.dart';
import 'package:tennis_app/src/pages/scheduling_page.dart';
import 'package:tennis_app/src/providers/auspices_provider.dart';
import 'package:tennis_app/src/providers/img_provider.dart';
import 'package:tennis_app/src/providers/login_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginProvider(
      child: ImgProvider(
        child: AuspicesProvider(
          child: MaterialApp(
            title: 'Material App',
            debugShowCheckedModeBanner: false,
            initialRoute: "login",
            routes: {
              "/": (BuildContext context) => HomePage(),
              "login": (BuildContext context) => LoginPage(),
              "details_group": (BuildContext context) => DetailsGroupPage(),
              "details_playoff": (BuildContext context) => DetailsPlayoffPage(),
              "categories": (BuildContext context) => CategoriesPage(),
              "details_game": (BuildContext context) => DetailsGamePage(),
              "manage_auspices": (BuildContext context) => ManageAuspicesPage(),
              "scheduling": (BuildContext context) => SchedulingPage()
            },
            theme: ThemeData(
              primaryColor: Color.fromRGBO(174, 185, 127, 1.0),
            ),
          ),
        ),
      ),
    );
  }
}
