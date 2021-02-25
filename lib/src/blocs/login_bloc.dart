import 'dart:async';
import 'package:tennis_app/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _userController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream

  Stream<String> get userStream => _userController.stream.transform(validarUser);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(userStream, passwordStream, (e, p) => true);


  // Insertar valores al Stream
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeUser => _userController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get password => _passwordController.value;
  String get user => _userController.value;

  dispose() {
    _passwordController?.close();
    _userController?.close();
  }
}
