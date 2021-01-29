import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tennis_app/src/models/auspices_model.dart';
import 'package:tennis_app/src/providers/auspices_provider.dart';
import 'dart:io';

class AuspicesBloc {
  final _auspicesController = BehaviorSubject<List<Auspice>>();

  Stream<List<Auspice>> get auspicesStream => _auspicesController.stream;
  Function(List<Auspice>) get auspicesSink => _auspicesController.sink.add;

  List<Auspice> get auspices => _auspicesController.value;

  dispose() {
    _auspicesController?.close();
  }

  getAuspices(int id) async {
    auspicesSink(await AuspicesProvider().getAuspicesFromThisTournament(id));
  }

  addAuspice(Auspice a, File img, int id) async {
    Map resp = await AuspicesProvider().addAuspiceForTournament(a, img);
    getAuspices(id);
    return resp;
  }

  deleteAuspice(String id, String url, int idTorneo) async {
    var resp =
        await AuspicesProvider().deleteAuspiceFromATournament(id, url);
    getAuspices(idTorneo);
    return resp;
  }
}
