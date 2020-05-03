import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calisthenics App'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
          tooltip: 'menu',
        ),
      ),
      body: CreateRoutine(),
    );
  }
}

class CreateRoutine extends StatelessWidget {
  @override
  Widget build(BuildContext build) {
    return GestureDetector(
        onTap: () {
          print('tapped!');
        },
        child: Center(
          child: Container(
              height: 50.0,
              width: 150,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.lightBlue[500],
              ),
              child: Center(
                child: Text('Create Routine'),
              )),
        ));
  }
}
