import 'dart:convert';
import 'dart:html';
import 'dart:html' as html;

import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import '../Constant_.dart';
import '../Gallery_FireCrud/Gallery_firecurd.dart';
import '../Models/Gallery_Image_Model.dart';
import '../Models/Language_Model.dart';
import '../Models/Response_Model.dart';
import '../utils.dart';

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  int pagecount = 0;
  int temp = 1;
  List list = new List<int>.generate(1000, (i) => i + 1);
  List<DocumentSnapshot> documentList = [];
  int documentlength = 0;
  bool addPhoto = false;
  String addphotoDocummentValue = "";

  @override
  void initState() {
    super.initState();
    doclength();
  }

  doclength() async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance.collection("Photos").get();
      final List<DocumentSnapshot> documents = result.docs;

      setState(() {
        documentlength = documents.length;
        pagecount = ((documentlength - 1) ~/ 10) + 1;
      });

      print(pagecount);
    } catch (error) {
      print("Error fetching data: $error");
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Photos").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData == null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 1.35625,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var Value = snapshot.data!.docs[(temp * 10) - 10 + index];

                          return ((temp * 10) - 10 + index >= documentlength)
                              ? SizedBox()
                              : SizedBox(
                            width: width / 1.2418,
                            height: height / 13.4363,
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  width: width / 7.2,
                                  height: height / 14.78,
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: width / 102.4),
                                    child: KText(
                                      text: (index + 1).toString(),
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        color: Color(0xff030229),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  width: width / 4.38857,
                                  height: height / 14.78,
                                  alignment: Alignment.centerLeft,
                                  child: KText(
                                    text: Value['name'].toString(),
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      color: Color(0xff030229),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width / 7.6,
                                  height: height / 14.78,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        addPhoto = true;
                                        addphotoDocummentValue = Value.id;
                                      });
                                      print(addphotoDocummentValue);
                                      print("00000000000000000000000000000000000000000000000000000000000000");
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: width / 15.8, top: height / 73.9, bottom: height / 73.9),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Constants().primaryAppColor,
                                      ),
                                      child: Center(
                                        child: KText(
                                          text: "View Album",
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: height / 13.02,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: pagecount,
                            itemBuilder: (context, index) {
                              if (index >= 0 && index < list.length) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      temp = list[index];
                                    });
                                    print(temp);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    margin: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: temp == list[index] ? Constants().primaryAppColor : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        list[index].toString(),
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontWeight: FontWeight.w700,
                                          color: temp == list[index] ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                // Handle the case when index is out of range
                                return Container();
                              }
                            },
                          ),
                        ),
                        temp > 1
                            ? Padding(
                          padding: const EdgeInsets.only(right: 150.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                temp = temp > 1 ? temp - 1 : 1;
                              });
                            },
                            child: Container(
                              height: height / 16.275,
                              width: width / 11.3833,
                              decoration: BoxDecoration(
                                color: Constants().primaryAppColor,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: Center(
                                child: Text(
                                  "Previous Page",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                            : Container(),
                        Container(
                          child: temp < pagecount
                              ? Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  temp = temp < pagecount ? temp + 1 : pagecount;
                                });
                              },
                              child: Container(
                                height: height / 16.275,
                                width: width / 11.3833,
                                decoration: BoxDecoration(
                                  color: Constants().primaryAppColor,
                                  borderRadius: BorderRadius.circular(80),
                                ),
                                child: Center(
                                  child: Text(
                                    "Next Page ",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                              : Container(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
