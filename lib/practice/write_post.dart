import 'package:flutter/material.dart';

import 'model.dart';

class Write extends StatefulWidget {
  Write({Key key, this.title, this.note}) : super(key: key);

  final String title;
  final Note note;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return WriteState();
  }
}

class WriteState extends State<Write> {


  final _formKey = GlobalKey<FormState>();

  Note note = Note();

  final mytitleController = TextEditingController();
  final mybodyController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        child: TextFormField(
                          controller: mytitleController,
                          decoration: InputDecoration(
                            labelText: "Title",
                            labelStyle: TextStyle(
                              fontSize: 20,
                            ),
                            errorMaxLines: 2,
                            hintText: "Please Enter the Title",
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.black12),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter some text";
                            } else
                              return null;
                          },
                        ),
                      ),
                    ),

                    //body
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: mybodyController,
                          decoration: InputDecoration(
                            labelText: "Notes",
                            labelStyle: TextStyle(
                              fontSize: 20,
                            ),
                            errorMaxLines: 2,
                            hintText: "Please Enter the Message",
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black12,
                            ),
                          ),
                          maxLines: 10,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter some text";
                            } else
                              return null;
                          },
                        ),
                      ),
                    ),

                    RaisedButton(
                      color: Colors.deepPurpleAccent,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Note note = new Note();
                          note.title = mytitleController.text;
                          note.body = mybodyController.text;
                          Navigator.pop(context, note);
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Validation Error"),
                          ));
                        }
                      },
                      child: Text(
                        "save",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mytitleController.dispose();
    mybodyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mytitleController.addListener(_updateValues);
  }

  _updateValues() {
    setState(() {
      note.title = mytitleController.text;
      note.body = mybodyController.text;
    });
  }
}
