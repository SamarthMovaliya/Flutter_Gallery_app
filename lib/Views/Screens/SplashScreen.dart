import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Navigateto() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushNamed(context, 'HomeScreen');
      },
    );
  }

  @override
  void initState() {
    Navigateto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade300,
      body: const Center(
        child: Image(
          image: AssetImage(
            'assets/logo/gallery-removebg-preview.png',
          ),
        ),
      ),
    );
  }
}
