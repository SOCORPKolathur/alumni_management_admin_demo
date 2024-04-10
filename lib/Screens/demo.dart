import 'package:alumni_management_admin/ClassesMaster.dart';
import 'package:alumni_management_admin/Screens/Dashboard.dart';
import 'package:alumni_management_admin/Screens/Events_Page.dart';
import 'package:alumni_management_admin/Screens/Job%20Advertsiment.dart';
import 'package:alumni_management_admin/Screens/Job_Reports.dart';
import 'package:alumni_management_admin/Screens/Notification_Screen.dart';
import 'package:alumni_management_admin/Screens/audio_podcasts.dart';
import 'package:alumni_management_admin/Screens/blog_tab.dart';
import 'package:alumni_management_admin/Screens/donations_tab.dart';
import 'package:alumni_management_admin/Screens/faculty.dart';
import 'package:alumni_management_admin/Screens/screen_gallery.dart';
import 'package:alumni_management_admin/Screens/usersmanagment.dart';
import 'package:alumni_management_admin/Screens/website_socialmedia_tab.dart';
import 'package:alumni_management_admin/houses.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constant_.dart';
import '../Models/Language_Model.dart';
import 'Colleage_Activities_Screen.dart';
import 'Com_Notification_Screen.dart';
import 'DepartMents_Screen.dart';
import 'Email_Screen.dart';
import 'Job_Posts.dart';
import 'Login_Reports.dart';
import 'Acdamic_Year.dart';
import 'SMS_Screen.dart';
import 'Setting_Screen.dart';
import '../utils.dart';

import 'Gallery_Screen.dart';
import 'Message_Screen.dart';
import 'Reports_Screen.dart';
import 'Signin.dart';
import 'Users_Screen.dart';
import 'Setting_Screen.dart';

List<bool> isSelected = [
  true,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];
List<NavElement> navElements = [
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
];


List<String> texts = [
  'Dashboard',
  'Alumni Tracking',
  'Users',
  'Faculty',
  'Gallery',
  "Events",
  'Job Post',
  'College Activity',
  'Academic Year',
  'Department',
  'User Management',
  'Messages',
  'Login Reports',
  'SMS',
  'Email',
  'Notification',
  'Blog',
  'Social Media',
  'Audio podcasts',
  'Job Advertisement',

];

 List<IconData> icons = [
  Icons.data_saver_off,
  Icons.auto_graph_rounded,
  Icons.person_outlined,
   Icons.person,
  Icons.image_outlined,
  Icons.event,
  Icons.post_add,
  Icons.pending_actions,
  Icons.event,
  Icons.document_scanner_sharp,
  Icons.auto_graph_rounded,
  Icons.message,
  Icons.report,
  Icons.mail,
  Icons.mail,
  Icons.notifications,
   Icons.my_library_books_sharp,
   Icons.facebook,
   Icons.mic,
   Icons.add_business_rounded,

];

 class MyWidget extends StatefulWidget {
  String? email;

  MyWidget({this.email});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}


class _MyWidgetState extends State<MyWidget> {

