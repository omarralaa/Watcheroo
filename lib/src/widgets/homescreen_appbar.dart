import 'package:flutter/material.dart';

class HomeScreenAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final profile = Provider.of<Profile>(context, listen: false).user;
    return SliverAppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        ),
      ],
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 160.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Good Morning',
          style: TextStyle(
            fontSize: 18.5,
            color: Colors.white,
          ),
        ),
        // background: Image.network(
        //   'https://i2.wp.com/wallur.com/wp-content/uploads/2016/12/dc-movies-background-11.jpg?fit=1920%2C1080',
        //   fit: BoxFit.fill,
        // ),
      ),
    );
  }
}
