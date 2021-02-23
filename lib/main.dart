import 'package:flutter/material.dart';
import 'package:tennis_app/src/blocs/provider.dart';
import 'package:tennis_app/src/pages/categories_page.dart';
import 'package:tennis_app/src/pages/details_game.dart';
import 'package:tennis_app/src/pages/mainTabs/home_page.dart';
import 'package:tennis_app/src/pages/details_group_page.dart';
import 'package:tennis_app/src/pages/details_playoff_page.dart';
import 'package:tennis_app/src/pages/mainTabs/login_page.dart';
import 'package:tennis_app/src/pages/manageAuspices_page.dart';
import 'package:tennis_app/src/pages/scheduling_page.dart';
import 'package:tennis_app/src/preferences/preferences_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();

    return Provider(
      child: WillPopScope(
        onWillPop: () async => false,
        child: MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          initialRoute: prefs.isLogged() == false ? "login" : "/",
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
    );
  }
}
