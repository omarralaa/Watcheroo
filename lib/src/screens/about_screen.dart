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
      body: Container(
        padding: EdgeInsets.all(20),
        child: Text(
          'Application is developed and maintained by Omar Alaa and Yosra Emad.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
