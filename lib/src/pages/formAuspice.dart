import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'manageAuspices_page.dart';

class FormAuspice extends StatefulWidget {
  final FileCallback callbackimg;
  FormAuspice({Key key, this.callbackimg}) : super(key: key);

  @override
  _FormAuspiceState createState() => _FormAuspiceState();
}

class _FormAuspiceState extends State<FormAuspice> {
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
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
      _image != null
          ? Image.asset(
              _image.path,
              height: 150.0,
            )
          : Image(
              image: AssetImage("assets/defimg.jpg"),
              height: 150.0,
            ),
      _image == null
          ? RaisedButton(
              child: Text('Choose File'),
              onPressed: chooseFile,
              color: Colors.cyan,
            )
          : Container(),     
      _image != null
          ? RaisedButton(
              child: Text('Cambiar de imagen'),
              onPressed: clearSelection,
            )
          : Container(),      
    ]);
  }

  Future chooseFile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
      widget.callbackimg(_image);
    });
  }

  clearSelection() {
    imageCache.clear();
    setState(() {
      _image = null;
       widget.callbackimg(null);
    });
  }
  
}
