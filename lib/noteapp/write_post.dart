import 'package:flutter/material.dart';

import 'model.dart';

//remember that statefulwidget always has two classes untile statelesswidget

class Write extends StatefulWidget {

  //you can access static method using class name ,just like we did in main.dart

  static const routeName = '/write';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return WriteState();
  }
}

class WriteState extends State<Write> {
  //key to recognize our form
  final _formKey = GlobalKey<FormState>();

  Note note = Note();

/*
this controller handles the changes in title and body ,we'll initialize it in initstate method
to initialize it just once ,rather than inside build method
*/
  TextEditingController mytitleController;
  TextEditingController mybodyController;

  //initstate method is called just once,unlike build method
  //if you need to instantiate something just once ,do it here

  @override
  void initState() {
    super.initState();

    //future to get the context of ModalRoute
    Future.delayed(Duration.zero, () {
      setState(() {
        var args = ModalRoute.of(context).settings.arguments;
        Note up_note = args as Note;

        if (up_note != null) {
          mytitleController = TextEditingController(
              text: up_note.title != null ? up_note.title : " ");
          mybodyController = TextEditingController(
              text: up_note.body != null ? up_note.body : " ");
        } else {
          mytitleController = TextEditingController();
          mybodyController = TextEditingController();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    //WillPopScope is to customize the backbutton in appbar according to requirement

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Write Note"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _saveChanges(context);
                })),
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
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: mytitleController,
                          maxLines: null,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                gapPadding: 4),
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
                          //this onChanged method is called whenever something changes in the feild
                          //we have made textediting controller optional here

                          onChanged: (values) {
                            setState(() {
                              note.title = values;
                              print(note.title);
                            });
                          },
                        ),
                      ),

                      //body
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: mybodyController,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              gapPadding: 4,
                            ),
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
                          onChanged: (values) {
                            setState(() {
                              note.body = values;
                            });
                          },
                        ),
                      ),

                      Container(
                        width: 300,
                        height: 50,
                        child: RaisedButton(
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(16),
                              side: BorderSide(color: Colors.blue)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Note note = new Note();
                              note.title = mytitleController.text;
                              note.body = mybodyController.text;
                              //this pop method goes back with the note object initialized from above steps
                              Navigator.pop(context, note);
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Validation Error"),
                              ));
                            }
                          },
                          child: Text(
                            "save your note",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /*if user clicks back button rather than save button then we would like to 
  alert the user if he wants to save changes if not we stay in the same page,
  otherwise go back by taking the data as note object
   */
  _saveChanges(BuildContext previousContext) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Want to save changes?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("cancel")),
              FlatButton(
                onPressed: () {
                  note.title = mytitleController.text;
                  note.body = mybodyController.text;
                  Navigator.pop(context);
                  Navigator.pop(previousContext, note);
                },
                child: Text(
                  "save changes",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }
}
