import 'package:flutter/material.dart';
import 'package:flutter_janken/janken.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Janken App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const JankenPage(title: 'Janken App'),
    );
  }
}
