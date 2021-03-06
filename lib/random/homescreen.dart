import 'package:flutter/material.dart';
import 'package:start_app/noteapp/write_post.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<String> auto_generated_list = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Write(),
      debugShowCheckedModeBanner: false,
    );
  }



  void _addToDoItem() {
    setState(() {
      int index = auto_generated_list.length;
      auto_generated_list.add('Item ' + index.toString());
    });
  }


  Widget AutoGeneratedToDO(String title) {
    return (Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ListView.builder(itemBuilder: (context, index) {
          if (index < auto_generated_list.length) {
            return _buildTodoItem(auto_generated_list[index]);
          } else return null;
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addToDoItem();
        },
        tooltip: "Add Item",
        child: Icon(Icons.add),
      ),
    ));
  }


  Widget MyToDos(String title) {
    List<ListItem> items = _generateList();

    return (Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              if (item is HeaderItem) {
                return ListTile(
                  title: Text(
                    item.heading,
                    style: Theme.of(context).textTheme.headline,
                  ),
                );
              } else if (item is MessageItem) {
                return ListTile(
                  title: Text(item.sender),
                  subtitle: Text(item.body),
                );
              } else
                return ListTile(
                  title:Text("No Items"),
                  subtitle: Text("Please click the icon below to add an item"),
                );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addToDoItem();
        },
        tooltip: "Add Item",
        child: Icon(Icons.add),
      ),
    ));
  }

  _generateList() {
    final items = List<ListItem>.generate(
      100,
      (i) => i % 6 == 0
          ? HeaderItem("Heading $i")
          : MessageItem("Sender $i", "Message body $i"),
    );
    return items;
  }

  Widget _buildTodoItem(todoText) {
    return new ListTile(title: new Text(todoText));
  }
}

abstract class ListItem {}

class HeaderItem implements ListItem {
  final String heading;

  HeaderItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
