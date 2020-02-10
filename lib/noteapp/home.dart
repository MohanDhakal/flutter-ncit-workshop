import 'package:flutter/material.dart';
import 'package:start_app/noteapp/model.dart';
import 'package:start_app/noteapp/write_post.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /*
  this list is to hold the note objects,items is an arraylist of type Note which is a
  class i defined in model.dart file*/

  List items = List<Note>();

  /*note object to access the title and body of the note,we'll initialize it later as required*/

  Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo Lists"),
      ),
      body: _todolists(),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          label: Text("Add Note"),
          tooltip: "Add or Edit",
          onPressed: () async {
            //this is named route ,we have defined named router in main.dart,please visit
            //flutter official docs for more about router
            var result = await Navigator.pushNamed(context, Write.routeName);
            this.note = result as Note;
            _addItem(this.note);
          }),
    );
  }

  /*Widget that shows the todolists item added from next Write() route
  * This widget contains ListView.builder and ListTile widget
  * onLongpress you can delete the list item and
  * onTap you can go to edit your existing list item
  * setState is called in order to reflect changes in your existing list item
  * */

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
              /*async is necessary inside this inline function
              to get the value from editing screen
              as we need to get back from the future screen with the data
              we have used async with Navigator in this case.
              todo: visit the below link to know about router more
              https://flutter.dev/docs/development/ui/navigation
             */
              var updatedNote = await Navigator.pushNamed(
                  context, Write.routeName,
                  arguments: items.elementAt(index) as Note);
              _updateNote(updatedNote, index);
            },
            onLongPress: () {
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

  /*adds item into the list*/

  _addItem(Note note) {
    if (note.title == "") {
      setState(() {
        note.title = "No title";
        note.body = "No note written";
        items.add(note);
      });
    } else {
      setState(() {
        items.add(note);
      });
    }
  }

  /*remove item from the list*/

  _removeItem(index) {
    setState(() {
      items.removeAt(index);
    });
  }

/*This is a prompt dialog that is popped up when longpressed the item into the list
* it shows the alertdialog with choices and acts according to the choices set by the user*/

  void _promptDialog(index) {
    note = items[index];
    showDialog(
        context: context,
        builder: (context) {
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

  /*to update the note with the particulate index into the list*/

  void _updateNote(updatedNote, index) {
    setState(() {
      items[index] = updatedNote as Note;
    });
  }
}
