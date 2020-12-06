import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constant.dart';
import 'dart:io';

class BackgroundChange extends StatefulWidget {
  @override
  _BackgroundChangeState createState() => _BackgroundChangeState();
}

class _BackgroundChangeState extends State<BackgroundChange> {
  ProgressDialog Pd;
  File _image1;
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

  Color _currentColor = Color(0xFF800000);
  final TextEditingController _color = TextEditingController();
  Future uploadRecord() async {

   if (_image1 == null) {
      Toast.show("Vui lòng chèn hình ảnh", context,
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
       //   createNotification(imageUrl1);
          await Firestore.instance.collection("Admin").document('Admin').updateData({
            'img': "$imageUrl1",

          });
          Pd.hide();

        });
        Pd.hide();
        print('show');

        Toast.show("Gửi hồ sơ thành công", context,
            duration: 4, gravity: Toast.BOTTOM);

      // print(data['img']);
    }
   // Pd.hide();

  }}

  @override
  Widget build(BuildContext context) {
    Pd = new ProgressDialog(context, type: ProgressDialogType.Normal);

    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: _currentColor,
        title: const Text('THAY ĐỔI HÌNH ẢNH'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                  source: ImageSource.gallery),
                            );
                          },
                          child: _displayChild1()),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text(
                "Chọn Hình ảnh này cẩn thận vì hình ảnh này sẽ là Hình ảnh Trang chủ của ứng dụng VNDIAOC của bạ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20,),

              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: _currentColor,
                onPressed: () async {
                  await uploadRecord();

                },
//
                child: Text(
                  'Tải lên hình ảnh',
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
