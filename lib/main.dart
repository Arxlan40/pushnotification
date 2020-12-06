import 'dart:async';
import 'dart:convert';

import 'package:firebasepushnotifcation/screens/HomeScreen.dart';
import 'package:firebasepushnotifcation/screens/Splash.dart';
import 'package:firebasepushnotifcation/screens/constant.dart';
import 'package:firebasepushnotifcation/screens/ourTeamRecordList.dart';
import 'package:firebasepushnotifcation/screens/ourTeamUploadData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Vndiaoc Ứng dụng quản trị',
      theme: ThemeData(
        primaryColor: KprimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
