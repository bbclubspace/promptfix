import 'package:promptfix/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomePage();
  }

  void navigateToHomePage() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }
  @override
  Widget build(BuildContext context){
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF202020):Colors.white,
      body:SafeArea(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isDark?
          Image.asset("assets/black-logo.png"):Image.asset("assets/white-logo.png")
        ],
      ))
    );
  }
}