import 'package:firebasepushnotifcation/screens/ChangeCOlor.dart';
import 'package:firebasepushnotifcation/screens/ourTeamUploadData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ChangeBackground.dart';
class HomePage extends StatelessWidget {
  String title;
  String type;

  HomePage({this.title, this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF800000),
          elevation: 5,
          centerTitle: true,
          title: Text(
            "Vndiaoc bảng quản trị",
            style: TextStyle(
                fontSize: 18, fontFamily: "sans", color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.to(PushNotification());
                },
                child: Container(
                  height: 60,
                  width: 230,
                  child: Card(
                    color: Color(0xFF800000),
                    child: Center(
                      child: Text(
                        "THÔNG BÁO PUSH",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "sans",
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(Changecolor());

                },
                child: Container(
                  height: 60,
                  width: 230,
                  child: Card(
                    color: Color(0xFF800000),
                    child: Center(
                      child: Text(
                        "ĐỔI MÀU",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "sans",
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(BackgroundChange());

                },
                child: Container(
                  height: 60,
                  width: 230,
                  child: Card(
                    color: Color(0xFF800000),
                    child: Center(
                      child: Text(
                        "THAY ĐỔI HÌNH ẢNH NỀN TẢNG",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "sans",
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
