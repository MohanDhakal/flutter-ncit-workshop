import 'package:flutter/material.dart';
import 'package:start_app/practice/demo.dart';
import 'package:start_app/practice/home.dart';
import 'package:start_app/random/homescreen.dart';
import 'package:start_app/practice/write_post.dart';

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



