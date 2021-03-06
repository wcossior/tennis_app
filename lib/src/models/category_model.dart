class Categories {
  List<Category> items = new List();
  Categories();
  Categories.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final category = new Category.fromJsonMap(item);
      items.add(category);
    }
  }
}

class Category {
  String id;
  String nombre;
  int numeroJugadores;
  int numeroGrupos;
  int numeroJugadoresGrupo;
  String tipo;
  String torneoId;
  String createdAt;
  String updatedAt;

  Category({
    this.id,
    this.nombre,
    this.numeroJugadores,
    this.numeroGrupos,
    this.numeroJugadoresGrupo,
    this.tipo,
    this.torneoId,
    this.createdAt,
    this.updatedAt
  });

  Category.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    nombre = json["nombre"];
    numeroJugadores = json["numero_jugadores"];
    numeroGrupos = json["numero_grupos"];
    numeroJugadoresGrupo = json["numero_jugadores_grupo"];
    tipo = json["tipo"];
    torneoId = json["torneo_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }
}
