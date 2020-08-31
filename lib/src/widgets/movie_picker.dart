import 'package:flutter/material.dart';

class MoviePicker extends StatelessWidget {
  final Function submitCallBack;

  MoviePicker(this.submitCallBack);

  final movieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Movie Name',
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
        SizedBox(height: 30),
        TextField(
          controller: movieController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
          ),
          style: TextStyle(fontSize: 18),
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
            onTap: () {
              final movieName = movieController.text;
              print(movieName);
              if (movieName.isEmpty) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('You must enter a movie name'),
                  duration: Duration(milliseconds: 1000),
                ));
              } else {
                submitCallBack(movieName);
              }
            },
          ),
        ),
      ],
    );
  }
}
