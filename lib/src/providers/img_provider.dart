import 'package:flutter/material.dart';
import 'package:tennis_app/src/blocs/img_bloc.dart';
export 'package:tennis_app/src/blocs/img_bloc.dart';


class ImgProvider extends InheritedWidget {

  static ImgProvider _instancia;

  factory ImgProvider({ Key key, Widget child }) {

    if ( _instancia == null ) {
      _instancia = new ImgProvider._internal(key: key, child: child );
    }

    return _instancia;

  }

  ImgProvider._internal({ Key key, Widget child })
    : super(key: key, child: child );


  final imgBloc = ImgBloc();

 
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ImgBloc of ( BuildContext context ) {
    return ( context.dependOnInheritedWidgetOfExactType<ImgProvider>()).imgBloc;

  }

}