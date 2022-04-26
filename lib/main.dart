import 'package:flutter/material.dart';
import 'package:todo_app/screens/note_list.dart';
import 'package:todo_app/screens/note_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          //primarySwatch: Colors.grey
          fontFamily: 'Raleway',
          //textTheme: TextTheme(
            //bodyText2: TextStyle(fontSize: 16, fontFamily: 'Raleway'), //, fontWeight: FontWeight.w300
          //),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Raleway',
      ),
      home: NoteList(),
    );
  }
}