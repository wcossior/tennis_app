import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/src/blocs/provider.dart';
import 'package:tennis_app/src/models/auspices_model.dart';
import 'package:tennis_app/src/models/category_model.dart';
import 'package:tennis_app/src/models/tournament_model.dart';
import 'package:tennis_app/src/pages/carouselAuspices.dart';
import 'package:tennis_app/src/pages/manageAuspices_page.dart';
import 'package:tennis_app/src/preferences/preferences_user.dart';
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
  List<Auspice> dataAuspices = new List<Auspice>();
  List<Category> dataCategories = new List<Category>();
  final prefs = new PreferenciasUsuario();
  var hasDataCategories = true;
  var hasDataAuspices = true;

  @override
  void initState() {
    fetchGames().then((data) {
      setState(() {
        dataCategories.addAll(data);
      });
    });
    super.initState();
  }

  Future<List<Category>> fetchGames() async {
    var resp = await categoryProvider
        .getCategoriesfromThisTournament(widget.tournament.id);
    if (resp.isEmpty) {
      setState(() {
        hasDataCategories = false;
      });
    }

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    
    final auspicesBloc = Provider.aupicesOf(context);
    auspicesBloc.getAuspices(int.parse(widget.tournament.id));

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
      body: showData(auspicesBloc),
    );
  }

  Widget showData(AuspicesBloc auspicesBloc) {
    if (hasDataCategories && dataCategories.isEmpty)
      return Center(child: CircularProgressIndicator());
    if (dataCategories.length == 0) {
      return Center(child: Text("No hay categorías por ahora"));
    } else {
      return Column(
        children: [
          Expanded(child: showCategories(context, auspicesBloc)),
          showCarousel(auspicesBloc),
        ],
      );
    }
  }

  Widget showCarousel(AuspicesBloc auspicesBloc) {
    return hasDataAuspices == true
        ? StreamBuilder(
            stream: auspicesBloc.auspicesStream,
            builder: (context, snapshot) {
              return CarouselAuspices();
            })
        : Container();
  }

  Widget showCategories(BuildContext context,AuspicesBloc auspicesBloc ) {
    return Column(
      children: [
        prefs.token["role"]=="Administrador"?
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ManageAuspicesPage(auspices: auspicesBloc.auspices, idTournament: widget.tournament.id,)));
          },
          child: const Text('Administrar auspicios',
              style: TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0))),
        ): Container(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(10.0),
            children: _readCategories(context),
          ),
        ),
      ],
    );
  }

  List<Widget> _readCategories(BuildContext context) {
    final categories = dataCategories;
    List<Widget> readedCategories = new List<Widget>();

    for (Category item in categories) {
      final category = Container(
        width: double.infinity,
        child: drawCard(item),
      );
      readedCategories
        ..add(category)
        ..add(
          Divider(
            thickness: 1.0,
            color: Color.fromRGBO(174, 185, 127, 1.0),
          ),
        );
    }
    return readedCategories;
  }

  Widget drawCard(Category item) {
    return Card(
      color: Color.fromRGBO(249, 249, 249, 1.0),
      margin: EdgeInsets.all(0),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: categoryIcon,
            title: Text(item.nombre, style: TextStyle(fontSize: 20.0)),
            subtitle: _showInformation(item),
          ),
          ButtonBar(
            children: [drawButtonGroups(item), drawButtonPlayOffs(item)],
          ),
        ],
      ),
    );
  }

  Widget drawButtonGroups(Category item) {
    return item.tipo == "roundRobin"
        ? FlatButton(
            child: const Text('GRUPOS',
                style: TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0))),
            onPressed: () {
              Navigator.pushNamed(context, "details_group", arguments: item.id);
            },
          )
        : Container();
  }

  Widget drawButtonPlayOffs(Category item) {
    return FlatButton(
      child: const Text('ELIMINATORIA',
          style: TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0))),
      onPressed: () {
        Navigator.pushNamed(context, "details_playoff", arguments: item.id);
      },
    );
  }

  Widget _showInformation(Category category) {
    if (category.tipo == "cuadroAvance") {
      return drawInformationForCuadroAvance(category);
    } else {
      return drawInformationForRoundRobin(category);
    }
  }

  Widget drawInformationForCuadroAvance(Category category) {
    return Column(
      children: [
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
      ],
    );
  }

  drawInformationForRoundRobin(Category category) {
    return Column(
      children: [
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
      ],
    );
  }
}
