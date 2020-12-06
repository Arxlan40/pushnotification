import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasepushnotifcation/screens/operation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constant.dart';

class showOurTeamReocrd extends StatefulWidget {
      static String id="showOurTeamReocrd";


      final String teamMemberName;
      final String teamMemberNameExperience;
      final String teamMemberDescription;
      final DocumentSnapshot documentSnapshot;
      final String Uid;
      final String images;
      showOurTeamReocrd({@required this.teamMemberName, this.teamMemberNameExperience, this.teamMemberDescription, this.documentSnapshot, this.Uid, this.images});
  @override
  _showOurTeamReocrdState createState() => _showOurTeamReocrdState();
}

class _showOurTeamReocrdState extends State<showOurTeamReocrd> {
  Future<void> deleteNewsData(DocumentSnapshot doc) async {
    await Firestore.instance
        .collection("ourTeamRecord")
        .document(doc.documentID)
        .delete();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(

        // {
        //   Navigator.of(context).push(
        //     new MaterialPageRoute(
        //       //here we are passing the values of the product to the product details page
        //       builder: (context) => new productDetails(stuName: widget.stuName,fName: widget.fatherName,mName: widget.motherName,imgUrl: widget.images,),
        //     ),
        //   );
        // },
        child: Stack(
          children: <Widget>[
             InkWell(
                    onTap: ()
                 {
                     deleteNewsData(widget.documentSnapshot);
                 },
                 child: Icon(Icons.delete,color: KprimaryColor,)),
            Container(
              margin: EdgeInsets.only(left: 30,right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[


                  Card(
                    elevation: 5,
                    child: Container(
                      height: 160,

                      child: Column(

                        children: <Widget>[
                          // Container(
                          //   height: 100,
                          //   width: 100,
                          //   child:  Image.network(
                          //     widget.images,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex:3,
                                child: Column(

                                  children: <Widget>[
                                    SizedBox(height: 20,),
                                    Container(
                                      // height: 70,
                                      // width: 45,
                                        child: CircleAvatar(
                                          radius: 37,
                                          backgroundColor: Colors.red,
                                          child: CircleAvatar(
                                            backgroundColor: KprimaryColor,
                                            radius: 35,
                                            backgroundImage: NetworkImage(widget.images),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex:4,
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 20,),
                                      Container(
                                          height:100,
                                          child: Text(widget.teamMemberDescription,style:GoogleFonts.openSans(),)),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(' -  ${widget.teamMemberName}',style: GoogleFonts.openSans(color: Colors.grey,),),
                                          Text('${widget.teamMemberNameExperience} Year',style: GoogleFonts.openSans(color: Colors.grey,),),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
