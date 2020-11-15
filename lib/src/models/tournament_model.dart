class Tournaments {
  List<Tournament> items = new List();
  Tournaments();
  Tournaments.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final tournament = new Tournament.fromJsonMap(item);
      items.add(tournament);
    }
  }
}

class Tournament {
  String id;
  String nombre;
  String fechaInicio;
  String fechaFin;
  String createdAt;
  String updatedAt;
  int numeroCanchas;

  Tournament({
    this.id,
    this.nombre,
    this.fechaInicio,
    this.fechaFin,
    this.createdAt,
    this.updatedAt,
    this.numeroCanchas,
  });

  Tournament.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    nombre = json["nombre"];
    fechaInicio = json["fecha_inicio"];
    fechaFin = json["fecha_fin"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    numeroCanchas = json["numero_canchas"];
  }
}
