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
  final Widget categoryIcon = SvgPicture.asset(
    'assets/iconoCategoria.svg',
    semanticsLabel: 'Categoryicon',
    height: 60.0,
  );

  List<dynamic> dataCategories = new List<dynamic>();
  var hayInfo = true;

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
    var resp = await categoryProvider
        .getCategoriesfromThisTournament(widget.tournament.id);
    if (resp.isEmpty) {
      setState(() {
        hayInfo = false;
      });
    }

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    if (hayInfo && dataCategories.isEmpty)
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
          body: Center(child: CircularProgressIndicator()));

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
      body: hayInfo == true
          ? _showCategories(context)
          : Center(child: Text("No hay categorías por ahora")),
    );
  }

  Widget _showCategories(BuildContext context) {
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
                children: [
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
          color: Color.fromRGBO(174, 185, 127, 1.0),
        ));
    }
    return readedCategories;
  }
}
