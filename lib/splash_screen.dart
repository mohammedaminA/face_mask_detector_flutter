import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart' as sp;
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return sp.SplashScreen(
      seconds: 15,
      title: Text(
        'Face Mask Detector',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent),
      ),
      image: Image.asset('assets/splash.png'),
      photoSize: 130,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text('By Mohammedamin Sultan Abdullah', style: TextStyle(color: Colors.white, fontSize: 16),),
      navigateAfterSeconds: HomePage(),
    );
  }
}
