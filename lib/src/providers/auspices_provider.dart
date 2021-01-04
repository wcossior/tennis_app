import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennis_app/src/models/auspices_model.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class _AuspicesProvider {
  List<dynamic> auspices = [];
  final databaseReference = Firestore.instance;
  String uploadedFileURL;

  List<Auspice> _processResp(List<DocumentSnapshot> data) {
    final auspices = new Auspices.fromJsonList(data);
    return auspices.items;
  }

  Future<List<dynamic>> getAuspicesFromThisTournament(int id) async {
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
      print("En provider " + id);
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

final auspiceProvider = new _AuspicesProvider();
