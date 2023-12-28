import 'dart:convert';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:show_up_animation/show_up_animation.dart';
import "package:http/http.dart" as http;
import '../Constant_.dart';
import '../Models/Language_Model.dart';
import '../app/modules/home/controllers/home_controller.dart';
import '../utils.dart';

class Message_Screen extends StatefulWidget {
  const Message_Screen({super.key});

  @override
  State<Message_Screen> createState() => _Message_ScreenState();
}

class _Message_ScreenState extends State<Message_Screen>
    with SingleTickerProviderStateMixin {
  var expand = "";
  var expand2 = "";
  var acadamicYear = "";
  var departmentName = "";

  var select;
  bool activeStatus = false;
  String name = "";
  String UserImg = "";
  String usertoken = "";

  final TextEditingController message = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final homecontroller = Get.put(HomeController());
  TabController? tabController;
  int selectTabIndex = 0;

  String SerachValue = "";

  var colorValue;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return FadeInRight(
      child: Column(
        children: [
          SizedBox(
            height: height / 65.7,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width / 3.415,
                height: height / 1.095,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 43.4,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width / 170.75, right: width / 170.75),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Message',
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: width / 82.538,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff030229),
                            ),
                          ),
                          Container(
                            height: height / 21.7,
                            width: width / 45.5333,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xff605BFF)),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 43.4,
                    ),
                    Container(
                      height: height / 16.275,
                      width: width / 3.5947,
                      decoration: BoxDecoration(
                          color: Color(0xffF7F7F8),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: _searchController,
                        style: SafeGoogleFont(
                          'Nunito',
                          fontSize: width / 113.833,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff8B8395),
                        ),
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.search, color: Color(0xff8B8395)),
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: SafeGoogleFont(
                            'Nunito',
                            fontSize: width / 113.833,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff030229),
                          ),
                          contentPadding: EdgeInsets.only(
                              bottom: height / 65.1, top: height / 65.1),
                        ),
                        onChanged: (value) {
                          setState(() {
                            SerachValue = value;
                          });
                          print(SerachValue);
                          print("Serach___________________________");
                        },
                      ),
                    ),
                    SizedBox(
                      height: height / 43.4,
                    ),
                    Center(
                      child: Container(
                        height: height / 13.02,
                        width: width / 3.415,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TabBar(
                          controller: tabController,
                          labelColor: Colors.indigo,
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Constants().primaryAppColor,
                          indicatorPadding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          labelPadding: const EdgeInsets.all(0),
                          splashBorderRadius: BorderRadius.zero,
                          splashFactory: NoSplash.splashFactory,
                          labelStyle: GoogleFonts.openSans(
                            fontSize: width / 91.0666,
                            fontWeight: FontWeight.w800,
                          ),
                          unselectedLabelStyle: GoogleFonts.openSans(
                            fontSize: width / 97.5714,
                            fontWeight: FontWeight.w600,
                          ),
                          onTap: (index) {
                            setState(() {
                              selectTabIndex = index;
                            });
                            if(selectTabIndex==0){
                              setState(() {
                                expand2="";
                              });
                            }
                            if(selectTabIndex!=0){
                              setState(() {
                                expand="";
                              });
                            }
                          },
                          tabs: [
                            Tab(
                              child: KText(
                                  text: "Personal",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: width / 97.5714,
                                    fontWeight: FontWeight.w700,
                                    color: selectTabIndex == 0
                                        ? Color(0xff605BFF)
                                        : Color(0xffD6D6D6),
                                  )),
                            ),

                            Tab(
                              child: KText(
                                  text: "Groups",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: width / 97.5714,
                                    fontWeight: FontWeight.w700,
                                    color: selectTabIndex == 1
                                        ? Color(0xff605BFF)
                                        : Color(0xffD6D6D6),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 43.4,
                    ),
                    SizedBox(
                      height: height / 1.6275,
                      width: width / 3.415,
                      child: TabBarView(
                        controller: tabController,
                        children: [

                           StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("Users").
                            orderBy('timestamp',descending: true).snapshots(),
                            builder: (context, snapshot){
                              if(snapshot.hasData==null){
                                return Center(
                                    child: SizedBox(
                                      height: height / 5.06,
                                      width: width / 2.61,
                                      child: Lottie.asset(
                                          "assets/Loading.json"),
                                    ));
                              }
                              if(!snapshot.hasData){
                                return Center(
                                    child: SizedBox(
                                      height: height / 5.06,
                                      width: width / 2.61,
                                      child: Lottie.asset(
                                          "assets/Loading.json"),
                                    ));
                              }

                              return
                                ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    if(SerachValue!=""){

                                     if(snapshot.data!.docs[index]['Name'].toString().toLowerCase().
                                     contains(SerachValue.toLowerCase().toString())||
                                         snapshot.data!.docs[index]['Phone'].toString().toLowerCase().
                                         contains(SerachValue.toLowerCase().toString())

                                     ){
                                       return
                                         Padding(
                                           padding:  EdgeInsets.only(

                                               left:width/653 ,
                                               right:width/653 ,
                                               top:height/328.5 ,
                                               bottom:height/328.5
                                           ),
                                           child: Container(
                                             margin: EdgeInsets.only(left:  width/273.2,right: width/273.2),
                                             decoration: BoxDecoration(
                                                 color: select==index?Color(0xffF7F7FF):Colors.transparent,
                                                 border: Border(
                                                     bottom: BorderSide(color: Colors.grey.shade300)
                                                 )
                                             ),
                                             child: ListTile(
                                               onTap: (){
                                                 ischatfuntion(snapshot.data!.docs[index].id);
                                                 setState(() {
                                                   select=index;
                                                   expand= snapshot.data!.docs[index].id;
                                                   name=snapshot.data!.docs[index]['Name'];
                                                   usertoken=snapshot.data!.docs[index]['Token'];
                                                   UserImg=snapshot.data!.docs[index]['UserImg'];
                                                   activeStatus=snapshot.data!.docs[index]['Active'];
                                                 });
                                               },
                                               leading:
                                               Container(
                                                 height: height/20.9,
                                                 width: width/44.5333,
                                                 decoration: BoxDecoration(
                                                     color: Color(0xffDFDEFF),
                                                     borderRadius: BorderRadius.circular(100),
                                                     image: DecorationImage(
                                                         fit: BoxFit.cover,
                                                         image: NetworkImage(snapshot.data!.docs[index]["UserImg"])
                                                     )
                                                 ),
                                               ),
                                               title: KText(text:snapshot.data!.docs[index]['Name'].toString(),style:
                                               SafeGoogleFont (
                                                 'Nunito',
                                                 fontSize: width/113.833,
                                                 fontWeight: FontWeight.w700,
                                                 color: Color(0xff030229),
                                               ),),
                                               subtitle:
                                               KText(text:"${snapshot.data!.docs[index]['class'].toString()} ${snapshot.data!.docs[index]['subjectStream'].toString()} Batch",
                                                 style: SafeGoogleFont (
                                                   'Nunito',
                                                   fontSize: width/113.833,
                                                   fontWeight: FontWeight.w700,
                                                   color: Color(0xff68677F),
                                                 ),) ,
                                               // trailing:  KText(text:"1 min ago",
                                               //   style: SafeGoogleFont (
                                               //     'Nunito',
                                               //     fontSize: width/113.833,
                                               //     fontWeight: FontWeight.w700,
                                               //     color: Color(0xff68677F),
                                               //   ),) ,
                                             ),
                                           ),
                                         );
                                     }
                                    }
                                    else if(SerachValue==""){
                                      return
                                        Padding(
                                          padding:  EdgeInsets.only(

                                              left:width/653 ,
                                              right:width/653 ,
                                              top:height/328.5 ,
                                              bottom:height/328.5
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(left:  width/273.2,right: width/273.2),
                                            decoration: BoxDecoration(
                                                color: select==index?Color(0xffF7F7FF):Colors.transparent,
                                                border: Border(
                                                    bottom: BorderSide(color: Colors.grey.shade300)
                                                )
                                            ),
                                            child: ListTile(
                                              onTap: (){
                                                ischatfuntion(snapshot.data!.docs[index].id);
                                                setState(() {
                                                  select=index;
                                                  expand= snapshot.data!.docs[index].id;
                                                  name=snapshot.data!.docs[index]['Name'];
                                                  usertoken=snapshot.data!.docs[index]['Token'];
                                                  UserImg=snapshot.data!.docs[index]['UserImg'];
                                                  activeStatus=snapshot.data!.docs[index]['Active'];
                                                });
                                              },
                                              leading:
                                              Container(
                                                height: height/20.9,
                                                width: width/44.5333,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffDFDEFF),
                                                    borderRadius: BorderRadius.circular(100),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(snapshot.data!.docs[index]["UserImg"])
                                                  )
                                                ),
                                              ),
                                              title: KText(text:snapshot.data!.docs[index]['Name'].toString(),style:
                                              SafeGoogleFont (
                                                'Nunito',
                                                fontSize: width/113.833,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff030229),
                                              ),),
                                              subtitle:
                                              KText(text:"${snapshot.data!.docs[index]['class'].toString()} ${snapshot.data!.docs[index]['subjectStream'].toString()} Batch",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: width/113.833,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff68677F),
                                                ),) ,
                                              // trailing:  KText(text:"1 min ago",
                                              //   style: SafeGoogleFont (
                                              //     'Nunito',
                                              //     fontSize: width/113.833,
                                              //     fontWeight: FontWeight.w700,
                                              //     color: Color(0xff68677F),
                                              //   ),) ,
                                            ),
                                          ),
                                        );
                                    }

                                  },);

                            },
                          ),

                           StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("Groups").snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData==null){
                                return Center(
                                    child: SizedBox(
                                      height: height / 5.06,
                                      width: width / 2.61,
                                      child: Lottie.asset(
                                          "assets/Loading.json"),
                                    ));
                              }
                              if(!snapshot.hasData){
                                return Center(
                                    child: SizedBox(
                                      height: height / 5.06,
                                      width: width / 2.61,
                                      child: Lottie.asset(
                                          "assets/Loading.json"),
                                    ));
                              }
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: width / 653,
                                        right: width / 653,
                                        top: height / 328.5,
                                        bottom: height / 328.5),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: width / 273.2,
                                          right: width / 273.2),
                                      decoration: BoxDecoration(
                                          color: select == index
                                              ? Color(0xffF7F7FF)
                                              : Colors.transparent,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey.shade300))),
                                      child: ListTile(
                                        onTap: () {
                                          setState(() {
                                            expand2 = snapshot.data!.docs[index].id;
                                            colorValue=int.parse(snapshot.data!.docs[index]['color'].toString());
                                            departmentName="${snapshot.data!.docs[index]['Department']}";
                                               acadamicYear= "${snapshot.data!.docs[index]['AccademicYear']}";
                                          });
                                        },
                                        leading:
                                        Container(
                                          height: height / 20.9,
                                          width: width / 44.5333,
                                          decoration: BoxDecoration(
                                              color: Color(int.parse(snapshot.data!.docs[index]["color"].toString())),
                                              borderRadius:
                                              BorderRadius.circular(100),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot.data!.docs[index]["Img"]))),
                                          child:
                                          Center(
                                            child: Text(
                                                snapshot.data!.docs[index]["Img"]==""?
                                                groupNameTextfunc(snapshot.data!.docs[index]['Department'].toString()).toString():"",
                                              style: SafeGoogleFont(
                                                'Nunito',
                                                fontSize: width / 113.833,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: KText(
                                          text:
                                          snapshot.data!.docs[index]['Department'].toString(),
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: width / 113.833,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff030229),
                                          ),
                                        ),
                                        subtitle: KText(
                                          text:
                                          "${snapshot.data!.docs[index]['AccademicYear'].toString()}",
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: width / 113.833,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff68677F),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width / 273.2,
              ),
              expand != ""
                  ? ShowUpAnimation(
                      animationDuration: Duration(seconds: 1),
                      direction: Direction.horizontal,
                      curve: Curves.linear,
                      child: Container(
                        width: width / 1.95,
                        height: height / 1.095,
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: height / 1.095,
                              child: Column(
                                children: [
                                  Container(
                                    height: height / 10.85,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 136.6,
                                        ),
                                        Container(
                                          height: height / 20.9,
                                          width: width / 44.5333,
                                          decoration: BoxDecoration(
                                              color: Color(0xffDFDEFF),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(UserImg))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height / 81.375,
                                              horizontal: width / 170.75),
                                          child: Column(
                                            children: [
                                              KText(
                                                text: name.toString(),
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  fontSize: width / 85.375,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff030229),
                                                ),
                                              ),
                                              KText(
                                                text:
                                                    activeStatus ? "Online" : "",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  fontSize: width / 113.833,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff030229),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("Users").doc(expand).collection("Messages").
                                    orderBy('timestamp',)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Expanded(
                                        child: SingleChildScrollView(
                                          reverse: true,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                margin: EdgeInsets.only(
                                                    bottom: height / 25.7,
                                                    left: width / 136.6,
                                                    right: width / 136.6),
                                                child:
                                                    snapshot.data!.docs[index]
                                                                ["From"] ==
                                                            "Admin"
                                                        ? GestureDetector(
                                                            onTap: () {

                                                                 showdialog(snapshot.data!.docs[index].id,expand);

                                                            },
                                                            child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          right: width /
                                                                              54.64),
                                                                      child:
                                                                          Container(
                                                                        padding: EdgeInsets.only(
                                                                            left: width /
                                                                                136.6,
                                                                            right: width /
                                                                                130.6,
                                                                            top: height /
                                                                                65.7,
                                                                            bottom:
                                                                                height / 65.7),
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                height / 105.7),
                                                                        decoration: BoxDecoration(
                                                                            color: Color(0xff5B93FF),
                                                                            borderRadius: BorderRadius.only(
                                                                              topLeft:
                                                                                  Radius.circular(8),
                                                                              topRight:
                                                                                  Radius.circular(8),
                                                                              bottomLeft:
                                                                                  Radius.circular(8),
                                                                            )),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [
                                                                            KText(
                                                                              text:
                                                                                  snapshot.data!.docs[index]["Message"].toString(),
                                                                              style: SafeGoogleFont('Nunito',
                                                                                  fontSize: width / 97.5714,
                                                                                  fontWeight: FontWeight.w700,
                                                                                  color: Colors.white),
                                                                            ),
                                                                            KText(
                                                                              text:
                                                                                  snapshot.data!.docs[index]["time"].toString(),
                                                                              style: SafeGoogleFont('Nunito',
                                                                                  fontSize: width / 136.6,
                                                                                  fontWeight: FontWeight.w700,
                                                                                  color: Colors.white),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          height /
                                                                              20.9,
                                                                      width: width /
                                                                          44.5333,
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xffDFDEFF),
                                                                          borderRadius: BorderRadius.circular(100),
                                                                        image: DecorationImage(
                                                                          fit: BoxFit.cover,
                                                                          image: NetworkImage(UserImg)
                                                                        )

                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                          )
                                                        : GestureDetector(

                                                         onTap: (){
                                                           showdialog(snapshot.data!.docs[index].id,expand);

                                                         },
                                                          child: Align(
                                                              alignment:
                                                                  Alignment.topLeft,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: width /
                                                                            54.64),
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.only(
                                                                          left: width /
                                                                              130.6,
                                                                          right: width /
                                                                              136.6,
                                                                          top: height /
                                                                              65.7,
                                                                          bottom: height /
                                                                              65.7),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              color: Color(0xff5B93FF).withOpacity(
                                                                                  0.8),
                                                                              borderRadius:
                                                                                  BorderRadius.only(
                                                                                topLeft:
                                                                                    Radius.circular(8),
                                                                                topRight:
                                                                                    Radius.circular(8),
                                                                                bottomRight:
                                                                                    Radius.circular(8),
                                                                              )),
                                                                      margin: EdgeInsets.only(
                                                                          bottom: height /
                                                                              105.7),
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceAround,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .end,
                                                                        children: [
                                                                          KText(
                                                                            text: snapshot
                                                                                .data!
                                                                                .docs[index]["Message"]
                                                                                .toString(),
                                                                            style:
                                                                                SafeGoogleFont(
                                                                              'Nunito',
                                                                              fontSize:
                                                                                  width / 97.5714,
                                                                              fontWeight:
                                                                                  FontWeight.w700,
                                                                              color:
                                                                                  Colors.white,
                                                                            ),
                                                                          ),
                                                                          KText(
                                                                            text: snapshot
                                                                                .data!
                                                                                .docs[index]["time"]
                                                                                .toString(),
                                                                            style:
                                                                                SafeGoogleFont(
                                                                              'Nunito',
                                                                              fontSize:
                                                                                  width / 136.6,
                                                                              fontWeight:
                                                                                  FontWeight.w700,
                                                                              color:
                                                                                  Colors.white,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: height /
                                                                        20.9,
                                                                    width: width /
                                                                        44.5333,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xffDFDEFF),
                                                                        image: DecorationImage(fit: BoxFit.cover,image: NetworkImage(UserImg)),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                100),),

                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                        ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: height / 13.14,
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFFFFF),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 0.5,
                                            blurRadius: 0.5)
                                      ],
                                      borderRadius: BorderRadius.circular(5)),
                                  margin: EdgeInsets.only(
                                      left: width / 136.6,
                                      right: width / 136.6,
                                      bottom: height / 65.7),
                                  child: TextField(
                                    controller: message,
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: width / 97.5714,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff7D7D7E),
                                    ),
                                    onTap: () {},
                                    onSubmitted: (_) {
                                      chatfuntion();
                                      message.clear();
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width / 136.6,
                                              vertical: height / 65.1),
                                          child: Container(
                                            height: 1,
                                            width: 1,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/paperclip.png"))),
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Image.asset(
                                              "assets/images/send icon.png"),
                                          onPressed: () {
                                            chatfuntion();
                                            message.clear();
                                          },
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: width / 68.3,
                                            top: height / 32.85,
                                            bottom: height / 43.8),
                                        border: InputBorder.none,
                                        hintText: "Type your message",
                                        hintStyle: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width / 97.5714,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff7D7D7E),
                                        )),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ):

              expand2!=""?ShowUpAnimation(
                animationDuration: Duration(seconds: 1),
                direction: Direction.horizontal,
                curve: Curves.linear,
                child: Container(
                  width: width / 1.95,
                  height: height / 1.095,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: height / 1.095,
                        child: Column(
                          children: [
                            Container(
                              height: height / 10.85,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width / 136.6,
                                  ),
                                  Container(
                                    height: height / 20.9,
                                    width: width / 44.5333,
                                    decoration: BoxDecoration(
                                        color: Color(colorValue),
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(UserImg)),
                                    ),
                                    child:Center(
                                      child: Text(
                                        UserImg==""?
                                        groupNameTextfunc(departmentName.toString()).toString():"",
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width / 113.833,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height / 81.375,
                                        horizontal: width / 170.75),
                                    child: Column(
                                      children: [
                                        KText(
                                          text: "${departmentName.toString()}-${acadamicYear.toString()}",
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: width / 85.375,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff030229),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection("Groups").doc(expand2).collection("Messages").orderBy('timestamp',)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Expanded(
                                  child: SingleChildScrollView(
                                    reverse: true,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  15)),
                                          margin: EdgeInsets.only(
                                              bottom: height / 25.7,
                                              left: width / 136.6,
                                              right: width / 136.6),
                                          child:
                                          snapshot.data!.docs[index]
                                          ["From"] == "Admin"
                                              ? GestureDetector(
                                            onTap: () {
                                              Groupshowdialog(snapshot.data!.docs[index].id,expand2);

                                            },
                                            child: Align(
                                                alignment:
                                                Alignment
                                                    .topRight,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .end,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: width /
                                                              54.64),
                                                      child:
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: width /
                                                                136.6,
                                                            right: width /
                                                                130.6,
                                                            top: height /
                                                                65.7,
                                                            bottom:
                                                            height / 65.7),
                                                        margin: EdgeInsets.only(
                                                            bottom:
                                                            height / 105.7),
                                                        decoration: BoxDecoration(
                                                            color: Color(0xff5B93FF),
                                                            borderRadius: BorderRadius.only(
                                                              topLeft:
                                                              Radius.circular(8),
                                                              topRight:
                                                              Radius.circular(8),
                                                              bottomLeft:
                                                              Radius.circular(8),
                                                            )),
                                                        child:
                                                        Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceAround,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                          children: [
                                                            KText(
                                                              text:
                                                              snapshot.data!.docs[index]["Message"].toString(),
                                                              style: SafeGoogleFont('Nunito',
                                                                  fontSize: width / 97.5714,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: Colors.white),
                                                            ),
                                                            KText(
                                                              text:
                                                              snapshot.data!.docs[index]["time"].toString(),
                                                              style: SafeGoogleFont('Nunito',
                                                                  fontSize: width / 136.6,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: Colors.white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height:
                                                      height /
                                                          20.9,
                                                      width: width /
                                                          44.5333,
                                                      decoration: BoxDecoration(
                                                          color: Color(colorValue),
                                                          borderRadius:
                                                          BorderRadius.circular(100),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(UserImg)
                                                      )
                                                      ),
                                                      child:Center(
                                                        child: Text(UserImg==""?
                                                        groupNameTextfunc(departmentName.toString()).toString():"",style: GoogleFonts.nunito(
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white
                                                        ),),
                                                      ),

                                                    ),
                                                  ],
                                                )),
                                          )
                                              : GestureDetector(

                                               onTap: (){
                                                 Groupshowdialog(snapshot.data!.docs[index].id,expand2);
                                               },
                                                child: Align(
                                                                                          alignment:
                                                                                          Alignment.topLeft,
                                                                                          child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .end,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: width /
                                                            54.64),
                                                    child:
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: width /
                                                              130.6,
                                                          right: width /
                                                              136.6,
                                                          top: height /
                                                              65.7,
                                                          bottom: height /
                                                              65.7),
                                                      decoration:
                                                      BoxDecoration(
                                                          color: Color(0xff5B93FF).withOpacity(
                                                              0.8),
                                                          borderRadius:
                                                          BorderRadius.only(
                                                            topLeft:
                                                            Radius.circular(8),
                                                            topRight:
                                                            Radius.circular(8),
                                                            bottomRight:
                                                            Radius.circular(8),
                                                          )),
                                                      margin: EdgeInsets.only(
                                                          bottom: height /
                                                              105.7),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end,
                                                        children: [
                                                          KText(
                                                            text: snapshot
                                                                .data!
                                                                .docs[index]["Message"]
                                                                .toString(),
                                                            style:
                                                            SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize:
                                                              width / 97.5714,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              color:
                                                              Colors.white,
                                                            ),
                                                          ),
                                                          KText(
                                                            text: snapshot
                                                                .data!
                                                                .docs[index]["time"]
                                                                .toString(),
                                                            style:
                                                            SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize:
                                                              width / 136.6,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              color:
                                                              Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: height /
                                                        20.9,
                                                    width: width /
                                                        44.5333,
                                                    decoration: BoxDecoration(
                                                        color: Color(
                                                            0xffDFDEFF),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(UserImg)
                                                    )

                                                    ),

                                                    child: Center(
                                                      child: UserImg==""?Icon(Icons.person):Text(""),
                                                    ),
                                                  ),
                                                ],
                                                                                          ),
                                                                                        ),
                                              ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: height / 13.14,
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: height / 13.14,
                            decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 0.5,
                                      blurRadius: 0.5)
                                ],
                                borderRadius: BorderRadius.circular(5)),
                            margin: EdgeInsets.only(
                                left: width / 136.6,
                                right: width / 136.6,
                                bottom: height / 65.7),
                            child: TextField(
                              controller: message,
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: width / 97.5714,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff7D7D7E),
                              ),
                              onTap: () {},
                              onSubmitted: (_) {

                                groupChatfuntion();

                              },
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 136.6,
                                        vertical: height / 65.1),
                                    child: Container(
                                      height: 1,
                                      width: 1,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/paperclip.png"))),
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Image.asset(
                                        "assets/images/send icon.png"),
                                    onPressed: () {
                                      print("Group Messageeeeeee+++++++++++++++++++++++++++++++++++++");
                                      groupChatfuntion();
                                    },
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: width / 68.3,
                                      top: height / 32.85,
                                      bottom: height / 43.8),
                                  border: InputBorder.none,
                                  hintText: "Type your message",
                                  hintStyle: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: width / 97.5714,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff7D7D7E),
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
                  : Container(
                      width: width / 1.95,
                      height: height / 1.095,
                      child: Lottie.asset('assets/Chats img.json'),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                    ),
            ],
          )
        ],
      ),
    );
  }

  chatfuntion() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(expand)
        .collection("Messages")
        .doc()
        .set({
      "Message": message.text,
      "time": DateFormat('hh:mm a').format(DateTime.now()),
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "From": "Admin",
      "date":
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
    });
    sendPushMessage(title: "${name.toString()}New Message".toString(),body: message.text,token: usertoken.toString());
  }

  groupChatfuntion() async {

    FirebaseFirestore.instance.collection("Groups").doc(expand2).collection("Messages").doc()
        .set({
      "Message": message.text,
      "time": DateFormat('hh:mm a').format(DateTime.now()),
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "From": "Admin",
      "date":
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
    });
    print(departmentName);
    print(acadamicYear);
   var Userdata=await FirebaseFirestore.instance.collection("Users").get();
   for(int x=0;x<Userdata.docs.length;x++){
     if(Userdata.docs[x]['subjectStream']==departmentName){
       if(Userdata.docs[x]['yearofpassed']==acadamicYear){
         sendPushMessage(
             body:message.text ,
             title: "${Userdata.docs[x]['subjectStream']}-${Userdata.docs[x]['yearofpassed']} New Message",
             token:Userdata.docs[x]['Token'].toString() );
         FirebaseFirestore.instance.collection("Users").doc(Userdata.docs[x].id).collection("Groups").doc()
             .set({
           "Message": message.text,
           "time": DateFormat('hh:mm a').format(DateTime.now()),
           "timestamp": DateTime.now().millisecondsSinceEpoch,
           "From": "Admin",
           "date":
           "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
         });
       }
     }



   }
    message.clear();
  }


  ischatfuntion(id) {
    FirebaseFirestore.instance.collection("Users").doc(id).update({
      'ischat': false,
    });
  }

  deletechats(id, expand) {
    FirebaseFirestore.instance.collection("Users").doc(expand).collection("Messages").doc(id).delete();
  }

  deleteGroupchats(id, expand) {
    FirebaseFirestore.instance.collection("Groups").doc(expand).collection("Messages").doc(id).delete();
  }

  //delete chats
  Future showdialog(id, expand) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: KText(
            text: "Delete",
            style: SafeGoogleFont(
              'Nunito',
              fontSize: width / 68.3,
              fontWeight: FontWeight.w700,
              color: Color(0xff030229),
            ),
          ),
          content: SizedBox(
            height: height / 2.95909,
            width: width / 5.0,
            child: Column(
              children: [
                KText(
                  text: "Are you sure want to delete",
                  style: SafeGoogleFont(
                    'Nunito',
                    fontSize: width / 68.3,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff030229),
                  ),
                ),
                SizedBox(
                  height: height / 21.7,
                ),

                Icon(Icons.delete,size: width/17.075,),
                SizedBox(
                  height: height / 21.7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                            deletechats(id, expand);
                            Navigator.pop(context);
                            deletepin.clear();
                        },
                        child: Card(
                            color: Constants().primaryAppColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding:  EdgeInsets.only(left: width/91.066,right: width/91.066,
                                  top: height/130.2,bottom: height/130.2),
                              child: KText(
                                text: "Yes",
                                style: SafeGoogleFont(
                                  'Nunito',
                                  fontSize: width / 68.3,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ))),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Card(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding:  EdgeInsets.only(left: width/91.066,right: width/91.066,
                                  top: height/130.2,bottom: height/130.2),
                              child: KText(
                                text: "No",
                                style: SafeGoogleFont(
                                  'Nunito',
                                  fontSize: width / 68.3,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ))),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //delete chats
  Future Groupshowdialog(id, expand) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: KText(
            text: "Delete",
            style: SafeGoogleFont(
              'Nunito',
              fontSize: width / 68.3,
              fontWeight: FontWeight.w700,
              color: Color(0xff030229),
            ),
          ),
          content: SizedBox(
            height: height / 2.95909,
            width: width / 5.0,
            child: Column(
              children: [
                KText(
                  text: "Are you sure want to delete",
                  style: SafeGoogleFont(
                    'Nunito',
                    fontSize: width / 68.3,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff030229),
                  ),
                ),
                SizedBox(
                  height: height / 21.7,
                ),

                Icon(Icons.delete,size: width/17.075,),
                SizedBox(
                  height: height / 21.7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          deleteGroupchats(id, expand);
                          Navigator.pop(context);
                          deletepin.clear();
                        },
                        child: Card(
                            color: Constants().primaryAppColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding:  EdgeInsets.only(left: width/91.066,right: width/91.066,
                                  top: height/130.2,bottom: height/130.2),
                              child: KText(
                                text: "Yes",
                                style: SafeGoogleFont(
                                  'Nunito',
                                  fontSize: width / 68.3,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ))),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Card(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding:  EdgeInsets.only(left: width/91.066,right: width/91.066,
                                  top: height/130.2,bottom: height/130.2),
                              child: KText(
                                text: "No",
                                style: SafeGoogleFont(
                                  'Nunito',
                                  fontSize: width / 68.3,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ))),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }




  void sendPushMessage({required String token, required String body, required String title}) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=AAAAMbpijGg:APA91bGJh2qke8JHGkBaJvJ5-mSnllb0aAIi-lF2YKt9MejKB-m51-SQZJR2u3tYdC9UsOB0ps_G6n29EuZPGFW5xAp4lHQDFWi11TFSDn65VyXYyFY0c-SzXuwk2fE31ADp9MdryFBB',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );

    } catch (e) {
      print("error push notification");
    }
  }
  TextEditingController deletepin = TextEditingController();


  groupNameTextfunc(groupName){

      List<String> words = groupName.split(" ");
      String result=words.length>1? "${words[0].substring(0,1)}${words[1].substring(0,1)}":"${words.toString().substring(1,3)}";
      return  result;
  }



}
