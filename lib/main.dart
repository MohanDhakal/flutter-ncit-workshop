import 'package:flutter/material.dart';
import 'noteapp/home.dart';
import 'noteapp/write_post.dart';

  /*
  void main() is an entry point of any flutter,without it no flutter app will run
  you can go to other widget or screen by hoving on bellow classes
  for example,click ctrl and hover with your mouse over the Home() class ,it will take you to that class or widget
 */

void main() => runApp(MaterialApp(
      initialRoute: Home.routeName,
      //routes in flutter are simply screen
      //if you ever have done android,routes are similart to activity there.
      routes: {
        Home.routeName: (context) => Home(),
        Write.routeName: (context) => Write()
      },
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
    )
);
