import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreatePartyScreen extends StatelessWidget {
  static const routeName = '/create-party';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Select'),
        onPressed: selectFile,
      ),
    );
  }

  void selectFile() async {
    File file = await FilePicker.getFile(type: FileType.video);

    print(file.uri);
  }
}
