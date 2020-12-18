import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/src/models/tournament_model.dart';
import 'package:tennis_app/src/providers/category_provider.dart';

class CategoriesPage extends StatefulWidget {
  final Tournament tournament;
  CategoriesPage({Key key, this.tournament}) : super(key: key);
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final Widget tournamenticon = SvgPicture.asset(
    'assets/tournament.svg',
    semanticsLabel: 'Tournament',
    color: Color.fromRGBO(11, 164, 93, 1.0),
    width: 40.0,
  );

  final Widget categoryIcon = SvgPicture.asset(
    'assets/iconoCategoria.svg',
    semanticsLabel: 'Categoryicon',
    height: 60.0,
  );

  List<dynamic> dataCategories = new List<dynamic>();

  @override
  void initState() {
    fetchGames().then((data) {
      setState(() {
        dataCategories.addAll(data);
      });
    });
    super.initState();
  }

  Future<List<dynamic>> fetchGames() async {
    var resp =
        await categoryProvider.getCategoriesfromThisTournament(widget.tournament.id);

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categorías",
          style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1.0)),
        ),
        backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
        centerTitle: true,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color.fromRGBO(112, 112, 112, 1.0)),
      ),
      backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
      body: _showCategories(context),
    );
  }

  // Widget _showCategories(tournament) {
  //   return FutureBuilder(
  //       future: categoryProvider.getCategoriesfromThisTournament(tournament.id),
  //       builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
  //         if (snapshot.hasData) {
  //           return ListView(
  //             padding: EdgeInsets.all(10.0),
  //             children: _readCategories(snapshot.data, context),
  //           );
  //         } else {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //       });
  // }

  Widget _showCategories(BuildContext context) {
    if (dataCategories.isEmpty)
      return Center(child: CircularProgressIndicator());

    return ListView(
      padding: EdgeInsets.all(10.0),
      children: _readCategories(context),
    );
  }

  List<Widget> _showInformation(category) {
    if (category.tipo == "cuadroAvance") {
      return [
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Text("Tipo: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.tipo),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          children: [
            Text("Número de jugadores: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.numeroJugadores.toString()),
          ],
        ),
      ];
    } else {
      return [
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Text("Tipo: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.tipo),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          children: [
            Text("Número de jugadores: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.numeroJugadores.toString()),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          children: [
            Text("Número de grupos: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.numeroGrupos.toString()),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          children: [
            Text("Número de jugadores por grupo: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.numeroJugadoresGrupo.toString()),
          ],
        ),
      ];
    }
  }

  List<Widget> _readCategories(BuildContext context) {
    final categories = dataCategories;
    List<Widget> readedCategories = new List<Widget>();

    for (var item in categories) {
      final info = Container(
        width: double.infinity,
        child: Card(
          color: Color.fromRGBO(249, 249, 249, 1.0),
          margin: EdgeInsets.all(0),
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: categoryIcon,
                title: Text(item.nombre, style: TextStyle(fontSize: 20.0)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _showInformation(item),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  item.tipo == "roundRobin"
                      ? FlatButton(
                          child: const Text('GRUPOS',
                              style: TextStyle(
                                  color: Color.fromRGBO(174, 185, 127, 1.0))),
                          onPressed: () {
                            Navigator.pushNamed(context, "details_group",
                                arguments: item.id);
                          },
                        )
                      : Container(),
                  FlatButton(
                    child: const Text('ELIMINATORIA',
                        style: TextStyle(
                            color: Color.fromRGBO(174, 185, 127, 1.0))),
                    onPressed: () {
                      Navigator.pushNamed(context, "details_playoff",
                          arguments: item.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      readedCategories
        ..add(info)
        ..add(Divider(
          thickness: 1.0,
        ));
    }
    return readedCategories;
  }
}