  void select(int n) {
    for (int i = 0; i < 20; i++) {
      if (i == n) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
  }

  var pages;

  String userEmail = "";
  int selectedPage = 0;
  int value = 1;
  bool Expaned1=false;
  bool Expaned2=false;

  @override
  void initState() {
    setState(() {
      pages = DashBoard(usermail: widget.email.toString(),);
    });
    getadmin();

    // TODO: implement initState
    super.initState();
  }
  int dawer = 0;


  ExpansionTileController admissioncon= new ExpansionTileController();
  ExpansionTileController studdentcon= new ExpansionTileController();
  ExpansionTileController staffcon= new ExpansionTileController();
  ExpansionTileController attdencecon= new ExpansionTileController();
  ExpansionTileController feescon= new ExpansionTileController();
  ExpansionTileController examcon= new ExpansionTileController();
  ExpansionTileController hrcon= new ExpansionTileController();
  ExpansionTileController noticescon= new ExpansionTileController();
  ExpansionTileController timetable= new ExpansionTileController();




  bool col1=false;
  bool col2=false;
  bool col3=false;
  bool col4=false;
  bool col5=false;
  bool col6=false;
  bool col7=false;
  bool col8=false;
  bool col9=false;
  String pagename="Dashboard";

  String collegename="";
  String collegelogo="";
  List moduleslist=[];

  getadmin() async {
    var details1=await FirebaseFirestore.instance.collection("AlumniDetails").get();
    var details=await FirebaseFirestore.instance.collection("AlumniDetails").doc(details1.docs[0].id).get();
    var userdetails=await FirebaseFirestore.instance.collection("AdminUser").where("username",isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
    Map<String,dynamic>?value=details.data();
    setState(() {
      collegelogo=value!["logo"];
      collegename=value["name"];
      moduleslist=userdetails.docs[0]["permission"];
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(

        color: const Color(0xFFFAFBFC),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: width / 192, top: height / 92.375,bottom: height / 92.375),
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: height / 1.0,
                  width: width / 6.6782,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height / 52.7857,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: height / 36.8,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width / 116.8,

                                    ),
                                child: Container(
                                    width: width / 34.133,
                                    height: height / 16.422,
                                    child: Image.network(collegelogo)),
                              ),
                              SizedBox(
                                width: width / 192,
                              ),
                              KText(
                                text: collegename,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: width / 76.8),
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 5,),
                        Visibility(
                            visible: moduleslist.contains("dashboard"),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: AnimatedContainer(
                          
                              height: 35,
                              duration: Duration(milliseconds: 700),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                          
                              ),
                              padding:  EdgeInsets.only(left: dawer == 0 ? 2.0 :0),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  AnimatedContainer(
                                    curve: Curves.fastOutSlowIn,
                                    duration: Duration(milliseconds: 700),
                                    padding: EdgeInsets.only(left: 50),
                                    width:  dawer == 0
                                        ? 200 : 0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: dawer == 0
                                          ? Constants().primaryAppColor : Colors.transparent,
                                    ),
                          
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        pages=DashBoard(usermail: widget.email.toString(),);
                                        dawer=0;
                                        col1=false;
                                        col2=false;
                                        col3=false;
                                        col4=false;
                                        col5=false;
                                        col6=false;
                                        col7=false;
                                        col8=false;
                                        col9=false;
                                        pagename="Dashboard";
                          
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.data_saver_off_rounded,size:20,color: pagename=="Dashboard" ? Colors.white :Colors.black54,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: KText(
                                              text:"Dashboard",
                                              style: GoogleFonts.poppins(
                                                fontWeight: pagename=="Dashboard"
                                                    ? FontWeight.w500
                                                    : FontWeight.w600,
                                                color:
                                                pagename=="Dashboard" ? Colors.white :Colors.black54,
                                                letterSpacing:
                                                pagename=="Dashboard" ?2.7 : 1.5,
                                                fontSize: pagename=="Dashboard" ? 13.0 : 12.0,
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
                          ),
                        ),
                        Visibility(
                            visible: moduleslist.contains("dashboard"),
                            child: SizedBox(height: 5,)),

                        Visibility(
                          visible: moduleslist.contains("reports"),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: AnimatedContainer(
                          
                              height: 35,
                              duration: Duration(milliseconds: 700),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                          
                              ),
                              padding:  EdgeInsets.only(left: dawer == 1 ? 2.0 :0),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  AnimatedContainer(
                                    curve: Curves.fastOutSlowIn,
                                    duration: Duration(milliseconds: 700),
                                    padding: EdgeInsets.only(left: 50),
                                    width:  dawer == 1
                                        ? 200 : 0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: dawer == 1
                                          ? Constants().primaryAppColor : Colors.transparent,
                                    ),
                          
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        pages=Job_Reports();
                                        dawer=1;
                                        col1=false;
                                        col2=false;
                                        col3=false;
                                        col4=false;
                                        col5=false;
                                        col6=false;
                                        col7=false;
                                        col8=false;
                                        col9=false;
                                        pagename="Alumni Tracking";
                          
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.auto_graph_rounded,size:20,color: pagename=="Alumni Tracking" ? Colors.white :Colors.black54,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: KText(
                                              text:"Alumni Tracking",
                                              style: GoogleFonts.poppins(
                                                fontWeight: pagename=="Alumni Tracking"
                                                    ? FontWeight.w500
                                                    : FontWeight.w600,
                                                color:
                                                pagename=="Alumni Tracking" ? Colors.white :Colors.black54,
                                                letterSpacing:
                                                pagename=="Alumni Tracking" ? 1.5 : 1.5,
                                                fontSize: pagename=="Alumni Tracking" ? 13.0 : 12.0,
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
                          ),
                        ),
                        Visibility(
                            visible: moduleslist.contains("reports"),
                          child: SizedBox(height: 5,)),

                        Visibility(
                          visible: moduleslist.contains("Dashboard"),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: AnimatedContainer(
                          
                              height:   col1  == true
                                  ? 180 : 35,
                          
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                          
                              ),
                              padding:  EdgeInsets.only(left:  dawer == 2 ? 2.0 :0),
                              duration: Duration(milliseconds: 400),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  AnimatedContainer(
                                    curve: Curves.fastOutSlowIn,
                                    duration: Duration(milliseconds: 400),
                                    padding: EdgeInsets.only(left: 50),
                                    width:   dawer == 2
                                        ? 200 : 0,
                                    height: col1  == true
                                        ? 180 : 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:  dawer == 2
                                          ? Constants().primaryAppColor : Colors.transparent,
                                    ),
                          
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                          
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                dawer=2;
                                                col1=!col1;
                                                col2 = false;
                                                col3=false;
                                                col4=false;
                                                col5=false;
                                                col6=false;
                                                col7=false;
                                                col8=false;
                                                col9=false;
                                                pagename="Database";
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.storage,size:20,color: pagename=="Database" ? Colors.white :Colors.black54,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Container(
                                                    width:120,
                                                    child: KText(
                                                      text:"Database",
                                                      style: GoogleFonts.poppins(
                                                        fontWeight: pagename=="Database"
                                                            ? FontWeight.w500
                                                            : FontWeight.w600,
                                                        color:
                                                        pagename=="Database" ? Colors.white :Colors.black54,
                                                        letterSpacing:
                                                        pagename=="Database" ? 1.5 : 1.5,
                                                        fontSize: pagename=="Database" ? 13.0 : 12.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Icon(col1==true ?Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined,size:20,color: pagename=="Database" ? Colors.white :Colors.black54,),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Users";
                                              pages= Users_Screen(UserViewed: false,type: 0,);
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Users"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.person_outline,size:20,color: pagename=="Users" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Users",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Users"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Users" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Users" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Users" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Faculty";
                                              pages= Faculty_Tab(FacultyViewed: false,);
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Faculty"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.person,size:20,color: pagename=="Faculty" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Faculty",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Faculty"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Faculty" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Faculty" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Faculty" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Gallery";
                                              pages= Gallery_Screen();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Gallery"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.image_outlined,size:20,color: pagename=="Gallery" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Gallery",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Gallery"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Gallery" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Gallery" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Gallery" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                          
                          
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(child: SizedBox(height: 5,)),

                        Visibility(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: AnimatedContainer(
                          
                              height:    col2==true
                                  ? 200 : 35,
                          
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                          
                              ),
                              padding:  EdgeInsets.only(left:   dawer == 3 ? 2.0 :0),
                              duration: Duration(milliseconds: 400),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  AnimatedContainer(
                                    curve: Curves.fastOutSlowIn,
                                    duration: Duration(milliseconds: 400),
                                    padding: EdgeInsets.only(left: 50),
                                    width:    dawer == 3
                                        ? 200 : 0,
                                    height:   col2==true
                                        ? 200 : 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:   dawer == 3
                                          ? Constants().primaryAppColor : Colors.transparent,
                                    ),
                          
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                          
                          
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: InkWell(
                                              onTap: (){
                                              setState(() {
                                                dawer=3;
                                                col1=false;
                                                col2 = !col2;
                                                col3=false;
                                                col4=false;
                                                col5=false;
                                                col6=false;
                                                col7=false;
                                                col8=false;
                                                col9=false;
                                                pagename="Masters";
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.admin_panel_settings_sharp,size:20,color: pagename=="Masters" ? Colors.white :Colors.black54,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Container(
                                                    width:120,
                                                    child: KText(
                                                      text:"Masters",
                                                      style: GoogleFonts.poppins(
                                                        fontWeight: pagename=="Masters"
                                                            ? FontWeight.w500
                                                            : FontWeight.w600,
                                                        color:
                                                        pagename=="Masters" ? Colors.white :Colors.black54,
                                                        letterSpacing:
                                                        pagename=="Masters" ? 1.5 : 1.5,
                                                        fontSize: pagename=="Masters" ? 13.0 : 12.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Icon(col2==true ?Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined,size:20,color: pagename=="Masters" ? Colors.white :Colors.black54,),
                          
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Academic Year";
                                              pages= Acadamic_Year();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Academic Year"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.pending_actions,size:20,color: pagename=="Academic Year" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Academic Year",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Academic Year"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Academic Year" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Academic Year" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Academic Year" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Department";
                                              pages= Department_Screen();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Department"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.event_note_sharp,size:20,color: pagename=="Department" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Department",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Department"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Department" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Department" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Department" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Classes";
                                              pages= ClassesMaster();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Classes"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.event_note_sharp,size:20,color: pagename=="Classes" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding:  EdgeInsets.only(left: width/341.5,top: height/130.2),
                                                        child: KText(
                                                          text:"Classes",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Classes"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Classes" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Classes" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Classes" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Houses";
                                              pages= HousesMaster();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Houses"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.event_note_sharp,size:20,color: pagename=="Houses" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Houses",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Houses"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Houses" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Houses" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Houses" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                          
                          
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: moduleslist.contains("Dashboard"),
                        child: SizedBox(height: 5,)),

                        Visibility(
                          visible: moduleslist.contains("Dashboard"),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: AnimatedContainer(
                          
                              height:     col3==true
                                  ? 120 : 35,
                          
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                          
                              ),
                              padding:  EdgeInsets.only(left:    dawer == 4 ? 2.0 :0),
                              duration: Duration(milliseconds: 400),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  AnimatedContainer(
                                    curve: Curves.fastOutSlowIn,
                                    duration: Duration(milliseconds: 400),
                                    padding: EdgeInsets.only(left: 50),
                                    width:     dawer == 4
                                        ? 200 : 0,
                                    height:    col3==true
                                        ? 120 : 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:    dawer == 4
                                          ? Constants().primaryAppColor : Colors.transparent,
                                    ),
                          
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                          
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                dawer=4;
                                                col1=false;
                                                col2 = false;
                                                col3=!col3;
                                                col4=false;
                                                col5=false;
                                                col6=false;
                                                col7=false;
                                                col8=false;
                                                col9=false;
                                                pagename="Security";
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.security,size:20,color: pagename=="Security" ? Colors.white :Colors.black54,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Container(
                                                    width:120,
                                                    child: KText(
                                                      text:"Security",
                                                      style: GoogleFonts.poppins(
                                                        fontWeight: pagename=="Security"
                                                            ? FontWeight.w500
                                                            : FontWeight.w600,
                                                        color:
                                                        pagename=="Security" ? Colors.white :Colors.black54,
                                                        letterSpacing:
                                                        pagename=="Security" ? 1.5 : 1.5,
                                                        fontSize: pagename=="Security" ? 13.0 : 12.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Icon(col3==true ?Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined,size:20,color: pagename=="Security" ? Colors.white :Colors.black54,),
                                            
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "User Management";
                                              pages= UsersManagement();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "User Management"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.supervised_user_circle,size:20,color: pagename=="User Management" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"User Management",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="User Management"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="User Management" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="User Management" ? 1.5 : 1.5,
                                                            fontSize: pagename=="User Management" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Login Reports";
                                              pages= Login_Reports();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Login Reports"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.report_gmailerrorred,size:20,color: pagename=="Login Reports" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Login Reports",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Login Reports"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Login Reports" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Login Reports" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Login Reports" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                          
                          
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: moduleslist.contains("Dashboard"),
                            child: SizedBox(height: 5,)),

                        Visibility(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: AnimatedContainer(
                          
                              height:    col4==true
                                  ? 300 : 35,
                          
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                          
                              ),
                              padding:  EdgeInsets.only(left:   dawer == 5 ? 2.0 :0),
                              duration: Duration(milliseconds: 400),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  AnimatedContainer(
                                    curve: Curves.fastOutSlowIn,
                                    duration: Duration(milliseconds: 400),
                                    padding: EdgeInsets.only(left: 50),
                                    width:    dawer == 5
                                        ? 200 : 0,
                                    height:   col4==true
                                        ? 300 : 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:   dawer == 5
                                          ? Constants().primaryAppColor : Colors.transparent,
                                    ),
                          
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                          
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                          
                                                dawer=5;
                                                col1=false;
                                                col2 = false;
                                                col3=false;
                                                col4=!col4;
                                                col5=false;
                                                col6=false;
                                                col7=false;
                                                col8=false;
                                                col9=false;
                                                pagename="Communication";
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.commit,size:20,color: pagename=="Communication" ? Colors.white :Colors.black54,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Container(
                                                    width:120,
                                                    child: KText(
                                                      text:"Communication",
                                                      style: GoogleFonts.poppins(
                                                        fontWeight: pagename=="Communication"
                                                            ? FontWeight.w500
                                                            : FontWeight.w600,
                                                        color:
                                                        pagename=="Communication" ? Colors.white :Colors.black54,
                                                        letterSpacing:
                                                        pagename=="Communication" ? 1.5 : 1.5,
                                                        fontSize: pagename=="Communication" ? 13.0 : 12.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Icon(col4==true ?Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined,size:20,color: pagename=="Communication" ? Colors.white :Colors.black54,),
                                            
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Messages";
                                              pages= Message_Screen();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Messages"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.message_rounded,size:20,color: pagename=="Messages" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Messages",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Messages"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Messages" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Messages" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Messages" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "SMS";
                                              pages= SMS_Screen();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "SMS"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.messenger_outline_rounded,size:20,color: pagename=="SMS" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"SMS",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="SMS"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="SMS" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="SMS" ? 1.5 : 1.5,
                                                            fontSize: pagename=="SMS" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Email";
                                              pages= Email_Screen();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Email"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.email,size:20,color: pagename=="Email" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Email",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Email"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Email" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Email" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Email" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Notifications";
                                              pages= Com_Notification_Screen();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Notifications"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.notifications_active,size:20,color: pagename=="Notifications" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Notifications",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Notifications"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Notifications" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Notifications" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Notifications" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Blogs";
                                              pages= BlogTab();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Blogs"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.edit_note,size:20,color: pagename=="Blogs" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Blogs",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Blogs"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Blogs" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Blogs" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Blogs" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Audio Podcasts";
                                              pages= AudioPodcastTab();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Audio Podcasts"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.audio_file_outlined,size:20,color: pagename=="Audio Podcasts" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Audio Podcasts",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Audio Podcasts"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Audio Podcasts" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Audio Podcasts" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Audio Podcasts" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                          
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: moduleslist.contains("Dashboard"),
                        child: SizedBox(height: 5,)),

                        Visibility(
                          visible: moduleslist.contains("Dashboard"),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: AnimatedContainer(

                              height:    col5==true
                                  ? 250 : 35,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),

                              ),
                              padding:  EdgeInsets.only(left:   dawer == 6 ? 2.0 :0),
                              duration: Duration(milliseconds: 400),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  AnimatedContainer(
                                    curve: Curves.fastOutSlowIn,
                                    duration: Duration(milliseconds: 400),
                                    padding: EdgeInsets.only(left: 50),
                                    width:    dawer == 6
                                        ? 200 : 0,
                                    height:   col5==true
                                        ? 250 : 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:   dawer == 6
                                          ? Constants().primaryAppColor : Colors.transparent,
                                    ),

                                  ),
                                  InkWell(

                                    child: Column(
                                      children: [
                                        SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                dawer=6;
                                                col1=false;
                                                col2=false;
                                                col3=false;
                                                col4=false;
                                                col5=!col5;
                                                col6=false;
                                                col7=false;
                                                col8=false;
                                                col9=false;
                                                pagename="Engagement";

                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.account_tree_outlined,size:20,color: pagename=="Engagement" ? Colors.white :Colors.black54,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Container(
                                                    width:120,
                                                    child: KText(
                                                      text:"Engagement",
                                                      style: GoogleFonts.poppins(
                                                        fontWeight: pagename=="Engagement"
                                                            ? FontWeight.w500
                                                            : FontWeight.w600,
                                                        color:
                                                        pagename=="Engagement" ? Colors.white :Colors.black54,
                                                        letterSpacing:
                                                        pagename=="Engagement" ? 1.5 : 1.5,
                                                        fontSize: pagename=="Engagement" ? 13.0 : 12.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Icon(col5==true ?Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined,size:20,color: pagename=="Engagement" ? Colors.white :Colors.black54,),

                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Events";
                                              pages= EventsTab();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Events"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.event_note_sharp,size:20,color: pagename=="Events" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Events",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Events"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Events" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Events" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Events" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Collage Activity";
                                              pages= Colleage_Activities_Screen();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Collage Activity"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.add_chart_outlined,size:20,color: pagename=="Collage Activity" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"College Activity",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Collage Activity"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Collage Activity" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Collage Activity" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Collage Activity" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Job Advertisements";
                                              pages= Job_Ads();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Job Advertisements"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.group_work_outlined,size:20,color: pagename=="Job Advertisements" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Job Advertisements",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Job Advertisements"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Job Advertisements" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Job Advertisements" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Job Advertisements" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Job Posts";
                                              pages= Job_Posts(0);
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Job Posts"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.work_history_outlined,size:20,color: pagename=="Job Posts" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Job Posts",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Job Posts"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Job Posts" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Job Posts" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Job Posts" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              pagename = "Social Media";
                                              pages= WebsiteAndSocialMediaTab();
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: pagename == "Social Media"
                                                  ? Colors.white : Colors.transparent,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.facebook,size:20,color: pagename=="Social Media" ? Constants().primaryAppColor :Colors.white,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: KText(
                                                          text:"Social Media",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: pagename=="Social Media"
                                                                ? FontWeight.w500
                                                                : FontWeight.w600,
                                                            color:
                                                            pagename=="Social Media" ? Constants().primaryAppColor :Colors.white,
                                                            letterSpacing:
                                                            pagename=="Social Media" ? 1.5 : 1.5,
                                                            fontSize: pagename=="Social Media" ? 13.0 : 12.0,
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
                                        SizedBox(height: 5),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(child: pages)
          ],
        ),
      ),
    );
  }



}

class NavElement extends StatefulWidget {
  final bool? active;
  final Function? onTap;
  final IconData? icon;
  final String? text;
  final int? index;

  NavElement({this.onTap, this.active, this.icon, this.text, this.index});

  @override
  _NavElementState createState() => _NavElementState();
}

Color conColor = Colors.white;

class _NavElementState extends State<NavElement> with TickerProviderStateMixin {
  late AnimationController _tcc; //text color controller
  late Animation<Color?> _tca; //text color animation
  late AnimationController _icc; //icon color controller
  late Animation<Color?> _ica; //icon color animation
  late AnimationController _lsc; //letter spacing controller
  late Animation<double> _lsa; //letter spacing animation
  double width = 140.0;
  double opacity = 0.0;

  @override
  void initState() {

    super.initState();
    _tcc = AnimationController(
        duration: Duration(milliseconds: 475),
        reverseDuration: Duration(milliseconds: 300),
        vsync: this);
    _tca = ColorTween(begin: Colors.black54, end: Colors.black).animate(CurvedAnimation(parent: _tcc, curve: Curves.easeOut, reverseCurve: Curves.easeIn));
    _tcc.addListener(() {
      setState(() {

      });
    });

    _icc = AnimationController(
        duration: Duration(milliseconds: 375),
        reverseDuration: Duration(milliseconds: 300),
        vsync: this);
    _ica = ColorTween(begin: Colors.black, end: Colors.white).animate(
        CurvedAnimation(
            parent: _icc, curve: Curves.easeOut, reverseCurve: Curves.easeIn));

    _icc.addListener(() {
      setState(() {});
    });

    _lsc = AnimationController(
        duration: Duration(milliseconds: 375),
        reverseDuration: Duration(milliseconds: 300),
        vsync: this);
    _lsa = Tween(begin: 0.0, end: 1.5).animate(CurvedAnimation(
        parent: _lsc, curve: Curves.easeOut, reverseCurve: Curves.easeIn));

    _lsc.addListener(() {
      setState(() {});
    });

    if (widget.active!) {
      _icc.forward();
      _tcc.forward();
      _lsc.forward();
    }

    // To delay arrival of each Nav bar element
    Future.delayed(Duration(milliseconds: 150 * (widget.index! + 1)), () {
      setState(() {
        width = 0.0;
        opacity = 1.0;
      //  print(1000 ~/ (1 - (widget.index!)));
      });
    });
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active!) {
      _icc.reverse();
    }
    return MouseRegion(
      onEnter: (value) {
        print("Send Jopb POst+++++++++++++++++++++++++++++++");
        _tcc.forward();
        _lsc.forward();
      },
      onExit: (value) {
        _tcc.reverse();
        _lsc.reverse();
      },
      opaque: false,
      child: GestureDetector(
        onTap: () {
          widget.onTap!();
          _icc.forward();
          _tcc.forward();
          _lsc.forward();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
          padding: EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
          height: 60.0,
          width: 210.0,
          child: Row(
            children: [
              AnimatedContainer(
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
                height: widget.active! ? 45.0 : 35.0,
                width: widget.active! ? 195.0 : 35.0,
                decoration: BoxDecoration(
                  color: widget.active! ?  Constants().primaryAppColor : Colors.white,
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: width / 182,
                    ),
                    Icon(
                      widget.icon,
                      color: _ica.value,
                    ),
                    SizedBox(
                      width: width / 192,
                    ),
                    Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 375),
                          height: 60.0,
                          width: 130.0,
                          alignment: Alignment((width == 0.0) ? -0.9 : -1.0,
                              (width == 0.0) ? 0.0 : -0.9),
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 375),
                            opacity: opacity,
                            child: KText(
                              text: widget.text!,
                              style: GoogleFonts.poppins(
                                fontWeight: widget.active!
                                    ? FontWeight.w500
                                    : FontWeight.w500,
                                color:
                                    widget.active! ? Colors.white : _tca.value,
                                letterSpacing:
                                    widget.active! ? 2.0 : _lsa.value,
                                fontSize: widget.active! ? 13.0 : 12.0,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // Supports the entrance animation
                          right: 0.0,
                          child: AnimatedContainer(
                            height: 60.0,
                            width: width,
                            color: Colors.white,
                            duration: Duration(milliseconds: 375),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
