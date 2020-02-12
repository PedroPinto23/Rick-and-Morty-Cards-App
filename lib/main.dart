import 'package:flutter/material.dart';
import 'src/HomePage.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Rick and Morty Cards',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.yellowAccent),
    ),
  );
}
