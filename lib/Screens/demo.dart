import 'package:alumni_management_admin/Screens/Dashboard.dart';
import 'package:alumni_management_admin/Screens/Events_Page.dart';
import 'package:alumni_management_admin/Screens/Job_Reports.dart';
import 'package:alumni_management_admin/Screens/audio_podcasts.dart';
import 'package:alumni_management_admin/Screens/blog_tab.dart';
import 'package:alumni_management_admin/Screens/donations_tab.dart';
import 'package:alumni_management_admin/Screens/faculty.dart';
import 'package:alumni_management_admin/Screens/screen_gallery.dart';
import 'package:alumni_management_admin/Screens/usersmanagment.dart';
import 'package:alumni_management_admin/Screens/website_socialmedia_tab.dart';
import 'package:animate_do/animate_do.dart';
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
];


List<String> texts = [
  'Dashboard',
  'Alumni Tracking',
  'Users',
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
  'Faculty'
];

 List<IconData> icons = [
  Icons.data_saver_off,
  Icons.auto_graph_rounded,
  Icons.person_outlined,
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
   Icons.person,
];

 class MyWidget extends StatefulWidget {
  String? email;

  MyWidget({this.email});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}


class _MyWidgetState extends State<MyWidget> {

  void select(int n) {
    for (int i = 0; i < 19; i++) {
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
    print("ints funxtionssssssssssssssssssssssssssssssssssssssssssssssssssssss");
    print(widget.email);

    setState(() {
      pages = DashBoard(
        usermail: widget.email.toString(),
      );

    });
    setState(() {

    });
    // TODO: implement initState
    super.initState();
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
              padding: EdgeInsets.symmetric(
                  horizontal: width / 192, vertical: height / 92.375),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width / 76.8,
                                  top: height / 36.8,
                                  ),
                              child: Container(
                                  width: width / 34.133,
                                  height: height / 16.422,
                                  child: Image.asset("assets/logocl.png")),
                            ),
                            SizedBox(
                              width: width / 192,
                            ),
                            KText(
                              text: "IKIA College",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: width / 76.8),
                            )
                          ],
                        ),
                       /* Column(
                          children: [

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 0;
                                  pages = DashBoard(
                                    usermail: widget.email.toString(),
                                  );
                                });
                                if (selectedPage == 0) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 50,
                                width: value == 1 ? (value * width / 6.0) : 0,
                                decoration: BoxDecoration(
                                  color: selectedPage == 0
                                      ? Constants().primaryAppColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width / 192,
                                    ),
                                    Icon(
                                      Icons.data_saver_off,
                                      color: selectedPage == 0
                                          ? Colors.white
                                          :  Constants().primaryAppColor,
                                    ),
                                    SizedBox(
                                      width: width / 192,
                                    ),
                                    KText(
                                      text: "Dash Board",
                                      style: GoogleFonts.poppins(
                                        fontWeight: selectedPage == 0
                                            ? FontWeight.w500
                                            : FontWeight.w500,
                                        color: selectedPage == 0
                                            ? Colors.white
                                            : Colors.black,
                                        letterSpacing:
                                            selectedPage == 0 ? 2.0 : 0,
                                        fontSize:
                                            selectedPage == 0 ? 13.0 : 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 1;
                                  pages = Reports_Screen();
                                  value = 0;
                                });
                                if (selectedPage == 1) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (value * width / 6.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: selectedPage == 1
                                          ? Constants().primaryAppColor
                                          : Colors.white,
                                    ),
                                    curve: Curves.easeIn,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.groups,
                                          color: selectedPage == 1
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Reports",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 1
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.groups,
                                          color: selectedPage == 1
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Reports",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 1
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 2;
                                  pages = Users_Screen();
                                });
                                if (selectedPage == 2) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (value * width / 6.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: selectedPage == 2
                                          ? Constants().primaryAppColor
                                          : Colors.white,
                                    ),
                                    curve: Curves.easeIn,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.person_outlined,
                                          color: selectedPage == 2
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Users",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 2
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.person_outlined,
                                          color: selectedPage == 2
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Users",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 2
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 3;
                                  pages = Gallery_Screen();
                                });
                                if (selectedPage == 3) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (value * width / 6.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: selectedPage == 3
                                          ? Constants().primaryAppColor
                                          : Colors.white,
                                    ),
                                    curve: Curves.easeIn,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.image_outlined,
                                          color: selectedPage == 3
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Gallery",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 3
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.image_outlined,
                                          color: selectedPage == 3
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Gallery",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 3
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 4;
                                  pages = EventsTab();
                                });
                                if (selectedPage == 4) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (value * width / 6.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: selectedPage == 4
                                          ? Constants().primaryAppColor
                                          : Colors.white,
                                    ),
                                    curve: Curves.easeIn,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.event,
                                          color: selectedPage == 4
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Events",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 4
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.event,
                                          color: selectedPage == 4
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Events",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 4
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 5;
                                  pages = Job_Posts();
                                });
                                if (selectedPage == 5) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (value * width / 6.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: selectedPage == 5
                                          ? Constants().primaryAppColor
                                          : Colors.white,
                                    ),
                                    curve: Curves.easeIn,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.event,
                                          color: selectedPage == 5
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Job Posts",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 5
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.event,
                                          color: selectedPage == 5
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Job Posts",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 5
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 6;
                                  pages = Colleage_Activities_Screen();
                                });
                                if (selectedPage == 6) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (value * width / 6.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: selectedPage == 6
                                          ? Constants().primaryAppColor
                                          : Colors.white,
                                    ),
                                    curve: Curves.easeIn,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.local_activity,
                                          color: selectedPage == 6
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Clg Activities",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 6
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.local_activity,
                                          color: selectedPage == 6
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Clg Activities",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 6
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 9;
                                  pages = UsersManagement();
                                });
                                if (selectedPage == 9) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (value * width / 6.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: selectedPage == 9
                                          ? Constants().primaryAppColor
                                          : Colors.white,
                                    ),
                                    curve: Curves.easeIn,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.person_outlined,
                                          color: selectedPage == 9
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "User Management",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 9
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.person_outlined,
                                          color: selectedPage == 9
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "User Management",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 9
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 10;
                                  pages = Message_Screen();
                                });
                                if (selectedPage == 10) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (value * width / 6.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: selectedPage == 10
                                          ? Constants().primaryAppColor
                                          : Colors.white,
                                    ),
                                    curve: Curves.easeIn,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.message,
                                          color: selectedPage == 10
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Message",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 10
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.message,
                                          color: selectedPage == 10
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Message",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 10
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 11;
                                  pages = SettingsTabs();
                                });
                                if (selectedPage == 11) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (value * width / 6.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: selectedPage == 11
                                          ? Constants().primaryAppColor
                                          : Colors.white,
                                    ),
                                    curve: Curves.easeIn,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.settings,
                                          color: selectedPage == 11
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Settings",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 11
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.settings,
                                          color: selectedPage == 11
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Settings",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 11
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 12;
                                  pages = Login_Reports();
                                });
                                if (selectedPage == 12) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (value * width / 6.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: selectedPage == 12
                                          ? Constants().primaryAppColor
                                          : Colors.white,
                                    ),
                                    curve: Curves.easeIn,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.auto_graph_rounded,
                                          color: selectedPage == 12
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Login Reports",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 12
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.auto_graph_rounded,
                                          color: selectedPage == 12
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Login Reports",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 12
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///Expanded Tiles
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.zero,
                              child: ExpansionTile(
                                leading:  Icon(
                                  Icons.circle,
                                  color: Expaned1
                                      ? Colors.white
                                      : Colors.blue,
                                ),
                                onExpansionChanged: (value){
                                  setState(() {
                                    Expaned1=!Expaned1;
                                    selectedPage=100;
                                  });
                                },
                                backgroundColor:   Expaned1?
                                  Constants().primaryAppColor : Colors.white,
                                collapsedBackgroundColor:  Expaned1?
                                Constants().primaryAppColor : Colors.white,
                                title: KText(
                                  text: "Communication",
                                  style: GoogleFonts.poppins(
                                    // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                    color: Expaned1
                                        ? Colors.white
                                        : Colors.black,
                                    //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                    //fontSize: selectedPage==1 ? 13.0 : 12.0,),
                                  ),
                                ),
                                children: [

                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPage = 13;
                                        pages = SMS_Screen();
                                      });
                                      if (selectedPage == 13) {
                                        setState(() {
                                          value = 1;
                                        });
                                      } else {
                                        setState(() {
                                          value = 0;
                                        });
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          width: (value * width / 6.0),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: selectedPage == 13
                                                ? Constants().primaryAppColor
                                                : Colors.white,
                                          ),
                                          curve: Curves.easeIn,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              Icon(
                                                Icons.mail,
                                                color: selectedPage == 13
                                                    ? Colors.white
                                                    : Colors.blue,
                                              ),
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              KText(
                                                text: "SMS",
                                                style: GoogleFonts.poppins(
                                                  // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                                  color: selectedPage == 13
                                                      ? Colors.white
                                                      : Colors.black,
                                                  //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                                  //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(9.0),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              Icon(
                                                Icons.mail,
                                                color: selectedPage == 13
                                                    ? Colors.white
                                                    : Colors.blue,
                                              ),
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              KText(
                                                text: "SMS",
                                                style: GoogleFonts.poppins(
                                                  // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                                  color: selectedPage == 13
                                                      ? Colors.white
                                                      : Colors.black,
                                                  //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                                  //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPage = 14;
                                        pages = Email_Screen();
                                      });
                                      if (selectedPage == 14) {
                                        setState(() {
                                          value = 1;
                                        });
                                      } else {
                                        setState(() {
                                          value = 0;
                                        });
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          width: (value * width / 6.0),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: selectedPage == 14
                                                ? Constants().primaryAppColor
                                                : Colors.white,
                                          ),
                                          curve: Curves.easeIn,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              Icon(
                                                Icons.mail,
                                                color: selectedPage == 14
                                                    ? Colors.white
                                                    : Colors.blue,
                                              ),
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              KText(
                                                text: "Email",
                                                style: GoogleFonts.poppins(
                                                  // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                                  color: selectedPage == 14
                                                      ? Colors.white
                                                      : Colors.black,
                                                  //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                                  //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(9.0),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              Icon(
                                                Icons.mail,
                                                color: selectedPage == 14
                                                    ? Colors.white
                                                    : Colors.blue,
                                              ),
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              KText(
                                                text: "Email",
                                                style: GoogleFonts.poppins(
                                                  // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                                  color: selectedPage == 14
                                                      ? Colors.white
                                                      : Colors.black,
                                                  //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                                  //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPage = 15;
                                        pages = Com_Notification_Screen();
                                      });
                                      if (selectedPage == 15) {
                                        setState(() {
                                          value = 1;
                                        });
                                      } else {
                                        setState(() {
                                          value = 0;
                                        });
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          width: (value * width / 6.0),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: selectedPage == 15
                                                ? Constants().primaryAppColor
                                                : Colors.white,
                                          ),
                                          curve: Curves.easeIn,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              Icon(
                                                Icons.notifications,
                                                color: selectedPage == 15
                                                    ? Colors.white
                                                    : Colors.blue,
                                              ),
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              KText(
                                                text: "Notification",
                                                style: GoogleFonts.poppins(
                                                  // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                                  color: selectedPage == 15
                                                      ? Colors.white
                                                      : Colors.black,
                                                  //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                                  //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(9.0),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              Icon(
                                                Icons.notifications,
                                                color: selectedPage == 15
                                                    ? Colors.white
                                                    : Colors.blue,
                                              ),
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              KText(
                                                text: "Notification",
                                                style: GoogleFonts.poppins(
                                                  // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                                  color: selectedPage == 15
                                                      ? Colors.white
                                                      : Colors.black,
                                                  //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                                  //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.zero,
                              child: ExpansionTile(
                                leading:  Icon(
                                  Icons.circle,
                                  color: Expaned1
                                      ? Colors.white
                                      : Colors.blue,
                                ),
                                onExpansionChanged: (value){
                                  setState(() {
                                    Expaned2=!Expaned2;
                                    selectedPage=100;
                                  });
                                },
                                backgroundColor:   Expaned2?
                                Constants().primaryAppColor : Colors.white,
                                collapsedBackgroundColor:  Expaned2?
                                Constants().primaryAppColor : Colors.white,
                                title: KText(
                                  text: "Master",
                                  style: GoogleFonts.poppins(
                                    // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                    color: Expaned2
                                        ? Colors.white
                                        : Colors.black,
                                    //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                    //fontSize: selectedPage==1 ? 13.0 : 12.0,),
                                  ),
                                ),
                                children: [

                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPage = 7;
                                        pages = Acadamic_Year();
                                      });
                                      if (selectedPage == 7) {
                                        setState(() {
                                          value = 1;
                                        });
                                      } else {
                                        setState(() {
                                          value = 0;
                                        });
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        AnimatedContainer(
                                          duration:
                                          const Duration(milliseconds: 300),
                                          width: (value * width / 6.0),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(3),
                                            color: selectedPage == 7
                                                ? Constants().primaryAppColor
                                                : Colors.white,
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              Icon(
                                                Icons.calendar_month_outlined,
                                                color: selectedPage == 7
                                                    ? Colors.white
                                                    : Colors.blue,
                                              ),
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              KText(
                                                text: "Acadamic Year",
                                                style: GoogleFonts.poppins(
                                                  // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                                  color: selectedPage == 7
                                                      ? Colors.white
                                                      : Colors.black,
                                                  //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                                  //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          curve: Curves.easeIn,
                                        ),
                                        Container(
                                          height: 50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(9.0),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              Icon(
                                                Icons.calendar_month_outlined,
                                                color: selectedPage == 7
                                                    ? Colors.white
                                                    : Colors.blue,
                                              ),
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              KText(
                                                text: "Acadamic Year",
                                                style: GoogleFonts.poppins(
                                                  // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                                  color: selectedPage == 7
                                                      ? Colors.white
                                                      : Colors.black,
                                                  //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                                  //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPage = 8;
                                        pages = Department_Screen();
                                      });
                                      if (selectedPage == 8) {
                                        setState(() {
                                          value = 1;
                                        });
                                      } else {
                                        setState(() {
                                          value = 0;
                                        });
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        AnimatedContainer(
                                          duration:
                                          const Duration(milliseconds: 300),
                                          width: (value * width / 6.0),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(3),
                                            color: selectedPage == 8
                                                ? Constants().primaryAppColor
                                                : Colors.white,
                                          ),
                                          curve: Curves.easeIn,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              Icon(
                                                Icons.class_,
                                                color: selectedPage == 8
                                                    ? Colors.white
                                                    : Colors.blue,
                                              ),
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              KText(
                                                text: "Department",
                                                style: GoogleFonts.poppins(
                                                  // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                                  color: selectedPage == 8
                                                      ? Colors.white
                                                      : Colors.black,
                                                  //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                                  //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(9.0),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              Icon(
                                                Icons.class_,
                                                color: selectedPage == 8
                                                    ? Colors.white
                                                    : Colors.blue,
                                              ),
                                              SizedBox(
                                                width: width / 192,
                                              ),
                                              KText(
                                                text: "Department",
                                                style: GoogleFonts.poppins(
                                                  // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                                  color: selectedPage == 8
                                                      ? Colors.white
                                                      : Colors.black,
                                                  //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                                  //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 16;
                                });
                                if (selectedPage == 16) {
                                  setState(() {
                                    value = 1;
                                  });
                                } else {
                                  setState(() {
                                    value = 0;
                                  });
                                }
                                LogoutPopup();
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (value * width / 6.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: selectedPage == 16
                                          ? Constants().primaryAppColor
                                          : Colors.white,
                                    ),
                                    curve: Curves.easeIn,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.logout_sharp,
                                          color: selectedPage == 16
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Sign Out",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 16
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        Icon(
                                          Icons.logout_sharp,
                                          color: selectedPage == 16
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                        SizedBox(
                                          width: width / 192,
                                        ),
                                        KText(
                                          text: "Sign Out",
                                          style: GoogleFonts.poppins(
                                            // fontWeight: selectedPage==1 ? FontWeight.w500: FontWeight.w500,
                                            color: selectedPage == 16
                                                ? Colors.white
                                                : Colors.black,
                                            //letterSpacing: selectedPage==1 ? 2.0 : 0,
                                            //fontSize: selectedPage==1 ? 13.0 : 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),*/
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: navElements.map((e) => NavElement(
                              index: navElements.indexOf(e),
                              text: texts[navElements.indexOf(e)],
                              icon: icons[navElements.indexOf(e)],
                              active: isSelected[navElements.indexOf(e)],
                              onTap: () {
                                setState(() {
                                  select(navElements.indexOf(e));
                                  if(navElements.indexOf(e)==0){
                                    setState(() {
                                      pages=DashBoard( usermail: widget.email.toString(),);
                                    });
                                  }
                                  if(navElements.indexOf(e)==2){
                                    setState(() {
                                      pages= Users_Screen(UserViewed: false,);
                                    });
                                  }
                                  if(navElements.indexOf(e)==3){
                                    setState(() {
                                      pages=ScreenGallery();
                                    });
                                  }
                                  if(navElements.indexOf(e)==4){
                                    setState(() {
                                      pages=EventsTab();
                                    });
                                  }
                                  if(navElements.indexOf(e)==5){
                                    setState(() {
                                      pages=const Job_Posts();
                                    });
                                  }
                                  if(navElements.indexOf(e)==6){
                                    setState(() {
                                      pages= const Colleage_Activities_Screen();
                                    });
                                  }
                                  if(navElements.indexOf(e)==7){
                                    setState(() {
                                      pages= const Acadamic_Year();
                                    });
                                  }
                                  if(navElements.indexOf(e)==8){
                                    setState(() {
                                      pages= const Department_Screen();
                                    });
                                  }
                                  if(navElements.indexOf(e)==9){
                                    setState(() {
                                      pages=UsersManagement();
                                    });
                                  }
                                  if(navElements.indexOf(e)==10){
                                    setState(() {
                                      pages=const Message_Screen();
                                    });
                                  }

                                  if(navElements.indexOf(e)==11){
                                    setState(() {
                                      pages= const Login_Reports();
                                    });
                                  }
                                  if(navElements.indexOf(e)==12){
                                    setState(() {
                                      pages= const SMS_Screen();
                                    });
                                  }
                                  if(navElements.indexOf(e)==13){
                                    setState(() {
                                      pages= const Email_Screen();
                                    });
                                  }
                                  if(navElements.indexOf(e)==14){
                                    setState(() {
                                      pages= const Com_Notification_Screen();
                                    });
                                  }
                                  if(navElements.indexOf(e)==1){
                                    setState(() {
                                      pages=const Job_Reports();
                                    });
                                  }
                                  if(navElements.indexOf(e)==15){
                                    setState(() {
                                      pages=BlogTab();
                                    });
                                  }if(navElements.indexOf(e)==16){
                                    setState(() {
                                       pages=WebsiteAndSocialMediaTab();
                                    });
                                  }
                                  if(navElements.indexOf(e)==17){
                                    setState(() {
                                      pages=AudioPodcastTab();
                                    });
                                  }
                                  if(navElements.indexOf(e)==18){
                                    setState(() {
                                      pages=Faculty_Tab();
                                    });
                                  }

                                });
                              },
                            ),
                          )
                              .toList(),
                        ),
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
