import 'package:flutter/material.dart';

class Splash_Page extends StatefulWidget {
  const Splash_Page({Key? key}) : super(key: key);

  @override
  State<Splash_Page> createState() => _Splash_PageState();
}

class _Splash_PageState extends State<Splash_Page> {
  TimeToGo() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushNamedAndRemoveUntil(
            context, 'Home_Screen', (route) => false);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    TimeToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Splash_Screen.png"),
          ),
        ),
      ),
    );
  }
}
