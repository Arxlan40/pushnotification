import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasepushnotifcation/screens/constant.dart';
import 'package:firebasepushnotifcation/screens/operation.dart';
import 'package:firebasepushnotifcation/screens/showOurTeamRecod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:toast/toast.dart';



class PushNotification extends StatefulWidget {

  static String id = "ourTeamUploadData";
  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  /// push Notifcation

  final String serverToken = 'AAAA_j9Xj4c:APA91bHGn4g_TloYzxdy6LTJHr5bmpbCuPQ-2SZTtqYvv5A0iVOf3Ku6n4P92GhlAEtW1DAp1ufum04lEQYN0SXduLxp9Oc_r9NykSNgRmPJMJYFUB2KxaUpvrOscLLcB0PxUe17B6Er';


  ///notification creation function
  Future<http.Response> createNotification(String imgurl) async {
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },

      body: jsonEncode(
        <String, dynamic>{

          'notification': <String, dynamic>{
            'body': '${_teamMemberExperience.text}',
            'title': '${_teamMemberName.text}',
            "image": '$imgurl',
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'link': '${_teamMemberNameDescription.text}'
          },
          'to' : "/topics/all",
        },
      ),
    );
    Pd.hide();

  }



  ///init the firebase-notification-service
  @override
  void initState() {
    //PushNotificationService().initialise(context);

    // TODO: implement initState
    super.initState();
  }
  ProgressDialog Pd;

  void _selectImage(
    Future<File> pickImage,
  ) async {
    File tempImg = await pickImage;
    setState(() => _image1 = tempImg);
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  File _image1;

  final TextEditingController _teamMemberName = TextEditingController();
  final TextEditingController _teamMemberExperience = TextEditingController();
  final TextEditingController _teamMemberNameDescription =
      TextEditingController();
  Future uploadRecord() async {
     if (_teamMemberName.text.isEmpty ==
        _teamMemberName.text.length >= 3) {
      Toast.show("Vui lòng nhập ít nhất 3 ký tự cho tiêu đề", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else if (_teamMemberName.text.isEmpty ==
        _teamMemberName.text.length <= 15) {
      Toast.show("Tiêu đề không dài hơn 15 ký tự", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else if (_teamMemberExperience.text.isEmpty ==
        _teamMemberExperience.text.length >= 5) {
      Toast.show("Vui lòng nhập ít nhất 5 ký tự cho nội dung Thông báo", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else if (_teamMemberExperience.text.isEmpty ==
        _teamMemberExperience.text.length <= 200) {
      Toast.show("Nội dung thông báo không dài hơn 200 ký tự", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else if (_teamMemberNameDescription.text.isEmpty ==
        _teamMemberNameDescription.text.length >= 10) {
      Toast.show("Vui lòng nhập ít nhất 10 ký tự cho liên kết", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else if (_teamMemberName.text.isEmpty ==
        _teamMemberName.text.length <= 200) {
      Toast.show("Liên kết web không dài hơn 200 ký tự", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {

      String imageUrl1;
      if (_image1 != null){
        Pd.show();

        final FirebaseStorage storage = FirebaseStorage.instance;
      final String picture1 =
          "1${DateTime.now().millisecondsSinceEpoch.toString()}.png";
      StorageUploadTask task1 = storage.ref().child(picture1).putFile(_image1);

      StorageTaskSnapshot snapshot1 =
          await task1.onComplete.then((snapshot) => snapshot);
      task1.onComplete.then((snapshot3) async {
        imageUrl1 = await snapshot1.ref.getDownloadURL();
        print(imageUrl1);
        createNotification(imageUrl1);

       });
      Pd.hide();
      print('show');

      Toast.show("Gửi hồ sơ thành công", context,
          duration: 4, gravity: Toast.BOTTOM);

      }
      else{
        Pd.show();

        print('else');
        createNotification("");
        Pd.hide();
        Toast.show("Gửi hồ sơ thành công", context,
            duration: 4, gravity: Toast.BOTTOM);

      }
    //  Pd.hide();
// Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) {
      //       return adminDashBord();
      //     },
      //   ),
      //   (r) => false,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    Pd = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      appBar: AppBar(
        // leading: InkWell(
        //     onTap: () {
        //       // Navigator.pop(context);
        //     },
        //     child: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          'THÔNG BÁO PUSH',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(100.0, 8.0, 100.0, 8.0),
                      child: OutlineButton(
                          borderSide: BorderSide(color: Colors.grey),
                          onPressed: () {
                            _selectImage(
                              ImagePicker.pickImage(
                                maxWidth: 500,
                                  maxHeight:1000,
                                  source: ImageSource.gallery),
                            );
                          },
                          child: _displayChild1()),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: kupperBoxDecorationStyle,
                height: 55.0,
                child: TextField(
                  controller: _teamMemberName,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.openSans(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.title,
                      color: Kseceondary,
                    ),
                    hintText: 'Tiêu đề của thông báo đẩy',
                    hintStyle: kHintTextStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: kupperBoxDecorationStyle,
                height: 55.0,
                child: TextField(
                  controller: _teamMemberExperience,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.openSans(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Kseceondary,
                    ),
                    hintText: 'Nội dung thông báo đẩy',
                    hintStyle: kHintTextStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: kupperBoxDecorationStyle,
                height: 55.0,
                child: TextField(
                  controller: _teamMemberNameDescription,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 2,
                  style: GoogleFonts.openSans(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.web,
                      color: Kseceondary,
                    ),
                    hintText: 'Nhập liên kết Trang web để mở khi nhấp vào Thông báo',
                    hintStyle: kHintTextStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: KprimaryColor,
                onPressed: () async {
                 await uploadRecord();

                },
//
                child: Text(
                  'Gửi thông báo',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

