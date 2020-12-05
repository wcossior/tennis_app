class Groups {
  List<Group> items = new List();
  Groups();
  Groups.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final group = new Group.fromJsonMap(item);
      items.add(group);
    }
  }
}

class Group {
  String id;
  int numero;
  String nombre;
  String categoriumId;
  String createdAt;
  String updatedAt;

  Group({
    this.id,
    this.numero,
    this.nombre,
    this.categoriumId,
    this.createdAt,
    this.updatedAt,
  });

  Group.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    numero = json["numero"];
    nombre = json["nombre"];
    categoriumId = json["categorium_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }
}
