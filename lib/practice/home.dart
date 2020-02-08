import 'package:flutter/material.dart';
import 'package:start_app/practice/model.dart';
import 'package:start_app/practice/write_post.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List items = List<Note>();
  Note note;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo Lists"),
      ),
      body: _todolists(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add or Edit",
        onPressed: () async {
          note = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Write(
                        title: "New To Do",
                        note: note,
                      )));
          setState(() {
            items.add(note);
          });
        },
      ),
    );
  }

  Widget _todolists() {
    if (items.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) {
          note = items.elementAt(index);
          return ListTile(
            title: Text(
              note.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(note.body),
            onTap: () async {
              //TODO: edit this to enable editing later
              _promptDialog(index);
            },
          );
        },
        itemCount: items.length,
      );
    } else
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 250, 0, 250),
        child: Center(
          child: Column(
            children: <Widget>[
              Text("No Items"),
              Text(
                "Please click button below to add one!",
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
      );
  }

  void _removeItem(index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _promptDialog(index) {
    note = items[index];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Mark " + note.title + " as done"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("cancel")),
              FlatButton(
                onPressed: () {
                  _removeItem(index);
                  Navigator.pop(context);
                },
                child: Text(
                  "Mark as done",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }
}
