import 'package:flutter/material.dart';
const KprimaryColor=Color(0xff730f11);
const Kseceondary=Color(0xff000000);
const KTeriratColor=Color(0xffffffff);
const KGrayColr=Color(0xffD3D3D3);

const KpurpelColor=Color(0xff92278F);
const KgreenColor=Color(0xff006838);
const KorangeColor=Color(0xffF15A29);

final kHintTextStyle = TextStyle(
  fontSize: 14,

  color:Color(0xff515C6F),



);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xffffffff),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kupperBoxDecorationStyle = BoxDecoration(
  color: Color(0xffffffff),
  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 4.0,
      offset: Offset(3, 5),
    ),
  ],
);

final kBottomBoxDecorationStyle = BoxDecoration(
  color: Color(0xffffffff),
  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kcenterBoxDecorationStyle = BoxDecoration(
  color: Color(0xffffffff),
  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0)),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);