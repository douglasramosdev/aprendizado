import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home :Scaffold(
        body: CarouselView(
        scrollDirection: Axis.horizontal,
        itemExtent: double.infinity,
        children: List<Widget>.generate(10, (int index) {
          return Center(child: Text('Item $index'));
          }),
        ),
      )
    );
    
    /*return Scaffold(
      body: CarouselView.weighted(
        scrollDirection: Axis.vertical,
        flexWeights: const <int>[1],
        children: List<Widget>.generate(10, (int index){
          return Center(child: Text('Item $index'));
        }),
      ),
    );*/
  }
}