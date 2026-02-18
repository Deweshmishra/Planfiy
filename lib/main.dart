import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planify/features/login/login.dart';
import 'package:planify/features/main_nav_page.dart';
import 'package:planify/features/splash/splash.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Hive Start
  await Hive.initFlutter();

  // Open User Box
  await Hive.openBox("userBox");
  await Hive.openBox("taskBox");
  var box = Hive.box("userBox");
  print("User Data => ${box.toMap()}");
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
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreenPage(),
    '/dashboard': (context) => const MainNavPage(),
        }
        );
  }
}



