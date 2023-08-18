
import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context,{required String massage}) {
  final snackBar = SnackBar(
    content: Text(
      massage,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.redAccent,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessMessage(BuildContext context,{required String massage}) {
  final snackBar = SnackBar(
    content: Text(
      massage,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}