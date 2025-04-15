import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
        child: Container(
          margin: EdgeInsets.all(30.0),
          color: Colors.blue,
          child: const Column
          (
            children:[
              MyWidget(),
              ListView.builder(children
              ]
            ),
          )
        ),
      ),
    );
  }
}