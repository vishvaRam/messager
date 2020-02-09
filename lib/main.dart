import 'package:flutter/material.dart';
import 'Screens/Welcome.dart';
import 'Screens/Login.dart';
import 'Screens/Regester.dart';
import 'Screens/Chat.dart';

void main(){
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      initialRoute: Welcome.id,
      routes: {
        Welcome.id : (context)=> Welcome(),
        Login.id : (context)=> Login(),
        Regester.id : (context)=> Regester(),
        Chat.id : (context)=> Chat(),
      },
    );
  }
}
