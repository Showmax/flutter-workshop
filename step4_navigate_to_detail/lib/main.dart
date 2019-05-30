import 'package:flutter/material.dart';
import 'package:showmax/modules/home/HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Showmax',
      home: HomeScreen(),
    );
  }
}