// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secura/pages/home_page.dart';
import 'package:secura/pages/login_page.dart';
import 'package:secura/pages/register_page.dart';
import 'package:secura/themes/dark_mode.dart';
import 'package:secura/themes/light_mode.dart';
import 'package:secura/themes/theme_provider.dart';
// import 'package:secura/pages/register_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secura',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: LoginPage(),
    );
  }
}
