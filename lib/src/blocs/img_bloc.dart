import 'dart:async';
import 'dart:io';
import 'package:rxdart/rxdart.dart';

class ImgBloc {
  final _imgController = BehaviorSubject<File>();

  Stream<File> get imgStream => _imgController.stream;
  Function(File) get imgSink => _imgController.sink.add;

  File get img => _imgController.value;

  dispose() {
    _imgController?.close();
  }
}