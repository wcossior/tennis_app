import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tennis_app/src/blocs/auspices_bloc.dart';
export 'package:tennis_app/src/blocs/auspices_bloc.dart';
import 'package:tennis_app/src/models/auspices_model.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class AuspicesProvider extends InheritedWidget {
  static AuspicesProvider _instancia;
  final databaseReference = Firestore.instance;

  factory AuspicesProvider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = AuspicesProvider._internal(key: key, child: child);
    }
    return _instancia;
  }

  AuspicesProvider._internal({Key key, Widget child})
      : super(key: key, child: child);

  final auspicesBloc = new AuspicesBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuspicesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AuspicesProvider>())
        .auspicesBloc;
  }

  List<Auspice> _processResp(List<DocumentSnapshot> data) {
    final auspices = new Auspices.fromJsonList(data);
    return auspices.items;
  }

  Future<List<Auspice>> getAuspicesFromThisTournament(int id) async {
    try {
      var resp;
      var data = (await databaseReference
              .collection("auspicios")
              .where("id_torneo", isEqualTo: id)
              .getDocuments())
          .documents
          .toList();
      resp = _processResp(data);
      return resp;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map> addAuspiceForTournament(Auspice ausp, File img) async {
    try {
      String uploadedFileURL;
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('auspicios/${Path.basename(img.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(img);
      var url = await (await uploadTask.onComplete).ref.getDownloadURL();
      uploadedFileURL = url.toString();

      var response = await databaseReference.collection("auspicios").add({
        'auspiciante': ausp.auspiciante,
        'nombre_img': img.toString(),
        'url_img': uploadedFileURL,
        'id_torneo': ausp.idTorneo
      });

      Map resp = {
        "message": "Auspicio agregado",
        "url": uploadedFileURL,
        "img": img.toString(),
        "id": response.documentID
      };
      return resp;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> deleteAuspiceFromATournament(String id, String url) async {
    try {
      FirebaseStorage.instance.getReferenceFromUrl(url).then((res) {
        res.delete().then((res) {
          print("borrado!");
        });
      });

      await databaseReference.collection('auspicios').document(id).delete();
      return "auspicio borrado";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
