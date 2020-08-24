import 'dart:io';

import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/material.dart';

class FilePicker extends StatefulWidget {
  final Function submitCallBack;

  FilePicker(this.submitCallBack);

  @override
  _FilePickerState createState() => _FilePickerState();
}

class _FilePickerState extends State<FilePicker> {
  File _file;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Pick a File',
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        SizedBox(height: 30),
        _buildSelectButton(),
        SizedBox(
          height: 20,
        ),
        if (_file != null)
          Text(
            'File Picked',
            style: TextStyle(
              color: Colors.green[300],
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(height: 50),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black87,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            child: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 35,
            ),
            onTap: () async {
              if (_file == null) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('You must enter a movie name'),
                  duration: Duration(milliseconds: 1000),
                ));
              } else {
                await widget.submitCallBack(_file);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSelectButton() {
    return Container(
      width: 200,
      height: 50,
      child: RaisedButton(
        color: Colors.purple[300],
        child: Text('Pick'),
        onPressed: () async {
          final file = await fp.FilePicker.getFile(type: fp.FileType.video);
          setState(() {
            _file = file;
          });
        },
      ),
    );
  }
}
