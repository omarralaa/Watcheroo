import 'package:flutter/material.dart';

class MySliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          'Your Watch Parties',
          style: TextStyle(
            fontFamily: 'Palatino',
            fontSize: 18.5,
            inherit: true,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(-1.5, -1.5),
                color: Colors.black,
              ),
              Shadow(
                offset: Offset(1.5, -1.5),
                color: Colors.black,
              ),
              Shadow(
                offset: Offset(1.5, 1.5),
                color: Colors.black,
              ),
              Shadow(
                offset: Offset(-1.5, 1.5),
                color: Colors.black,
              ),
            ],
          ),
        ),
        background: Image.network(
          'https://i2.wp.com/wallur.com/wp-content/uploads/2016/12/dc-movies-background-11.jpg?fit=1920%2C1080',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
