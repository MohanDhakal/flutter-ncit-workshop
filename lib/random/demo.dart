import 'package:flutter/material.dart';
import 'package:start_app/noteapp/model.dart';
import 'package:start_app/noteapp/write_post.dart';

class HomeDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeDemoState();
  }
}

class HomeDemoState extends State<HomeDemo> {
  List noteItems = new List<Note>();
  Note note;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("My ToDo"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          note = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return Write();
          }));
          setState(() {
            noteItems.add(note);
          });
        },
      ),
      body: _getList(),
    );
  }

  Widget _getList() {
    if (noteItems.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (contex, index) {
          note = noteItems[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.body),
          );
        },
        itemCount: noteItems.length,
      );
    } else {
      return Center(child: Text("Please Enter an item"));
    }
  }
}
