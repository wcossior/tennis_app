// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/src/models/tournament_model.dart';
import 'package:tennis_app/src/pages/carouselAuspices.dart';
import 'package:tennis_app/src/pages/manageAuspices_page.dart';
import 'package:tennis_app/src/providers/auspices_provider.dart';
import 'package:tennis_app/src/providers/category_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  List<dynamic> dataAuspices = new List<dynamic>();
  List<dynamic> dataCategories = new List<dynamic>();
  var hayInfo = true;
  var hayInfo2 = true;
  final databaseReference = Firestore.instance;

  // int _currentIndex = 0;

  @override
  void initState() {
    fetchGames().then((data) {
      setState(() {
        dataCategories.addAll(data);
      });
    });
    fetchAuspices().then((data) {
      setState(() {
        dataAuspices.addAll(data);
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

  Future<List<dynamic>> fetchAuspices() async {
    var resp = await auspiceProvider
        .getAuspicesFromThisTournament(int.parse(widget.tournament.id));

    if (resp.isEmpty) {
      setState(() {
        hayInfo2 = false;
      });
    }
    return resp;
  }

  getAuspices() async {
    var resp = await auspiceProvider
        .getAuspicesFromThisTournament(int.parse(widget.tournament.id));
    setState(() {
      dataAuspices.clear();
      dataAuspices.addAll(resp);
    });
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
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
      body: Builder(builder: (cntxt) => buildBody()),
    );
  }

  Widget buildBody() {
    return Column(
      children: [Expanded(child: buildContent()), buildFooter()],
    );
  }

  Widget buildContent() {
    return hayInfo == true
        ? _showCategories(context)
        : Center(child: Text("No hay categorías por ahora"));
  }

  Widget buildFooter() {
    return hayInfo2 == true
        // ? Column(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: <Widget>[
        //       Container(
        //         decoration: BoxDecoration(boxShadow: [
        //           BoxShadow(
        //             color: Colors.grey,
        //             blurRadius: 10.0,
        //             spreadRadius: 3.0,
        //           ),
        //         ]),
        //         child: CarouselSlider(
        //           options: CarouselOptions(
        //             height: MediaQuery.of(context).size.height * 0.18,
        //             autoPlay: true,
        //             autoPlayInterval: Duration(seconds: 3),
        //             autoPlayAnimationDuration: Duration(milliseconds: 800),
        //             autoPlayCurve: Curves.fastOutSlowIn,
        //             pauseAutoPlayOnTouch: true,
        //             aspectRatio: 2.0,
        //             onPageChanged: (index, reason) {
        //               setState(() {
        //                 _currentIndex = index;
        //               });
        //             },
        //           ),
        //           items: dataAuspices.map((auspice) {
        //             return Builder(builder: (BuildContext context) {
        //               return Container(
        //                   height: MediaQuery.of(context).size.height * 0.30,
        //                   width: MediaQuery.of(context).size.width,
        //                   child: Container(
        //                       width: double.infinity,
        //                       height: MediaQuery.of(context).size.width * 0.40,
        //                       child: FadeInImage(
        //                           placeholder:
        //                               AssetImage("assets/jar-loading.gif"),
        //                           fadeInDuration: Duration(milliseconds: 200),
        //                           image: NetworkImage(auspice.urlImg),
        //                           fit: BoxFit.cover)));
        //             });
        //           }).toList(),
        //         ),
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: map<Widget>(dataAuspices, (index, url) {
        //           return Container(
        //             width: 10.0,
        //             height: 10.0,
        //             margin:
        //                 EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        //             decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //               color: _currentIndex == index
        //                   ? Colors.blueAccent
        //                   : Colors.grey,
        //             ),
        //           );
        //         }),
        //       ),
        //     ],
        //   )
        ? CarouselAuspices(idTournament: widget.tournament.id)
        // currentIndex: _currentIndex, listAuspices: dataAuspices)
        : Container();
  }

  Widget _showCategories(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ManageAuspicesPage(idTournament: widget.tournament.id)));
          },
          child: const Text('Administrar auspicios',
              style: TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0))),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(10.0),
            children: _readCategories(context),
          ),
        ),
      ],
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
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => CategoriesPage(
                            //         tournament: widget.tournament)));
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
