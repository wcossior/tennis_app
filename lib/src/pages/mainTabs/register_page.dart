import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/src/blocs/provider.dart';
import 'package:tennis_app/src/blocs/register_bloc.dart';
import 'package:tennis_app/src/providers/user_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Color colorVerde = Color.fromRGBO(174, 185, 127, 1.0);
  Color colorAmarillo = Color.fromRGBO(222, 185, 100, 1.0);

  final Widget tennisIcon = SvgPicture.asset(
    'assets/tennisIcon.svg',
    semanticsLabel: 'Tennisicon',
    color: Colors.white,
    height: 90.0,
  );
  bool noInfoYet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _registerForm(context),
      ],
    ));
  }

  Widget _registerForm(BuildContext context) {
    final bloc = Provider.registerOf(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Crear una cuenta', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 30.0),
                _crearCi(bloc),
                SizedBox(height: 15.0),
                _crearEmail(bloc),
                SizedBox(height: 15.0),
                _crearNombre(bloc),
                SizedBox(height: 15.0),
                _crearPassword(bloc),
                SizedBox(height: 15.0),
                _crearBoton(bloc)
              ],
            ),
          ),
          FlatButton(
            child: Text("¿Ya tienes cuenta? Login"),
            onPressed: () => Navigator.pushReplacementNamed(context, "login"),
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearCi(RegisterBloc bloc) {
    return StreamBuilder(
      stream: bloc.ciStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              icon: Icon(Icons.format_list_numbered_rounded, color: colorVerde),
              hintText: 'Ingrese su ci',
              labelText: 'Ci',
              // counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeCi,
          ),
        );
      },
    );
  }

  Widget _crearEmail(RegisterBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: colorVerde),
              hintText: 'Ingrese su correo',
              labelText: 'Correo electrónico',
              // counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearNombre(RegisterBloc bloc) {
    return StreamBuilder(
      stream: bloc.nombreStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              icon: Icon(Icons.person_outline, color: colorVerde),
              hintText: 'Ingrese su nombre',
              labelText: 'Nombre',
              // counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeNombre,
          ),
        );
      },
    );
  }

  Widget _crearPassword(RegisterBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: colorVerde),
                labelText: 'Contraseña',
                // counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(RegisterBloc bloc) {
    return StreamBuilder(
      stream: bloc.formNewUserValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Registrarse'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: colorVerde,
          textColor: Colors.white,
          onPressed: snapshot.hasData
              ? (!noInfoYet ? () => _register(bloc, context) : null)
              : null,
        );
      },
    );
  }

  _register(RegisterBloc bloc, BuildContext context) async {
    setState(() {
      noInfoYet = true;
    });
    Map info = await userProvider.newUser(
      bloc.ci,
      bloc.email,
      bloc.nombre,
      bloc.password,
    );

    if (info.containsKey("msg")) {
      setState(() {
        noInfoYet = false;
      });
      showAlert(context, info["msg"], bloc);
    }
  }

  showAlert(BuildContext context, String msg, RegisterBloc bloc) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Informacion"),
          content: Text(msg),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                setState(() {
                  noInfoYet = false;
                });
                Navigator.of(context).pop();
                if (msg == "Cuenta creada exitosamente!") {
                  clearData(bloc);
                  Navigator.pushReplacementNamed(context, "login");
                }
              },
            )
          ],
        );
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[colorVerde, colorAmarillo])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.08)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 110.0, left: 20.0, child: circulo),
        Positioned(top: -30.0, left: 90.0, child: circulo),
        Positioned(top: 20.0, right: 20.0, child: circulo),
        Positioned(top: 170.0, right: 100.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              tennisIcon,
              SizedBox(height: 10.0, width: double.infinity),
              Text('Tennis App',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }

  void clearData(RegisterBloc bloc) {
    bloc.changeCi("");
    bloc.changeEmail("");
    bloc.changeNombre("");
    bloc.changePassword("");
  }
}
