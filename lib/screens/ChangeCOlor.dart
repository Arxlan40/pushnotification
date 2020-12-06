import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constant.dart';

class Changecolor extends StatefulWidget {
  @override
  _ChangecolorState createState() => _ChangecolorState();
}

class _ChangecolorState extends State<Changecolor> {
  ProgressDialog Pd;

  Color _currentColor = Color(0xFF800000);
  final TextEditingController _color = TextEditingController();
  Future uploadRecord() async {

   if (_color.text.isEmpty ==
       _color.text.length >= 6) {
      Toast.show("Mã màu ít nhất 6 ký tự", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else if (_color.text.isEmpty ==
       _color.text.length <= 6) {
      Toast.show("Mã màu không dài hơn 6 ký tự", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
Pd.show();
//use a Async-await function to get the data
     await Firestore.instance.collection("Admin").document('Admin').updateData({
       'Color': "0xFF${_color.text}",

     });
     Toast.show("Đã cập nhật màu thành công", context,
         duration: 3, gravity: Toast.BOTTOM);

     Pd.hide();
    // print(data['img']);
   }
   Pd.hide();

  }

  @override
  Widget build(BuildContext context) {
    Pd = new ProgressDialog(context, type: ProgressDialogType.Normal);

    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: _currentColor,
          title: const Text('ĐỔI MÀU'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: CircleColorPicker(

                  initialColor: _currentColor,
                  onChanged: _onColorChanged,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Bạn có thể chọn mã màu từ vòng tròn màu phía trên và đặt xuống trong Trường văn bản hoặc đặt mã hệ lục phân màu mong muốn của riêng bạn (Chỉ mã hex cho phép 5 chữ số) ví dụ: ff2a15 trong Văn bản",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  alignment: Alignment.centerLeft,
                  decoration: kupperBoxDecorationStyle,
                  height: 55.0,
                  child: TextField(
                  controller: _color,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.openSans(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.color_lens_outlined,
                        color: Kseceondary,
                      ),
                      hintText: 'Mã màu ví dụ ff2a15',
                      hintStyle: kHintTextStyle,
                    ),
                  ),
                ),
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
                  'Tải lên dữ liệu màu',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
  }

  void _onColorChanged(Color color) {
    print(_color);
    setState(() => _currentColor = color);
    //_color.text=_color.toString();
  }

}
