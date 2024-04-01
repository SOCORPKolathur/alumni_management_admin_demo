import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../Constant_.dart';
import '../Models/Language_Model.dart';
import '../common_widgets/developer_card_widget.dart';
import '../utils.dart';

class Notification_Screen extends StatefulWidget {
  const Notification_Screen({super.key});

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> with SingleTickerProviderStateMixin {

  TabController? _tabController;
  int currentTabIndex = 0;

  int messageCount = 0;
  int requestCount = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    setBadgeCount();
    super.initState();
  }


  setBadgeCount() async {
    var messages = await FirebaseFirestore.instance.collection('Messages').get();
    var requests = await FirebaseFirestore.instance.collection('ProfileEditRequest').where("Editted",isEqualTo: false).get();
    messages.docs.forEach((element) {
      if(element.get("isViewed") == false){
        messageCount++;
      }
    });
    setState(() {
      requestCount += requests.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: height/65.1,horizontal: width/136.6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: width/68.3),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child:  Icon(
                        Icons.arrow_back
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width/170.75,vertical: height/81.375),
                  child: KText(
                    text: 'MESSAGES',
                    style: SafeGoogleFont (
                      'Nunito',
                      fontSize: 25*ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3625*ffem/fem,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              width: double.infinity,
              margin:  EdgeInsets.symmetric(
                vertical: height/32.55,
                horizontal: width/68.3,
              ),
              decoration: BoxDecoration(
                color: Constants().primaryAppColor,
                boxShadow:  [
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
                    height: size.height * 0.1,
                    width: double.infinity,
                    child: TabBar(
                      controller: _tabController,
                      onTap: (index){
                        setState(() {
                          currentTabIndex = index;
                        });
                      },
                      labelPadding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      splashBorderRadius: BorderRadius.circular(30),
                      automaticIndicatorColorAdjustment: true,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: Constants().primaryAppColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Messages",

                                  style: SafeGoogleFont(
                                    'Nunito',
                                    color: currentTabIndex == 0
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: width/97.57142857142857,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Visibility(
                                  visible: messageCount != 0,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.white,
                                    child: Center(
                                      child: Text(
                                        messageCount.toString(),
                                        style: SafeGoogleFont(
                                          "Nunito",
                                          color: Constants().primaryAppColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Edit Requests",
                                  style: SafeGoogleFont(
                                    "Nunito",
                                    color: currentTabIndex == 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: width/97.57142857142857,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Visibility(
                                  visible: requestCount != 0,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.white,
                                    child: Center(
                                      child: Text(
                                        requestCount.toString(),
                                        style: SafeGoogleFont(
                                          "Nunito",
                                          color: Constants().primaryAppColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.7,
                    width: double.infinity,
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding:  EdgeInsets.symmetric(
                        horizontal: width/68.3,
                        vertical: height/32.55
                    ),
                    child: TabBarView(
                      dragStartBehavior: DragStartBehavior.down,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Messages").snapshots(),
                            builder: (ctx, snap){
                              if(snap.hasData){
                                return  ListView.builder(
                                  itemCount: snap.data!.docs.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (ctx, i) {
                                    return Padding(
                                      padding:  EdgeInsets.symmetric(
                                          vertical: height/81.375,
                                          horizontal: width/170.75
                                      ),
                                      child: VisibilityDetector(
                                        key: Key('my-widget-key1 $i'),
                                        onVisibilityChanged: (VisibilityInfo visibilityInfo){
                                          var visiblePercentage = visibilityInfo.visibleFraction;
                                          if(snap.data!.docs[i]['isViewed']){
                                            updateMessageViewStatus(snap.data!.docs[i].id);
                                          }
                                        },
                                        child: Container(
                                          height: height/6.0,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: Colors.grey.shade50,
                                          ),
                                          padding:  EdgeInsets.symmetric(
                                              horizontal: width/68.3,
                                              vertical: height/32.55),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snap.data!.docs[i]['title'],
                                                    style:  SafeGoogleFont(
                                                      "Nunito",
                                                      fontSize: width/75.888  ,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  //  SizedBox(height: height/32.55),
                                                  SizedBox(
                                                    height: height/15.4,
                                                    width: width/1.366,
                                                    child: Text(
                                                      snap.data!.docs[i]['content'],
                                                      style:  SafeGoogleFont(
                                                        "Nunito",
                                                        fontSize: width/91.066,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Visibility(
                                                    visible: snap.data!.docs[i]['isViewed'],
                                                    child: Container(
                                                      height: height/36.95,
                                                      width: width/19.2,
                                                      decoration: BoxDecoration(
                                                          color: Constants().primaryAppColor,
                                                          borderRadius: BorderRadius.circular(30)
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "New",
                                                          style: SafeGoogleFont(
                                                            "Nunito",
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Date : ",
                                                        style: SafeGoogleFont(
                                                          "Nunito",
                                                          fontSize: width/97.571,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        snap.data!.docs[i]['date'],
                                                        style: SafeGoogleFont(
                                                          "Nunito",
                                                          fontSize: width/97.571,
                                                          fontWeight:
                                                          FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Visibility(
                                                    visible: snap.data!.docs[i]['isViewed'],
                                                    child: SizedBox(height: height/32.55),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Time : ",
                                                        style: SafeGoogleFont(
                                                          "Nunito",
                                                          fontSize: width/97.571,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        snap.data!.docs[i]['time'],
                                                        style: SafeGoogleFont(
                                                          "Nunito",
                                                          fontSize: width/97.571,
                                                          fontWeight:
                                                          FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }return Container();
                            }
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('ProfileEditRequest').where("Editted",isEqualTo: false).snapshots(),
                            builder: (ctx, snap){
                              if(snap.hasData){
                                return buildRequests(snap.data!.docs);
                              }return Container();
                            }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height / 65.1),
            DeveloperCardWidget(),
            SizedBox(height: height / 65.1),
          ],
        ),
      ),
    );
  }

  // buildMessages(List<MessageModel> messages){
  //   Size size = MediaQuery.of(context).size;
  //   double height = MediaQuery.of(context).size.height;
  //   double width = MediaQuery.of(context).size.width;
  //   return SingleChildScrollView(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //
  //       ],
  //     ),
  //   );
  // }
  //
  buildRequests(List<DocumentSnapshot> requests){
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: requests.isEmpty
          ? Center(
        child: Lottie.asset(
          Constants().Lottiefile,
          fit: BoxFit.contain,
          height: size.height * 0.6,
          width: size.width * 0.7,
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: requests.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (ctx, i) {
              return Padding(
                padding:  EdgeInsets.symmetric(
                    vertical: height/81.375,
                    horizontal: width/170.75
                ),
                child: Container(
                  height: height/6.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                  ),
                  padding:  EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height/7.39,
                        width: size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Profile Edit Request from ${requests[i].get("Name")}",
                              style:  SafeGoogleFont(
                                "Nunito",
                                fontSize: width/75.888  ,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'USER ID : ${requests[i].get("userDocId")}',
                              style:  SafeGoogleFont(
                                "Nunito",
                                fontSize: width/91.066,
                                fontWeight:
                                FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap:(){
                              viewPopup(requests[i]);
                            },
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: height/21.1142,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "View Details",
                                      style: SafeGoogleFont(
                                        "Nunito",
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  bool isDifferent(val1,val2){
    bool isDifferent = false;
    if(val1 != val2){
      isDifferent = true;
    }
    return isDifferent;
  }

  viewPopup(DocumentSnapshot user)  async {
    var extUser = await FirebaseFirestore.instance.collection('Users').doc(user.get("userDocId")).get();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            width: size.width * 0.5,
            margin: EdgeInsets.symmetric(
                horizontal: width/68.3,
                vertical: height/32.55
            ),
            decoration: BoxDecoration(
              color: Constants().primaryAppColor,
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
              children: [
                SizedBox(
                  height: size.height * 0.1,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/81.375),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          extUser.get("Name")+" "+extUser.get("lastName"),
                          style: SafeGoogleFont(
                            "Nunito",
                            fontSize: width / 68.3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () async{

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
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 227.66),
                              child: Center(
                                child: KText(
                                  text: "CLOSE",
                                  style:SafeGoogleFont(
                                    "Nunito",
                                    fontSize:width/85.375,
                                    fontWeight: FontWeight.bold,
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
                Container(
                  height:height/1.56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,

                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.3,
                          height: size.height * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image:
                            user.get("UserImg")==""?
                            DecorationImage(
                              fit: BoxFit.fill,
                              image:

                              AssetImage(""),
                            ):DecorationImage(
                              fit: BoxFit.fill,
                              image:

                              NetworkImage(user.get("UserImg")),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width/136.6, vertical: height/43.4),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(height: height / 32.55),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.15,
                                      child: KText(
                                        text: "Name",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            fontWeight: FontWeight.w800,
                                            fontSize:width/85.375),
                                      ),
                                    ),
                                    Text(":"),
                                    SizedBox(width: width / 68.3),
                                    KText(
                                      text:
                                      "${user.get("Name")} ${user.get("lastName")}",
                                      style: SafeGoogleFont(
                                          "Nunito",fontSize: width/97.571),
                                    ),
                                    SizedBox(width: width / 68.3),
                                    Visibility(
                                      visible:
                                          isDifferent(extUser.get("Name"),user.get("Name"))||
                                              isDifferent(extUser.get("lastName"),user.get("lastName")),
                                      child: Text(
                                        "Edited",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            color: Constants().primaryAppColor,
                                            fontSize: width/97.571
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: height / 32.55),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.15,
                                      child: KText(
                                        text: "Phone",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            fontWeight: FontWeight.w800,
                                            fontSize:width/85.375),
                                      ),
                                    ),
                                    Text(":"),
                                    SizedBox(width: width / 68.3),
                                    KText(
                                      text: user.get("Phone"),
                                      style: SafeGoogleFont(
                                          "Nunito",fontSize: width/97.571),
                                    ),
                                    SizedBox(width: width / 68.3),
                                    Visibility(
                                      visible: isDifferent(extUser.get("Phone"),user.get("Phone")),
                                      child: Text(
                                        "Edited",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            color: Constants().primaryAppColor,
                                            fontSize: width/97.571
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: height / 32.55),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.15,
                                      child: KText(
                                        text: "Email",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            fontWeight: FontWeight.w800,
                                            fontSize:width/85.375),
                                      ),
                                    ),
                                    Text(":"),
                                    SizedBox(width: width / 68.3),
                                    KText(
                                      text: user.get("email"),
                                      style: SafeGoogleFont(
                                          "Nunito",fontSize: width/97.571),
                                    ),
                                    SizedBox(width: width / 68.3),
                                    Visibility(
                                      visible: isDifferent(extUser.get("email"),user.get("email")),
                                      child: Text(
                                        "Edited",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            color: Constants().primaryAppColor,
                                            fontSize: width/97.571
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: height / 32.55),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.15,
                                      child: KText(
                                        text: "Profession",
                                        style:SafeGoogleFont(
                                            "Nunito",
                                            fontWeight: FontWeight.w800,
                                            fontSize:width/85.375),
                                      ),
                                    ),
                                    Text(":"),
                                    SizedBox(width: width / 68.3),
                                    KText(
                                      text: user.get("Occupation"),
                                      style: SafeGoogleFont(
                                          "Nunito",fontSize: width/97.571),
                                    ),
                                    SizedBox(width: width / 68.3),
                                    Visibility(
                                      visible: isDifferent(extUser.get("Occupation"),user.get("Occupation")),
                                      child: Text(
                                        "Edited",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            color: Constants().primaryAppColor,
                                            fontSize: width/97.571
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: height / 32.55),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.15,
                                      child: KText(
                                        text: "Marital Status",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            fontWeight: FontWeight.w800,
                                            fontSize:width/85.375),
                                      ),
                                    ),
                                    Text(":"),
                                    SizedBox(width: width / 68.3),
                                    KText(
                                      text: user.get("maritalStatus"),
                                      style: SafeGoogleFont(
                                          "Nunito",fontSize: width/97.571),
                                    ),
                                    SizedBox(width: width / 68.3),
                                    Visibility(
                                      visible: isDifferent(extUser.get("maritalStatus"),user.get("maritalStatus")),
                                      child: Text(
                                        "Edited",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            color: Constants().primaryAppColor,
                                            fontSize: width/97.571
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: height / 32.55),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.15,
                                      child: KText(
                                        text: "Anniversary Date",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            fontWeight: FontWeight.w800,
                                            fontSize:width/85.375),
                                      ),
                                    ),
                                    Text(":"),
                                    SizedBox(width: width / 68.3),
                                    KText(
                                      text: user.get("anniversaryDate"),
                                      style: SafeGoogleFont(
                                          "Nunito",fontSize: width/97.571),
                                    ),
                                    SizedBox(width: width / 68.3),
                                    Visibility(
                                      visible: isDifferent(extUser.get("anniversaryDate"),user.get("anniversaryDate")),
                                      child: Text(
                                        "Edited",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            color: Constants().primaryAppColor,
                                            fontSize: width/97.571
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                SizedBox(height: height / 32.55),
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.15,
                                      child: KText(
                                        text: "Address",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            fontWeight: FontWeight.w800,
                                            fontSize:width/85.375),
                                      ),
                                    ),
                                    Text(":"),
                                    SizedBox(width: width / 68.3),
                                    SizedBox(
                                      width: size.width * 0.25,
                                      child: Text(
                                        user.get("Address"),
                                        style: SafeGoogleFont(
                                            "Nunito",fontSize: width/97.571),
                                      ),
                                    ),
                                    SizedBox(width: width / 68.3),
                                    Visibility(
                                      visible: isDifferent(extUser.get("Address"),user.get("Address")),
                                      child: Text(
                                        "Edited",
                                        style: SafeGoogleFont(
                                            "Nunito",
                                            color: Constants().primaryAppColor,
                                            fontSize: width/97.571
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: height / 32.55),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: Colors.grey.shade100,
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
                      padding:  EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              var getUserdata=await FirebaseFirestore.instance.collection('Users').where("userDocId",isEqualTo: user.get("userDocId")).get();

                              if(getUserdata.docs.length>0){
                                FirebaseFirestore.instance.collection('Users').doc(getUserdata.docs[0].id).update({
                                  "Editted": true,
                                });
                                FirebaseFirestore.instance.collection('ProfileEditRequest').doc(getUserdata.docs[0].id).update({
                                  "Editted": true,
                                });
                              }
                              await CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "User Updated successfully!",
                                width: MediaQuery.of(context).size.width * 0.4,
                                backgroundColor: Constants()
                                    .primaryAppColor
                                    .withOpacity(0.8),
                              );
                            },
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: height/21.1142,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "Approve",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () async {

                             var getUserdata=await FirebaseFirestore.instance.collection('Users').where("userDocId",isEqualTo: user.get("userDocId")).get();

                             if(getUserdata.docs.length>0){

                               FirebaseFirestore.instance.collection('Users').doc(getUserdata.docs[0].id).update({
                                 "Editted": false,
                               });
                               FirebaseFirestore.instance.collection('ProfileEditRequest').doc(getUserdata.docs[0].id).update({
                                 "Editted": false,
                               });


                             }
                              //await denyRequest(user.id,user.get("userDocId"));
                              await CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "User Request denied",
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  backgroundColor: Constants()
                                      .primaryAppColor
                                      .withOpacity(0.8));
                            },
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: height/21.1142,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "Deny",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // String generateRandomString(int len) {
  //   var r = Random();
  //   const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  //   return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
  //       .join();
  // }
  //
  // denyRequest(String id,String userDocId) async {
  //   String title = "Denied Request";
  //   String body = "Your Profile edit request denied";
  //   String docId = generateRandomString(16);
  //   FirebaseFirestore.instance.collection('ProfileEditRequest').doc(id).delete();
  //   Navigator.pop(context);
  //   var user = await FirebaseFirestore.instance.collection('Users').doc(userDocId).get();
  //   String token = user.get("fcmToken");
  //   String phone = user.get("phone");
  //   var response = await http.post(
  //     Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //       'key=AAAAuzKqCXA:APA91bHpckZw1E2JuVr8MTPvoic6pDOOtxmTddTsSBno2ZYd3fMDo7kFmbsHHRfmuZurh0ut8n_46FgPAI5YdtfpwmJk85o9qeTMca9QgVhy7CiDUOdSer_ifyqaAQcGtF_oyBaX8UMQ',
  //     },
  //     body: jsonEncode(
  //       <String, dynamic>{
  //         'notification': <String, dynamic>{'body': body, 'title': title},
  //         'priority': 'high',
  //         'data': <String, dynamic>{
  //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //           'id': '1',
  //           'status': 'done'
  //         },
  //         "to": token,
  //       },
  //     ),
  //   );
  //   NotificationModel notificationModel = NotificationModel(
  //       date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
  //       time: DateFormat('hh:mm a').format(DateTime.now()),
  //       timestamp: DateTime.now().millisecondsSinceEpoch,
  //       content: body,
  //       to: phone,
  //       subject: title,
  //       isViewed: false,
  //       viewsCount: []
  //   );
  //   var json = notificationModel.toJson();
  //   await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(userDocId)
  //       .collection('Notifications').doc(docId)
  //       .set(json)
  //       .whenComplete(() {
  //   }).catchError((e) {
  //   });
  // }

  // updateProfile(String userDocId,DocumentSnapshot snap) async {
  //   FirebaseFirestore.instance.collection('Users').doc(userDocId).update({
  //     "firstName": snap.get("firstName"),
  //     "lastName": snap.get("lastName"),
  //     "imgUrl": snap.get("imgUrl"),
  //     "email": snap.get("email"),
  //     "phone": snap.get("phone"),
  //     "maritialStatus": snap.get("maritalStatus"),
  //     "anniversaryDate": snap.get("anniversaryDate"),
  //     "locality": snap.get("locality"),
  //     "profession": snap.get("profession"),
  //     "address": snap.get("address"),
  //     "about": snap.get("about"),
  //   });
  //
  //   String title = "Request Approved";
  //   String body = "Your Profile edit request approved. Your profile will updated";
  //   String docId = generateRandomString(16);
  //   FirebaseFirestore.instance.collection('ProfileEditRequest').doc(snap.id).delete();
  //   Navigator.pop(context);
  //   var user = await FirebaseFirestore.instance.collection('Users').doc(userDocId).get();
  //   String token = user.get("fcmToken");
  //   String phone = user.get("phone");
  //   var response = await http.post(
  //     Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //       'key=AAAAuzKqCXA:APA91bHpckZw1E2JuVr8MTPvoic6pDOOtxmTddTsSBno2ZYd3fMDo7kFmbsHHRfmuZurh0ut8n_46FgPAI5YdtfpwmJk85o9qeTMca9QgVhy7CiDUOdSer_ifyqaAQcGtF_oyBaX8UMQ',
  //     },
  //     body: jsonEncode(
  //       <String, dynamic>{
  //         'notification': <String, dynamic>{'body': body, 'title': title},
  //         'priority': 'high',
  //         'data': <String, dynamic>{
  //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //           'id': '1',
  //           'status': 'done'
  //         },
  //         "to": token,
  //       },
  //     ),
  //   );
  //   // NotificationModel notificationModel = NotificationModel(
  //   //     date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
  //   //     time: DateFormat('hh:mm a').format(DateTime.now()),
  //   //     timestamp: DateTime.now().millisecondsSinceEpoch,
  //   //     content: body,
  //   //     to: phone,
  //   //     subject: title,
  //   //     isViewed: false,
  //   //     viewsCount: []
  //   // );
  //   var json = notificationModel.toJson();
  //   await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(userDocId)
  //       .collection('Notifications').doc(docId)
  //       .set(json)
  //       .whenComplete(() {
  //   }).catchError((e) {
  //   });
  // }
  //
  updateMessageViewStatus(messageid) async {
    FirebaseFirestore.instance.collection('Messages').doc(messageid).update({
      "isViewed": true
    });
  }
}
