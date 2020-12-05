class GamesGroup {
  List<GameGroup> items = new List();
  GamesGroup();
  GamesGroup.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final gameGroup = new GameGroup.fromJsonMap(item);
      items.add(gameGroup);
    }
  }
}

class GameGroup {
  String nombre;
  String horaInicio;
  String jugadorUnoId;
  String jugadorDosId;
  String jug1;
  String jug2;

  GameGroup({
    this.nombre,
    this.horaInicio,
    this.jugadorUnoId,
    this.jugadorDosId,
    this.jug1,
    this.jug2,
  });
  GameGroup.fromJsonMap(Map<String, dynamic> json) {
    nombre = json["nombre"];
    horaInicio = formatDate(json["hora_inicio"]);
    jugadorUnoId = json["jugador_uno_id"];
    jugadorDosId = json["jugador_dos_id"];
    jug1 = json["jug1"];
    jug2 = json["jug2"];
  }

  String formatDate(dateWithoutFormat) {
    DateTime date = DateTime.parse(dateWithoutFormat);
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();
    String hour = date.hour.toString();
    String minutes = date.minute.toString();
    if (date.hour < 10) {
      hour = "0" + hour;
    }
    if (date.minute < 10) {
      minutes = "0" + minutes;
    }

    String formatedDate = "El $day/$month/$year" + " a las " + "$hour:$minutes";

    return formatedDate;
  }
}
