import 'dart:async';
import 'package:tennis_app/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  final _ciController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _nombreController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get ciStream => _ciController.stream.transform(validarCi);
  Stream<String> get nombreStream =>
      _nombreController.stream.transform(validarNombre);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formNewUserValidStream => Observable.combineLatest4(ciStream,
      emailStream, nombreStream, passwordStream, (c, e, n, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeNombre => _nombreController.sink.add;
  Function(String) get changeCi => _ciController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get email => _emailController.value;
  String get ci => _ciController.value;
  String get nombre => _nombreController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _ciController?.close();
    _nombreController?.close();
    _passwordController?.close();
  }
}
