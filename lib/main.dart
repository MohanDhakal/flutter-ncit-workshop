import 'package:flutter/material.dart';
import 'package:start_app/practice/routercheck.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/second': (context) => SecondScreen(),
        ExtractArguments.routeName: (context) => ExtractArguments(),
      },
      title: "Router Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    ));
