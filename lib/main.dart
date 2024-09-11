// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secura/pages/login_page.dart';
// import 'package:secura/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secura',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: LoginPage(),
    );
  }
}
