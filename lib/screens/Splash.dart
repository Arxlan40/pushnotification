import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  /// -----------------------------------------
  /// Initstate and timer for splash screen
  /// -----------------------------------------

  void initState() {
    super.initState();

    startTimer();


  }
  void startTimer() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }
  double _height;
  double _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(

        body: Container(
          height: _height,
          width: _width,
          color: Colors.white,
          child: Image.asset(
            'asset/splash.jpg',

          ),
        ));
  }
}

