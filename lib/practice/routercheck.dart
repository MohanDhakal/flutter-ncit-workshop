import 'package:flutter/material.dart';

class RouterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HomeScreen();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("selection"),
      ),
      body: SelectionWidget(),
    );
  }
}

class SelectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: Text("pick an option,any option!"),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SelectionScreen();
    }));

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text("$result"),
      ));
  }
}

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("pick an option"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context, 'yep!');
                },
                child: Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context, 'no!');
                },
                child: Text('nope!'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Returning data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, ExtractArguments.routeName,
                arguments: ScreenArguments('Extract Arguments Screen',
                    'This message is extracted in the build method'));
          },
          child: Text("Go to Second"),
          elevation: 5,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Back to First"),
        ),
      ),
    );
  }
}

class ExtractArguments extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
