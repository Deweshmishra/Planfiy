import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:planify/common/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  void navigateUser() {

    Timer(const Duration(seconds: 2), () {

      var box = Hive.box("userBox");
      print("User Data => ${box.toMap()}");

      bool isLogin = box.get("isLogin") ?? false;

      if(isLogin){
        Navigator.pushReplacementNamed(context, "/dashboard");
      }else{
        Navigator.pushReplacementNamed(context, "/login");
      }

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.bgGradient1,
              AppColors.bgGradient2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // ===== LOGO =====
              Container(
                height: 120,
                width: 120,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.btnGradient1,
                      AppColors.btnGradient2,
                    ],
                  ),
                ),

                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Planify",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
