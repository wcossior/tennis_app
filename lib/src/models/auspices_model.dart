import 'package:cloud_firestore/cloud_firestore.dart';

class Auspices {
  List<Auspice> items = new List();
  Auspices();
  Auspices.fromJsonList(List<DocumentSnapshot> list) {
    if (list == null) return;
    for (var item in list) {
      final auspice = new Auspice.fromJsonMap(item);
      items.add(auspice);
    }
  }
}

class Auspice {
  String auspiciante;
  int idTorneo;
  String nombreImg;
  String urlImg;
  String id;

  Auspice({
    this.auspiciante,
    this.idTorneo,
    this.nombreImg,
    this.urlImg,
    this.id,
  });

  Auspice.fromJsonMap(DocumentSnapshot item) {
    auspiciante = item["auspiciante"];
    idTorneo = item["id_torneo"];
    nombreImg = item["nombre_img"];
    urlImg = item["url_img"];
    id = item.documentID;
  }
}
