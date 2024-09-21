// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secura/services/auth/auth_gate.dart';
import 'package:secura/services/database/database_provider.dart';
import 'package:secura/themes/theme_provider.dart';
// import 'package:secura/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        //theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        //database provider
        ChangeNotifierProvider(create: (context) => DatabaseProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secura',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: AuthGate(),
    );
  }
}
