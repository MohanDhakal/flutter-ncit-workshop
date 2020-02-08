import 'package:flutter/material.dart';
import 'package:start_app/practice/home.dart';

void main() => runApp(
  MaterialApp(
    title: "ToDo App",
    theme: ThemeData(
      primarySwatch: Colors.purple
    ),
    home: Home(),
    debugShowCheckedModeBanner: false,
  )
);



