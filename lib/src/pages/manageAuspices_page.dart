import 'package:flutter/material.dart';
import 'package:tennis_app/src/models/auspices_model.dart';
import 'package:tennis_app/src/providers/auspices_provider.dart';
import 'package:tennis_app/src/providers/img_provider.dart';
import 'formAuspice.dart';

class ManageAuspicesPage extends StatefulWidget {
  final List<Auspice> auspices;
  final String idTournament;
  ManageAuspicesPage({Key key, this.auspices, this.idTournament})
      : super(key: key);

  @override
  _ManageAuspicesPageState createState() => _ManageAuspicesPageState();
}

class _ManageAuspicesPageState extends State<ManageAuspicesPage> {
  List<dynamic> dataAuspices = new List<dynamic>();
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  Auspice auspice = new Auspice();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auspicesBloc = AuspicesProvider.of(context);
    final imgBloc = ImgProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Auspicios",
          style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1.0)),
        ),
        backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
        centerTitle: true,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color.fromRGBO(112, 112, 112, 1.0)),
      ),
      backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
      body: Builder(builder: (cntxt) => showAuspices(cntxt, auspicesBloc)),
      floatingActionButton: Builder(
          builder: (cntxt) =>
              drawButtonAddAuspice(cntxt, auspicesBloc, imgBloc)),
    );
  }

  FloatingActionButton drawButtonAddAuspice(BuildContext scaffoldContext,
      AuspicesBloc auspicesBloc, ImgBloc imgBloc) {
    return FloatingActionButton(
      child: Icon(Icons.add_to_photos),
      onPressed: () {
        myController.clear();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => Scaffold(
            backgroundColor: Colors.transparent,
            body: Builder(
              builder: (context) => showModalAddAuspices(
                  scaffoldContext, context, auspicesBloc, imgBloc),
            ),
          ),
        );
      },
    );
  }

  showModalAddAuspices(BuildContext scaffoldContext, BuildContext cntxtSnackBar,
      AuspicesBloc auspicesBloc, ImgBloc imgBloc) {
    return AlertDialog(
      title: Text("Agregar auspiciante"),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [drawAuspicianteField(), drawImgField()],
          ),
        ),
      ),
      actions: [
        FlatButton(
            child: const Text("Cancelar"),
            onPressed: () {
              Navigator.pop(context);
              myController.clear();
              imgBloc.imgSink(null);
            }),
        FlatButton(
            child: const Text("Guardar"),
            onPressed: () async {
              if (myController.text.isNotEmpty && imgBloc.img != null) {
                _formKey.currentState.save();
                try {
                  Navigator.pop(context);

                  Map resp = await auspicesBloc.addAuspice(
                      auspice, imgBloc.img, int.parse(widget.idTournament));

                  if (resp["message"] == "Auspicio agregado") {
                    print("miau");
                    imgBloc.imgSink(null);
                    Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
                        backgroundColor: Color.fromRGBO(174, 185, 127, 1.0),
                        content: Text('Auspicio agregado')));
                  }
                } catch (e) {
                  Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
                      backgroundColor: Color.fromRGBO(246, 108, 94, 1.0),
                      content: Text("Hubo un error")));
                }
              } else {
                Scaffold.of(cntxtSnackBar).showSnackBar(SnackBar(
                    backgroundColor: Color.fromRGBO(246, 108, 94, 1.0),
                    content: Text('Llene los campos por favor')));
              }
            })
      ],
    );
  }

  FormAuspice drawImgField() => FormAuspice();

  TextFormField drawAuspicianteField() {
    return TextFormField(
      controller: myController,
      onSaved: (value) {
        setState(() {
          auspice.auspiciante = value;
          auspice.idTorneo = int.parse(widget.idTournament);
        });
      },
      decoration: InputDecoration(
          icon: const Icon(Icons.supervisor_account),
          hintText: 'Nombre del auspiciante',
          labelText: "Auspiciante"),
    );
  }

  showAuspices(BuildContext cntxt, AuspicesBloc auspicesBloc) {
    return StreamBuilder(
        stream: auspicesBloc.auspicesStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final auspices = snapshot.data;

          if (auspices.length == 0) {
            return Center(
              child: Text("No hay auspicios perra"),
            );
          }
          return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                return listItem(index, cntxt, auspices, auspicesBloc);
              },
              itemCount: auspices.length);
        });
  }

  listItem(index, BuildContext cntxt, auspices, AuspicesBloc auspicesBloc) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(children: [
                Container(
                  width: double.infinity,
                  color: Color.fromRGBO(174, 185, 127, 1.0),
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    auspices[index].auspiciante,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.40,
                    child: FadeInImage(
                        placeholder: AssetImage("assets/jar-loading.gif"),
                        fadeInDuration: Duration(milliseconds: 200),
                        image: NetworkImage(auspices[index].urlImg),
                        fit: BoxFit.cover))
              ]),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 10.0),
              child: FlatButton.icon(
                  onPressed: () async {
                    try {
                      var resp = await auspicesBloc.deleteAuspice(
                        auspices[index].id,
                        auspices[index].urlImg,
                        int.parse(widget.idTournament),
                      );
                      if (resp == "auspicio borrado") {
                        Scaffold.of(cntxt).showSnackBar(SnackBar(
                            backgroundColor: Color.fromRGBO(174, 185, 127, 1.0),
                            content: Text('Auspicio borrado')));
                      }
                    } catch (e) {
                      Scaffold.of(cntxt).showSnackBar(SnackBar(
                          backgroundColor: Color.fromRGBO(246, 108, 94, 1.0),
                          content: Text("Hubo un error")));
                    }
                  },
                  icon: Icon(Icons.delete,
                      color: Color.fromRGBO(246, 108, 94, 1.0)),
                  label: Text(
                    "Borrar",
                    style: TextStyle(color: Color.fromRGBO(246, 108, 94, 1.0)),
                  )))
        ],
      ),
    );
  }
}
