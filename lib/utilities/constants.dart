import 'package:els2020/model/Category.dart';
import 'package:els2020/model/database_helper.dart';
import 'package:flutter/material.dart';

class RaisedButtonWidget extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final String label;

  RaisedButtonWidget({this.label, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      onPressed: onPressed,
      //Navigator.pushNamed(context, '/registered_users');
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
} //RaisedButtonWidget

void createAlertDialog(String message, BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    title: Text('USER'),
    content: Text(message),
    elevation: 24.0,
    backgroundColor: Colors.green,
  );
  showDialog(context: context, builder: (_) => alertDialog);
} //createAlertDialog
