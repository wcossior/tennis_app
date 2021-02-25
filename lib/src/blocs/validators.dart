import 'dart:async';



class Validators {


  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( email, sink ) {


      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(pattern);

      if ( regExp.hasMatch( email ) ) {
        sink.add( email );
      } else {
        sink.addError('Email no es correcto');
      }

    }
  );


  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( password, sink ) {

      if ( password.length >= 6 ) {
        sink.add( password );
      } else {
        sink.addError('Más de 6 caracteres por favor');
      }

    }
  );
  final validarUser = StreamTransformer<String, String>.fromHandlers(
    handleData: ( user, sink ) {

      if ( user.length >0 ) {
        sink.add( user );
      } else {
        sink.addError('Nombre o correo inválidos');
      }

    }
  );
  final validarNombre = StreamTransformer<String, String>.fromHandlers(
    handleData: ( nombre, sink ) {

       Pattern pattern = r'[a-zA-Z]';
      RegExp regExp   = new RegExp(pattern);

      if ( nombre.length >= 3 && regExp.hasMatch(nombre)) {
        sink.add( nombre );
      } else {
        sink.addError('Ingrese un nombre correcto');
      }

    }
  );
  final validarCi = StreamTransformer<String, String>.fromHandlers(
    handleData: ( ci, sink ) {

      Pattern pattern = r'^[0-9]*$';
      RegExp regExp   = new RegExp(pattern);

      if ( ci.length >= 5 && regExp.hasMatch(ci)) {
        sink.add( ci );
      } else {
        sink.addError('Ingrese un ci valido');
      }

    }
  );


}
