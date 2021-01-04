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
      // print('Imagen subida');
      // storageReference.getDownloadURL().then((fileURL) {
      //   uploadedFileURL = fileURL;
      //   print(uploadedFileURL);
      // });

      await databaseReference.collection("auspicios").add({
        'auspiciante': ausp.auspiciante,
        'nombre_img': img.toString(),
        'url_img': uploadedFileURL,
        'id_torneo': ausp.idTorneo
      });
      Map resp = {"message": "Auspicio agregado","url": uploadedFileURL, "img": img.toString()};
      return resp;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> deleteAuspiceFromATournament(String id) async {
    try {
      await databaseReference.collection('auspicios').document(id).delete();
      return "borrado";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

final auspiceProvider = new _AuspicesProvider();
