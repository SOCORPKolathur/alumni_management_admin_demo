
import 'dart:math';
import 'package:alumni_management_admin/Models/Language_Model.dart';
import 'package:alumni_management_admin/utils.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Constant_.dart';

class Acadamic_Year extends StatefulWidget {
  const Acadamic_Year({super.key});

  @override
  State<Acadamic_Year> createState() => _Acadamic_YearState();
}

class _Acadamic_YearState extends State<Acadamic_Year> {

  String currentTab="View";
  TextEditingController academicnameContoller=TextEditingController();

  bool filtervalue=false;
  List datalist = [
    "Edit",
    "Delete",
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.only(left:width/170.75,top: height/54.25),
      child: FadeInRight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(vertical: height/81.375, horizontal: width/170.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KText(
                    text: "Academic Year",
                    style: SafeGoogleFont (
                        'Nunito',
                        fontSize: width / 82.538,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/1.39),
                  child: InkWell(
                    onTap: () async {

                      addItemPopUp();
                    },
                    child: Container(
                      height: height / 16.275,
                      width: width/10.9714,
                      decoration: BoxDecoration(
                        color: Constants().primaryAppColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(1, 2),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child:
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 227.66),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add,color:Colors.white),
                            KText(
                              text: "Add",
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: width / 120.571,
                                color:Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            Container(
              width:width/1.26,
              height:height/12.316666,
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width/455.33,vertical: height/217),
                child: Row(
                  children: [
                    SizedBox(
                      width:width/12.075,
                      child: Row(
                        children: [
                          KText(
                            text: "No.",
                            style:  SafeGoogleFont (
                              'Nunito',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  filtervalue = !filtervalue;
                                });
                              },
                              child: Transform.rotate(
                                angle: filtervalue ? 200 : 0,
                                child: Opacity(
                                  // arrowdown2TvZ (8:2307)
                                  opacity: 0.7,
                                  child: Container(
                                    width: width/153.6,
                                    height: height/73.9,
                                    child: Image.asset(
                                      'assets/images/arrow-down-2.png',
                                      width: width/153.6,
                                      height: height/73.9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(

                      width: width/1.9,
                      child: Row(
                        children: [
                          KText(
                            text: "Name",
                            style:  SafeGoogleFont (
                              'Nunito',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  filtervalue = !filtervalue;
                                });
                              },
                              child: Transform.rotate(
                                angle: filtervalue ? 200 : 0,
                                child: Opacity(
                                  // arrowdown2TvZ (8:2307)
                                  opacity: 0.7,
                                  child: Container(
                                    width: width/153.6,
                                    height: height/73.9,
                                    child: Image.asset(
                                      'assets/images/arrow-down-2.png',
                                      width: width/153.6,
                                      height: height/73.9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width:width/7.588,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          KText(
                            text: "Actions",
                            style:  SafeGoogleFont (
                              'Nunito',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  filtervalue = !filtervalue;
                                });
                              },
                              child: Transform.rotate(
                                angle: filtervalue ? 200 : 0,
                                child: Opacity(
                                  // arrowdown2TvZ (8:2307)
                                  opacity: 0.7,
                                  child: Container(
                                    width: width/153.6,
                                    height: height/73.9,
                                    child: Image.asset(
                                      'assets/images/arrow-down-2.png',
                                      width: width/153.6,
                                      height: height/73.9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
              child: SizedBox(
                width:width/1.26,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("AcademicYear").orderBy("timestamp").snapshots(),
                  builder: (context, snapshot) {

                    if(snapshot.hasData==null){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    if(!snapshot.hasData){
                      return const Center(child: CircularProgressIndicator(),);
                    }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      List<GlobalKey<State<StatefulWidget>>>popMenuKeys = List.generate(snapshot.data!.docs.length, (index) => GlobalKey(),);
                    return SizedBox(
                      height: height/15.850,
                      width: double.infinity,

                      child: Row(

                        children: [
                          SizedBox(
                            width:width/12.075,
                            child:
                            KText(
                              text: (index + 1).toString(),
                              style:  SafeGoogleFont (
                                'Nunito',
                                fontSize:width/105.07,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width/1.9,
                            child:
                            KText(
                              text: snapshot.data!.docs[index]['name'].toString(),
                              style:  SafeGoogleFont (
                                'Nunito',
                                fontSize:width/105.07,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                          ),

                          GestureDetector(
                            onTap: () {
                              Popupmenu(context, popMenuKeys[index], size,snapshot.data!.docs[index]['name'].toString(),snapshot.data!.docs[index].id);
                            },
                            child: SizedBox(
                                key: popMenuKeys[index],
                                width:width/7.588,
                                child: Icon(
                                    Icons.more_horiz)),
                          ),

                        ],
                      ),

                    );
                  },);
                },),
              ),
            )
          ],
        ),
      ),
    );
  }

  viewPopup(Name) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            width: size.width * 0.5,
           height:height/3.695,
           // margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
            decoration: BoxDecoration(
              color: Constants().primaryAppColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1, 2),
                  blurRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                  width: double.infinity,
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/81.375),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Academic Year Details",
                          style:  SafeGoogleFont (
                            'Nunito',
                            fontSize: width/78.3,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: height/16.275,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal:width/227.66),
                              child: Center(
                                child: KText(
                                  text: "CLOSE",
                                  style:  SafeGoogleFont (
                                    'Nunito',
                                    fontSize: width/105.375,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(left:width/61.44),
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.15,
                            child: KText(
                              text: "Name",
                              style: SafeGoogleFont (
                                  'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: width/95.375
                              ),
                            ),
                          ),
                          Text(":"),
                          SizedBox(width: width/68.3),
                          Text(
                            Name.toString(),
                            style: SafeGoogleFont (
                                'Nunito',
                                fontSize: width/105.571
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  editPopUp(Docid,name) {

    setState(() {
      academicnameContoller.text=name;
    });
    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  width:width/2.56,
                  height:height/2.956,
                 // margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      SizedBox(
                        width:width/1.70666,
                        height: height/9.2375,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/81.375),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: "EDIT Item",
                                    style:  SafeGoogleFont (
                                      'Nunito',
                                      fontSize: width/88.3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: width/5.12,),
                                  /*Row(
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          FirebaseFirestore.instance.collection("AcademicYear").doc(Docid).update({
                                            "name":academicnameContoller.text
                                          });
                                          Navigator.pop(context);

                                        },
                                        child: Container(
                                          height: height/16.275,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 2),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal:width/227.66),
                                            child: Center(
                                              child: KText(
                                                text: "UPDATE",
                                                style:  SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: width/105.375,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: width/136.6),
                                      InkWell(
                                        onTap: () async {

                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: height/16.275,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 2),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal:width/227.66),
                                            child: Center(
                                              child: KText(
                                                text: "CANCEL",
                                                style:  SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: width/105.375,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )*/
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                          height: height/14.78,
                          width: width/5.12,
                          margin: EdgeInsets.only(bottom: height/73.9),
                          decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child:
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .allow(RegExp(
                                  "[0-9]")),
                            ],
                            controller:academicnameContoller,
                            decoration: InputDecoration(
                              border:
                              InputBorder
                                  .none,
                              contentPadding: EdgeInsets.only(
                                  bottom:
                                  height/73.9,
                                  top: height/369.5,
                                  left:
                                  width/153.6),
                              counterText:
                              "",
                            ),
                          )),

                      Padding(
                        padding:  EdgeInsets.only(top:height/30.39),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width/5.2925,
                            ),

                            /// Update Button
                            GestureDetector(
                              onTap:(){

                                groupfunction(Docid);
                                Navigator.pop(context);

                              },
                              child: Container(
                                  height: height/18.475,
                                  width: width/12.8,
                                  decoration: BoxDecoration(
                                    color: Color(0xffD60A0B),
                                    borderRadius:
                                    BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: KText(
                                      text: 'Update',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: width/96,
                                        fontWeight:
                                        FontWeight.w600,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: width/76.8,
                            ),

                            ///Cancel Button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  academicnameContoller.clear();
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: height/18.475,
                                  width: width/12.8,
                                  decoration: BoxDecoration(
                                    color: Color(0xff00A0E3),
                                    borderRadius:
                                    BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: KText(
                                      text: 'Cancel',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: width/96,
                                        fontWeight:
                                        FontWeight.w600,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: width/76.8,
                            ),

                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              );
            }
        );
      },
    );
  }

  addItemPopUp() {

    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  width:width/2.56,
                  height:height/2.956,
                  // margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      SizedBox(
                        width:width/1.70666,
                        height: height/9.2375,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/81.375),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: "Add Item",
                                    style:  SafeGoogleFont (
                                      'Nunito',
                                      fontSize: width/88.3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                               SizedBox(width: width/5.12,),
                                  /*   Row(
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          FirebaseFirestore.instance.collection("AcademicYear").doc().set({
                                            "name":academicnameContoller.text,
                                            "timestamp":DateTime.now().millisecondsSinceEpoch
                                          });
                                          setState((){
                                            academicnameContoller.clear();
                                          });
                                          Navigator.pop(context);

                                        },
                                        child: Container(
                                          height: height/16.275,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 2),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal:width/227.66),
                                            child: Center(
                                              child: KText(
                                                text: "Save",
                                                style:  SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: width/105.375,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: width/136.6),
                                      InkWell(
                                        onTap: () async {

                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: height/16.275,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 2),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal:width/227.66),
                                            child: Center(
                                              child: KText(
                                                text: "CANCEL",
                                                style:  SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: width/105.375,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )*/
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                          height: height/14.78,
                          width: width/5.12,
                          margin: EdgeInsets.only(bottom: height/73.9),
                          decoration: BoxDecoration(
                              color: const Color(
                                  0xffDDDEEE),
                              borderRadius:
                              BorderRadius.circular(
                                  3)),
                          child:
                          TextFormField(

                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .allow(RegExp(
                                  "[0-9]")),
                            ],
                            controller:academicnameContoller,
                            decoration: InputDecoration(

                              border:
                              InputBorder
                                  .none,
                              contentPadding: EdgeInsets.only(
                                  bottom:
                                  height/73.9,
                                  top: height/369.5,
                                  left:
                                  width/153.6),
                              counterText:
                              "",
                            ),
                          )),

                      Padding(
                        padding:  EdgeInsets.only(top:height/30.39),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width/5.2925,
                            ),

                            /// Save Button
                            GestureDetector(
                              onTap:(){
                                FirebaseFirestore.instance.collection("AcademicYear").doc().set({
                                  "name":academicnameContoller.text,
                                  "timestamp":DateTime.now().millisecondsSinceEpoch
                                });
                                setState((){
                                  academicnameContoller.clear();
                                });
                                Navigator.pop(context);

                              },
                              child: Container(
                                  height: height/18.475,
                                  width: width/12.8,
                                  decoration: BoxDecoration(
                                    color: Color(0xffD60A0B),
                                    borderRadius:
                                    BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: KText(
                                      text: 'Save',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: width/96,
                                        fontWeight:
                                        FontWeight.w600,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: width/76.8,
                            ),

                            ///Cancel Button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  academicnameContoller.clear();
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: height/18.475,
                                  width: width/12.8,
                                  decoration: BoxDecoration(
                                    color: Color(0xff00A0E3),
                                    borderRadius:
                                    BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: KText(
                                      text: 'Cancel',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: width/96,
                                        fontWeight:
                                        FontWeight.w600,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: width/76.8,
                            ),

                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              );
            }
        );
      },
    );
  }


  static Color randomOpaqueColor() {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
  }


  groupfunction(Docid)async{
    print("Group Function++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
   FirebaseFirestore.instance.collection("AcademicYear").doc(Docid).update({
     "name":academicnameContoller.text
    });
    Color randomColor() {
      Random random = Random();
      return Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0, // Full opacity
      );
    }
  var groupdocument=await FirebaseFirestore.instance.collection("Groups").where("Department",isEqualTo:academicnameContoller.text).get();


  if(groupdocument.docs.length==0){
    var Color=randomOpaqueColor();
    var Department= await FirebaseFirestore.instance.collection("Department").get();
    for(int i=0;i<Department.docs.length;i++){
      FirebaseFirestore.instance.collection("Groups").doc().set({
        "AccademicYear":academicnameContoller.text,
        "Department":Department.docs[i]['name'],
        "Img":"",
        "color":"0x${randomColor().value.toRadixString(16)}"
      });
    }

  }

  setState((){
    academicnameContoller.clear();
  });


  }

  Popupmenu(BuildContext context, key, size,DataName,DocumentID) async {
    print(
        "Popupmenu open-----------------------------------------------------------");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final render = key.currentContext!.findRenderObject() as RenderBox;
    await showMenu(
      color: Color(0xffFFFFFF),
      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(
          render.localToGlobal(Offset.zero).dx,
          render.localToGlobal(Offset.zero).dy + 50,
          double.infinity,
          double.infinity),
      items: datalist
          .map((item) => PopupMenuItem<String>(
        enabled: true,
        onTap: () async {
          if (item == "Edit") {
            editPopUp(DocumentID,DataName);
          }
          else if (item == "Delete") {
            CoolAlert.show(
                context: context,
                type: CoolAlertType
                    .info,
                text: "${DataName} will be deleted",
                title:
                "Delete this Record?",
                width: size.width *
                    0.4,
                backgroundColor:
                Constants()
                    .primaryAppColor
                    .withOpacity(
                    0.8),
                showCancelBtn: true,
                cancelBtnText: 'Cancel',
                cancelBtnTextStyle: SafeGoogleFont (
                    'Nunito',color: Colors.black),
                onConfirmBtnTap:
                    () async {
                  FirebaseFirestore.instance.collection("AcademicYear").doc(DocumentID).delete();

                });
          }
        },
        value: item,
        child: Container(
          height: height / 18.475,
          decoration: BoxDecoration(
              color: item == "Edit"
                  ? Color(0xff5B93FF).withOpacity(0.6)
                  : Color(0xffE71D36).withOpacity(0.6),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item == "Edit"
                  ? Icon(
                Icons.edit,
                color: Colors.white,
                size: 18,
              )
                  : Icon(
                Icons.delete,
                color: Colors.white,
                size: 18,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ))
          .toList(),
    );
  }

}
