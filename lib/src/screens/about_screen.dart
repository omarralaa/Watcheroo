import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      drawer: MainDrawer(),
      body:  Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'This application is a produced by White Mirror company all copyrights are reserved.\n\nOmar Alaa & Yosra Emad',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
    );
  }
}
