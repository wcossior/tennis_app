import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tennis_app/src/models/auspices_model.dart';
import 'package:tennis_app/src/providers/auspices_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'formAuspice.dart';

class ManageAuspicesPage extends StatefulWidget {
  final String idTournament;
  ManageAuspicesPage({Key key, this.idTournament}) : super(key: key);

  @override
  _ManageAuspicesPageState createState() => _ManageAuspicesPageState();
}

class _ManageAuspicesPageState extends State<ManageAuspicesPage> {
  List<dynamic> dataAuspices = new List<dynamic>();
  var hayInfo = true;
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  Auspice auspice = new Auspice();
  File img;
  String url;
  set setimg(File value) => setState(() => img = value);
  String estadoButtonSave = "Guardar";

  @override
  void initState() {
    fetchGames().then((data) {
      setState(() {
        dataAuspices.addAll(data);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> fetchGames() async {
    var resp = await auspiceProvider
        .getAuspicesFromThisTournament(int.parse(widget.idTournament));
    if (resp.isEmpty) {
      setState(() {
        hayInfo = false;
      });
    }

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    if (hayInfo && dataAuspices.isEmpty)
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
          body: Center(child: CircularProgressIndicator()));
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
      body: Builder(
          builder: (context) => hayInfo == true
              ? showAuspices(context)
              : Center(child: Text("No hay partidos por ahora"))),
    );
  }

  showModalAddAuspices(cntxt) {
    return AlertDialog(
      title: Text("Agregar auspiciante"),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
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
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return 'Por favor ingrese un nombre';
                //   }
                //   return null;
                // },
              ),
              FormAuspice(
                  callbackimg: (val) => setState(() => img = val))
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
            child: const Text("Cancelar"),
            onPressed: () {
              Navigator.pop(context);
              imageCache.clear();
            }),
        FlatButton(
            child: const Text("Guardar"),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                try {
                  Navigator.pop(context);
                  Map resp = await auspiceProvider.addAuspiceForTournament(
                      auspice, img);
                  myController.clear();
                  setState(() {
                    auspice.nombreImg = resp["img"];
                    auspice.urlImg = resp["url"];
                    dataAuspices.add(auspice);
                  });

                  if (resp["message"] == "Auspicio agregado") {
                    Scaffold.of(cntxt).showSnackBar(SnackBar(
                        backgroundColor: Color.fromRGBO(174, 185, 127, 1.0),
                        content: Text('Auspicio agregado')));
                  }
                } catch (e) {
                  Scaffold.of(cntxt).showSnackBar(SnackBar(
                      backgroundColor: Color.fromRGBO(246, 108, 94, 1.0),
                      content: Text('Hubo un error')));
                }
              }
            })
      ],
    );
  }

  showAuspices(BuildContext cntxt) {
    return Column(
      children: [
        FlatButton.icon(
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return showModalAddAuspices(cntxt);
                  });
            },
            icon: Icon(Icons.add, color: Color.fromRGBO(174, 185, 127, 1.0)),
            label: Text(
              "Agregar",
              style: TextStyle(color: Color.fromRGBO(174, 185, 127, 1.0)),
            )),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                return listItem(index);
              },
              itemCount: dataAuspices.length),
        ),
      ],
    );
  }

  listItem(index) {
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
                    dataAuspices[index].auspiciante,
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
                        image: NetworkImage(dataAuspices[index].urlImg),
                        fit: BoxFit.cover))
              ]),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 10.0),
              child: FlatButton.icon(
                  onPressed: () {
                    // var filePath =
                    //     "https://firebasestorage.googleapis.com/v0/b/auspiciosbd-bbd78.appspot.com/o/auspicios%2Fimage_picker1369453094056594627.jpg?alt=media&token=6cc78edc-6c89-47eb-b2cb-5ca6ed64e590";
                    // FirebaseStorage.instance
                    //     .getReferenceFromUrl(filePath)
                    //     .then((res) {
                    //   res.delete().then((res) {
                    //     print("Deleted!");
                    //   });
                    // });
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
typedef void FileCallback(File val);
