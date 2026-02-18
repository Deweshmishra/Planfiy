import 'package:flutter/material.dart';
import 'package:planify/features/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Planify',
        debugShowCheckedModeBanner: false,

        routes: {
          '/': (context) => const LoginScreenPage(),
          // 'MainContainer': (context) => const bottomnaviagtion(),
          // 'dashboard': (context) => Dashboard(),
          // 'scanner': (context) =>  Scanner(),
        }
        );
  }
}



