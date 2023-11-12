import 'package:flutter/material.dart';

import 'package:uptick_note_app/utils/database_helper.dart';

import 'screen/home_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;
  // ({String name})  test(){
  //   return (name: )
  // }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
