import 'package:flutter/material.dart';
import 'package:watcherooflutter/src/widgets/main_drawer.dart';

class PreviousPartiesScreen extends StatelessWidget {
  static String routeName = '/previous-parties';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Previously Watched Parties')),
      drawer: MainDrawer(),
    );
  }
}
