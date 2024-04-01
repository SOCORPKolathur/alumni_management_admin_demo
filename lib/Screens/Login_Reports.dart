import 'package:alumni_management_admin/Constant_.dart';
import 'package:alumni_management_admin/Models/Language_Model.dart';
import 'package:alumni_management_admin/common_widgets/developer_card_widget.dart';
import 'package:alumni_management_admin/utils.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Login_Reports extends StatefulWidget {
  const Login_Reports({super.key});

  @override
  State<Login_Reports> createState() => _Login_ReportsState();
}

class _Login_ReportsState extends State<Login_Reports> with SingleTickerProviderStateMixin{

  TabController? _tabController;
  int currentTabIndex = 0;

  List<DocumentSnapshot> todayReports = [];
  int iosUsersCount = 0;
  int androidUsersCount = 0;
  int webUsersCount = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    setUsers();
    super.initState();
  }

  setUsers() async {
    var userDoc = await FirebaseFirestore.instance.collection('LoginReports').orderBy('timestamp',descending: true).get();
    userDoc.docs.forEach((element) {
      if(element.get("deviceOs").toString().toLowerCase() == "android"){
        setState(() {
          androidUsersCount++;
        });
      }else if(element.get("deviceOs").toString().toLowerCase() == "ios"){
        setState(() {
          iosUsersCount++;
        });
      }else{
        setState(() {
          webUsersCount++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(
        vertical: height/92.375,
        horizontal: width/192
      ),
      child: SingleChildScrollView(
        child: FadeInRight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top:height/30.0769,
                left: width/170.75,
                  right: width/170.75,
                  bottom: height/81.375
                ),
                child: KText(
                  text: "Login Reports",
                  style: SafeGoogleFont (
                      'Nunito',
                    fontSize: width / 82.538,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff030229),

                  )
                ),
              ),

              /// platform Counter Container
              SizedBox(
                width: width/1.2418,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height/4.06875,
                      width: width/4.06875,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1, 2),
                              blurRadius: 3),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Constants().primaryAppColor,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.2,
                            child: Center(
                              child: KText(
                                text: "Total Android Users",
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: width/56.916,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: width/4.06875,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width/105.076),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: androidUsersCount.toString(),
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: width/41.393,
                                              ),
                                            ),
                                            KText(
                                              text: androidUsersCount.toString(),
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: width/85.375,
                                                color:
                                                Color(0xff8A92A6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: width/68.3),
                                        Container(
                                          height: height/16.275,
                                          width: width/34.15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            color: Color(0xfff2d6d3),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.android,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height/54.25,
                                        horizontal: width/113.833
                                    ),
                                    child: LinearProgressIndicator(
                                      backgroundColor:
                                      Color(0xfff2d6d3),
                                      color: Color(0xffC03221),
                                      value: 10,
                                      semanticsLabel:
                                      'Linear progress indicator',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: height/4.06875,
                      width: width/4.06875,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1, 2),
                              blurRadius: 3),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Constants().primaryAppColor,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.2,
                            child: Center(
                              child: KText(
                                text: "Total Ios Users",
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: width/56.916,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: width/4.06875,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width/105.076),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: iosUsersCount.toString(),
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: width/41.393,
                                              ),
                                            ),
                                            KText(
                                              text: iosUsersCount.toString(),
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: width/85.375,
                                                color:
                                                Color(0xff8A92A6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: width/68.3),
                                        Container(
                                          height: height/16.275,
                                          width: width/34.15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            color: Color(0xffcdebec),
                                          ),
                                          child: Center(
                                            child: Icon(
                                                Icons.apple,
                                                color: Color(0xff068B92)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height/54.25,
                                        horizontal: width/113.833
                                    ),
                                    child: LinearProgressIndicator(
                                      backgroundColor:
                                      Color(0xffcdebec),
                                      color: Color(0xff068B92),
                                      value: 4,
                                      semanticsLabel:
                                      'Linear progress indicator',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: height/4.06875,
                      width: width/4.06875,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1, 2),
                              blurRadius: 3),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Constants().primaryAppColor,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.2,
                            child: Center(
                              child: KText(
                                text: "Total Web Users",
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: width/56.916,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: width/4.06875,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width/105.076),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: webUsersCount.toString(),
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: width/41.393,
                                              ),
                                            ),
                                            KText(
                                              text: webUsersCount.toString(),
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: width/85.375,
                                                color:
                                                Color(0xff8A92A6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: width/68.3),
                                        Container(
                                          height: height/16.275,
                                          width: width/34.15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            color: Color(0xffd1ecdd),
                                          ),
                                          child: Center(
                                            child: Icon(
                                                Icons.web,
                                                color: Color(0xff17904B)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height/54.25,
                                        horizontal: width/113.833
                                    ),
                                    child: LinearProgressIndicator(
                                      backgroundColor:
                                      Color(0xffd1ecdd),
                                      color: Color(0xff17904B),
                                      value: 20,
                                      semanticsLabel:
                                      'Linear progress indicator',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),



              SizedBox(
                height: size.height * 0.9,
                width: width/1.2538,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('LoginReports').orderBy('timestamp',descending: true).snapshots(),
                  builder: (ctx, snap){
                    if(snap.hasData){
                      todayReports.clear();
                      snap.data!.docs.forEach((element) {
                        if(element.get("date") == DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()){
                          todayReports.add(element);
                          print(todayReports);
                        }
                      });
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [

                              SizedBox(
                                height: height/10.85,
                                width: double.infinity,
                                child: TabBar(
                                  onTap: (int index) {
                                    setState(() {
                                      currentTabIndex = index;
                                    });
                                  },
                                  unselectedLabelColor: Colors.black,
                                  indicatorColor: Constants().primaryAppColor,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  automaticIndicatorColorAdjustment: true,
                                  controller: _tabController,
                                  labelColor: Constants().primaryAppColor,
                                  unselectedLabelStyle: const TextStyle(color: Colors.black) ,
                                  labelStyle: TextStyle(color: Constants().primaryAppColor) ,
                                  tabs: [
                                    Tab(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          "Overall Reports",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            color: currentTabIndex == 0
                                                ? Constants().primaryAppColor
                                                : Colors.black,
                                            fontSize: width/97.57142857142857,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          "Today Reports",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            color: currentTabIndex == 1
                                                ? Constants().primaryAppColor
                                                : Colors.black,
                                            fontSize: width/97.57142857142857,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                height: height/13.02,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width/17.075,
                                        child: Text(
                                          "SL.NO",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontWeight: FontWeight.w700,
                                            fontSize: width/110.35294117647059,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width/9.106666667,
                                        child: Text(
                                          "Device OS",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontWeight: FontWeight.w700,
                                            fontSize: width/110.35294117647059,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width/6.83,
                                        child: Text(
                                          "Device ID",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontWeight: FontWeight.w700,
                                            fontSize: width/110.35294117647059,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width: width/4.588888889,
                                        child: Text(
                                          "Browser Name",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontWeight: FontWeight.w700,
                                            fontSize: width/110.35294117647059,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width/9.106666667,
                                        child: Text(
                                          "Date",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontWeight: FontWeight.w700,
                                            fontSize: width/110.35294117647059,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width/17.075,
                                        child: Text(
                                          "Time",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontWeight: FontWeight.w700,
                                            fontSize: width/110.35294117647059,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Expanded(
                                child: TabBarView(
                                  dragStartBehavior: DragStartBehavior.down,
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: _tabController,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: ListView.builder(
                                        itemCount: snap.data!.docs.length,
                                        itemBuilder: (ctx , i){
                                          var data = snap.data!.docs[i];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                            child: Container(
                                              //height: height/13.02,
                                              width: double.infinity,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: width/17.075,
                                                    child: Text(
                                                      (i+1).toString(),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width/9.106666667,
                                                    child: Text(
                                                      data.get("deviceOs"),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width/6.83,
                                                    child: Text(
                                                      data.get("deviceId"),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width/4.588888889,
                                                    child: Text(
                                                      data.get("Browser").toString(),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width/9.106666667,
                                                    child: Text(
                                                      data.get("date").toString(),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width/17.075,
                                                    child: Text(
                                                      data.get("time").toString(),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: ListView.builder(
                                        itemCount: todayReports.length,
                                        itemBuilder: (ctx , i){
                                          var data = todayReports[i];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                            child: Container(
                                              //height: height/13.02,
                                              width: double.infinity,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: width/17.075,
                                                    child: Text(
                                                      (i+1).toString(),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width/9.106666667,
                                                    child: Text(
                                                      data.get("deviceOs"),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width/6.83,
                                                    child: Text(
                                                      data.get("deviceId"),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: width/4.588888889,
                                                    child: Text(
                                                      data.get("Browser").toString(),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width/9.106666667,
                                                    child: Text(
                                                      data.get("date").toString(),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width/17.075,
                                                    child: Text(
                                                      data.get("time").toString(),
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: width/113.35294117647059,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              SizedBox(height: size.height * 0.04),
           //   const DeveloperCardWidget(),
              SizedBox(height: size.height * 0.01),

              SizedBox(height: height / 65.1),
              DeveloperCardWidget(),
              SizedBox(height: height / 65.1),
            ],
          ),
        ),
      ),
    );
  }
}




