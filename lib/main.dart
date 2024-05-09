import 'package:flutter/material.dart';
import 'package:myapp/authentification.dart';  
import 'package:myapp/home.dart';
import 'package:myapp/pages/Gestionaire.dart';
import 'package:myapp/pages/AjouterModifier.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/gestionaire': (context) => const MyGestionaire(title: 'Gestionaire'),
        '/gestionaire/AjouterModifier': (context) => const MyGestionaire(title: 'AjouterModifier'),
        '/home': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
      },
    );
  }
}
