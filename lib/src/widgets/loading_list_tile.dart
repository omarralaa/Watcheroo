import 'package:flutter/material.dart';

class LoadingListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 70,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          CircleAvatar(backgroundColor: Color.fromRGBO(200, 200, 200, 0.3)),
          SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              buildLoadingContainer(200),
              SizedBox(height: 10),
              buildLoadingContainer(100),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLoadingContainer(double width) {
    return Container(
      width: width,
      height: 15,
      color: Color.fromRGBO(200, 200, 200, 0.3),
    );
  }
}
