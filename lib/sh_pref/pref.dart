import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  putId();
                },
                child: Text("Save Id"),
              ),
              RaisedButton(
                onPressed: () {
                  getId().then((value){
                    print(value);
                  });

                },
                child: Text("Get Id"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<int> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id')??0;
    return id;
  }

  void putId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', 123);
  }
}
