import 'package:flutter/material.dart';
import 'package:myapp/authentification.dart';  
import 'package:myapp/home.dart';
import 'package:myapp/pages/Gestionaire.dart'; // Update import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KeyPass',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/gestionaire': (context) => const MyGestionaire(title: 'Gestionaire'), // Update route
        '/gestionaire/AjouterModifier': (context) => const MyGestionaire(title: 'Ajouter-Modifier'), // Update route
      },
    );
  }
}
