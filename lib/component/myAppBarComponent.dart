



import 'package:flutter/material.dart';

AppBar myAppBarComponent(BuildContext context, String title) {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: Text(title, style: TextStyle(color: Colors.black),),
    backgroundColor: Colors.white,
    centerTitle: true,
  );
}