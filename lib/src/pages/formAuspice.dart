import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tennis_app/src/providers/img_provider.dart';

class FormAuspice extends StatefulWidget {
  FormAuspice({Key key}) : super(key: key);

  @override
  _FormAuspiceState createState() => _FormAuspiceState();
}

class _FormAuspiceState extends State<FormAuspice> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final imgBloc = ImgProvider.of(context);
    return StreamBuilder(
        stream: imgBloc.imgStream,
        builder: (context, snapshot) {
          File img = snapshot.data;
          return Column(children: [
            SizedBox(
              height: 14.0,
            ),
            Row(
              children: [
                Icon(Icons.image, color: Color.fromRGBO(112, 112, 112, 1.0)),
                SizedBox(
                  width: 15.0,
                ),
                Text('Elige una imagen'),
              ],
            ),
            SizedBox(
              height: 14.0,
            ),
            img != null
                ? Image.asset(
                    img.path,
                    height: 150.0,
                  )
                : Image(
                    image: AssetImage("assets/defimg.jpg"),
                    height: 150.0,
                  ),
            img == null
                ? RaisedButton(
                    child: Text('Choose File'),
                    onPressed: () async => await chooseFile(imgBloc),
                    color: Colors.cyan,
                  )
                : Container(),
            img != null
                ? RaisedButton(
                    child: Text('Cambiar de imagen'),
                    onPressed: ()=>clearSelection(imgBloc),
                  )
                : Container(),
          ]);
        });
  }

  Future chooseFile(ImgBloc imgBloc) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imgBloc.imgSink(File(pickedFile.path));
  
  }

  clearSelection(ImgBloc imgBloc) {
    imageCache.clear();
    imgBloc.imgSink(null);
  }
}
