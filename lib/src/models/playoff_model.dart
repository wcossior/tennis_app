class Playoffs {
  List<Playoff> items = new List();
  Playoffs();
  Playoffs.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final playoff = new Playoff.fromJsonMap(item);
      items.add(playoff);
    }
  }
}

class Playoff {
  String id;
  int numero;
  String etapa;
  String categoriumId;
  String createdAt;
  String updatedAt;
  int ronda;

  Playoff({
    this.id,
    this.numero,
    this.etapa,
    this.categoriumId,
    this.createdAt,
    this.updatedAt,
    this.ronda,
  });

  Playoff.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    numero = json["numero"];
    etapa = json["etapa"];
    categoriumId = json["categorium_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    ronda = json["ronda"];
  }
}
