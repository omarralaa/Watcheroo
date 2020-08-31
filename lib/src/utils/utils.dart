import 'package:flutter/material.dart';

import '../models/http_exception.dart';

class Utils {
  void showError(err, BuildContext context) {
    final errorMessage = err is HttpException
        ? err.message
        : 'Something wrong happened, try again later.';
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              child: Text('Try Again'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        );
      },
    );
  }

}
