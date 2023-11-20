import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/Language_Model.dart';
import '../utils.dart';
import 'Notification_Screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int dawer = 0;
  var pages;



  var flagvalue= "en_US";
  var langvalue='English';


  @override
  void initState() {
    totalalumnifunc();
    // TODO: implement initState
    super.initState();
  }


  int TotalUsers=0;
  int verifyedUsers=0;
  int totalEvents=0;
  int newsUpdates=0;
  int totalStudnets=0;
  String viewDocid="";
  bool viewUser_details=false;

  totalalumnifunc()async{
    var document=await FirebaseFirestore.instance.collection("Users").get();
    var verifyedusers=await FirebaseFirestore.instance.collection("Users").get();
    setState(() {
      TotalUsers=document.docs.length;
      verifyedUsers=verifyedusers.docs.length;
    });


  }



  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return  FadeInRight(
      child: Container(
        // autogroupnx99mr9 (T1hGz35EtnvJDP43Jynx99)
        width: 1574*fem,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // topbar7QD (6:110)
                padding: EdgeInsets.fromLTRB(39*fem, 30*fem, 65*fem, 30*fem),
                width: double.infinity,
                height: 120*fem,
                decoration: BoxDecoration (
                  color: Color(0xffffffff),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // alumnimanagment1kV (6:153)
                      margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 40*fem, 0*fem),
                      child: KText(
                        text:
                        'Alumni Management',
                        style: SafeGoogleFont (
                          'Poppins',
                          fontSize: 36*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.3999999364*ffem/fem,
                          color: Color(0xff151d48),
                        ),
                      ),
                    ),
                    // Container(
                    //   // searchbarvMf (6:149)
                    //   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 58*fem, 0*fem),
                    //   padding: EdgeInsets.fromLTRB(28*fem, 16.5*fem, 329*fem, 16.5*fem),
                    //   height: double.infinity,
                    //   decoration: BoxDecoration (
                    //     color: Color(0xfff9fafb),
                    //     borderRadius: BorderRadius.circular(16*fem),
                    //   ),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         // magnifierD5s (6:150)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 12*fem, 0*fem),
                    //         width: 24*fem,
                    //         height: 24*fem,
                    //         child: Image.asset(
                    //           'assets/images/magnifier-27s.png',
                    //           width: 24*fem,
                    //           height: 24*fem,
                    //         ),
                    //       ),
                    //       KText(
                    //         text:
                    //         // searchherevW5 (6:152)
                    //         'Search here...',
                    //         style: SafeGoogleFont (
                    //           'Poppins',
                    //           fontSize: 18*ffem,
                    //           fontWeight: FontWeight.w400,
                    //           height: 1.5*ffem/fem,
                    //           color: Color(0xff737791),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    SizedBox(width:  580*fem,),
                    InkWell(
                      onTap:(){
                        _showPopupMenu();
                      },
                      child: Container(
                        // languangefTf (6:112)
                        margin: EdgeInsets.fromLTRB(0*fem, 16.5*fem, 58*fem, 16.5*fem),
                        padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 7.06*fem, 0*fem),
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // textnHP (6:113)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 23*fem, 0*fem),
                              padding: EdgeInsets.fromLTRB(0.75*fem, 0*fem, 0*fem, 0*fem),
                              height: double.infinity,

                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // unitedTPX (6:114)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.75*fem, 0*fem),
                                    width: 22.5*fem,
                                    height: 22.5*fem,
                                    child:
                                    CountryFlag.fromLanguageCode(
                                      flagvalue,
                                      borderRadius: 20,
                                      width: 9.94*fem,
                                      height: 6*fem,
                                    ),
                                  ),
                                  KText(
                                    text:
                                    // engusYQy (6:130)
                                    langvalue.toString(),
                                    style: SafeGoogleFont (
                                      'Poppins',
                                      fontSize: 18*ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5*ffem/fem,
                                      color: Color(0xff374557),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // menuaMf (6:133)
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          InkWell(
                            onTap:(){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => Notification_Screen(),));
                            },
                            child: Container(
                              // notifications8PB (6:142)
                              margin: EdgeInsets.fromLTRB(0*fem, 2*fem, 24*fem, 0*fem),
                              width: 48*fem,
                              height: 48*fem,
                              child: Image.asset(
                                'assets/images/notifications-C9F.png',
                                width: 48*fem,
                                height: 48*fem,
                              ),
                            ),
                          ),

                          SizedBox(
                            // group1000002734dqj (6:134)
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // rectangle1393P4D (6:135)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 20*fem, 0*fem),
                                  width: 60*fem,
                                  height: 60*fem,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16*fem),
                                    child: Image.asset(
                                      'assets/images/rectangle-1393-SVX.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  // group21862szy (6:136)
                                  margin: EdgeInsets.fromLTRB(0*fem, 6*fem, 0*fem, 6*fem),
                                  width: 80*fem,
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // autogrouplhpfodj (T1hMwtobch7WkBwboSLHpF)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // dineshjGV (6:141)
                                          //    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 53*fem, 0*fem),
                                              child:
                                              KText(
                                                text:
                                                'Dinesh',
                                                style: SafeGoogleFont (
                                                  'Poppins',
                                                  fontSize: 16*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.5*ffem/fem,
                                                  color: Color(0xff151d48),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      KText(
                                        text:
                                        // adminAch (6:140)
                                        'Admin',
                                        style: SafeGoogleFont (
                                          'Poppins',
                                          fontSize: 14*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.4285714286*ffem/fem,
                                          color: Color(0xff737791),
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
                  ],
                ),
              ),
              Container(
                // autogroupa3et6mF (T1hJTpwdBSbRLch6BRA3ET)
                padding: EdgeInsets.fromLTRB(32*fem, 51*fem, 44*fem, 0*fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // todayssales1dK (6:154)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 19*fem),
                      width: double.infinity,
                      height: 320*fem,
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(20*fem),
                      ),
                      child: Container(
                        // todaysalesk57 (6:155)
                        padding: EdgeInsets.fromLTRB(28*fem, 23*fem, 37*fem, 28*fem),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xfff8f9fa)),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(20*fem),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x80ededed),
                              offset: Offset(0*fem, 4*fem),
                              blurRadius: 10*fem,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              // autogroup1pexb5j (T1hJpEXHhsKfhmHXMj1peX)
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // group10000027378LZ (6:213)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 43*fem),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // dashboardrnM (6:214)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                                          child: KText(
                                            text:
                                            'Dashboard',
                                            style:
                                            SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 20*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.6*ffem/fem,
                                              color: Color(0xff05004e),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // alumnisummeryNkh (6:215)
                                          margin: EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 0*fem),
                                          child:
                                          KText(
                                            text:
                                            'Alumni Summery',
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 16*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.875*ffem/fem,
                                              color: Color(0xff737791),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // tU9 (6:192)
                                    margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 0*fem),
                                    padding: EdgeInsets.fromLTRB(20*fem, 20*fem, 20*fem, 20*fem),
                                    width: 260*fem,
                                    decoration: BoxDecoration (
                                      color: Color(0xffffe2e5),
                                      borderRadius: BorderRadius.circular(20*fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // autogroupsjwbBTF (T1hJxZck5kqw33p9g8sjWb)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                                          width: 40*fem,
                                          height: 40*fem,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // iconJXs (6:197)
                                                left: 0*fem,
                                                top: 0*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 40*fem,
                                                    height: 40*fem,
                                                    child: Image.asset(
                                                      'assets/images/icon-91T.png',
                                                      width: 40*fem,
                                                      height: 40*fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // icons8users1001Q57 (6:1169)
                                                left: 8*fem,
                                                top: 8*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 24*fem,
                                                    height: 24*fem,
                                                    child: Image.asset(
                                                      'assets/images/icons8-users-100-1.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // 6yX (6:196)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                                          child: KText(
                                              text:
                                            TotalUsers.toString(),
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        KText(
                                          text:
                                          // totalalumni2MP (6:195)
                                          'Total Alumni ',
                                          style: SafeGoogleFont (
                                            'Poppins',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5*ffem/fem,
                                            color: Color(0xff415166),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 32*fem,
                            ),
                            Container(
                              // autogroupjenfvaV (T1hK6tiCTeNCNLLmzYjeNf)
                              width: 260*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Container(
                                    // YkH (6:1156)
                                    padding: EdgeInsets.fromLTRB(20*fem, 20*fem, 20*fem, 20*fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration (
                                      color: Color(0xffFFF4DE),
                                      borderRadius: BorderRadius.circular(20*fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // autogroupojbdRPX (T1hKexd6iKE1oHGtR2oJbd)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                                          width: 40*fem,
                                          height: 40*fem,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // iconLmP (6:1125)
                                                left: 0*fem,
                                                top: 0*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 40*fem,
                                                    height: 40*fem,
                                                    child: Image.asset(
                                                      'assets/images/icon-a2d.png',
                                                      width: 40*fem,
                                                      height: 40*fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // icons8verified641eXB (6:1170)
                                                left: 10.9999847412*fem,
                                                top: 6*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 24*fem,
                                                    height: 24*fem,
                                                    child: Image.asset(
                                                      'assets/images/icons8-verified-64-1.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // xhX (6:1160)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                                          child: KText(
                                            text:
                                            verifyedUsers.toString(),
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        KText(
                                          text:
                                          // totaleventsspV (6:1159)
                                          'Verified Alumni ',
                                          style: SafeGoogleFont (
                                            'Poppins',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5*ffem/fem,
                                            color: Color(0xff415166),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 32*fem,
                            ),
                            Container(
                              // autogroupjenfvaV (T1hK6tiCTeNCNLLmzYjeNf)
                              width: 260*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Container(
                                    // YkH (6:1156)
                                    padding: EdgeInsets.fromLTRB(20*fem, 20*fem, 20*fem, 20*fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration (
                                      color: Color(0xffDCFCE7),
                                      borderRadius: BorderRadius.circular(20*fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // autogrouprcsdhNy (T1hKnxPmxNHYkv2D3GRcsD)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                                          width: 40*fem,
                                          height: 40*fem,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // icon2AM (6:1137)
                                                left: 0*fem,
                                                top: 0*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 40*fem,
                                                    height: 40*fem,
                                                    child: Image.asset(
                                                      'assets/images/icon-rV7.png',
                                                      width: 40*fem,
                                                      height: 40*fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // icons8student1001ios (6:1171)
                                                left: 7.9999809265*fem,
                                                top: 6*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 24*fem,
                                                    height: 24*fem,
                                                    child: Image.asset(
                                                      'assets/images/icons8-student-100-1.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // xhX (6:1160)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                                          child: KText(
                                            text:
                                            totalStudnets.toString(),
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        KText(
                                          text:
                                          // totaleventsspV (6:1159)
                                          'Total Studnets ',
                                          style: SafeGoogleFont (
                                            'Poppins',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5*ffem/fem,
                                            color: Color(0xff415166),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 32*fem,
                            ),
                            Container(
                              // autogroupjenfvaV (T1hK6tiCTeNCNLLmzYjeNf)
                              width: 260*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Container(
                                    // YkH (6:1156)
                                    padding: EdgeInsets.fromLTRB(20*fem, 20*fem, 20*fem, 20*fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration (
                                      color: Color(0xffF3E8FF),
                                      borderRadius: BorderRadius.circular(20*fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // autogroupqvsuLyf (T1hKwNKRciRVgcVfHDqvsu)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                                          width: 40*fem,
                                          height: 40*fem,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // icon4uf (6:1149)
                                                left: 0*fem,
                                                top: 0*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 40*fem,
                                                    height: 40*fem,
                                                    child: Image.asset(
                                                      'assets/images/icon-wUM.png',
                                                      width: 40*fem,
                                                      height: 40*fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // icons8news641nam (6:1172)
                                                left: 7.9999694824*fem,
                                                top: 8*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 24*fem,
                                                    height: 24*fem,
                                                    child: Image.asset(
                                                      'assets/images/icons8-news-64-1.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // xhX (6:1160)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                                          child: KText(
                                            text:
                                            newsUpdates.toString(),
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        KText(
                                          text:
                                          // totaleventsspV (6:1159)
                                          'Total News & Updates ',
                                          style: SafeGoogleFont (
                                            'Poppins',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5*ffem/fem,
                                            color: Color(0xff415166),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 32*fem,
                            ),
                            Container(
                              // autogroupjenfvaV (T1hK6tiCTeNCNLLmzYjeNf)
                              width: 260*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Container(
                                    // YkH (6:1156)
                                    padding: EdgeInsets.fromLTRB(20*fem, 20*fem, 20*fem, 20*fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration (
                                      color: Color(0xffd4ecff),
                                      borderRadius: BorderRadius.circular(20*fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // autogroupgmcpeoK (T1hKEdzHrKagYjFcr9gmCP)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                                          width: 40*fem,
                                          height: 40*fem,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // iconZvH (6:1161)
                                                left: 0*fem,
                                                top: 0*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 40*fem,
                                                    height: 40*fem,
                                                    child: Image.asset(
                                                      'assets/images/icon-U4R.png',
                                                      width: 40*fem,
                                                      height: 40*fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // icons8events9615dj (6:1173)
                                                left: 5*fem,
                                                top: 4*fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 30*fem,
                                                    height: 30*fem,
                                                    child: Image.asset(
                                                      'assets/images/icons8-events-96-1.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // xhX (6:1160)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                                          child: KText(
                                            text:
                                            totalEvents.toString(),
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        KText(
                                          text:
                                          // totaleventsspV (6:1159)
                                          'Total Events ',
                                          style: SafeGoogleFont (
                                            'Poppins',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5*ffem/fem,
                                            color: Color(0xff415166),
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
                    ),
                    Container(
                      // autogroupdzbdCrm (T1hHErysQURopsK7dqDzbd)
                      margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 10*fem, 33*fem),
                      width: double.infinity,
                      height: 410*fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // salesmappingWsT (6:444)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 28*fem, 0*fem),
                            width: 720*fem,
                            height: double.infinity,
                            child: Stack(
                              children: [
                                Positioned(
                                  // cardbaseqeq (6:445)
                                  left: 0*fem,
                                  top: 0*fem,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(25.65*fem, 113.3*fem, 42.76*fem, 29.2*fem),
                                    width: 718.29*fem,
                                    height: 410*fem,
                                    decoration: BoxDecoration (
                                      border: Border.all(color: Color(0xfff8f9fa)),
                                      color: Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(20*fem),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x80ededed),
                                          offset: Offset(0*fem, 4*fem),
                                          blurRadius: 10*fem,
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      // world15p5 (6:448)
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Center(
                                        // autogroup26c33F7 (T1eKrTDkhXrQ3jmkK726C3)
                                        child: SizedBox(
                                          width: 649.88*fem,
                                          height: 267.49*fem,
                                          child: Image.asset(
                                            'assets/images/auto-group-26c3.png',
                                            width: 649.88*fem,
                                            height: 267.49*fem,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // cardtitlewmj (6:922)
                                  left: 41.0451660156*fem,
                                  top: 30.3703689575*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 219*fem,
                                      height: 32*fem,
                                      child: KText(
                                        text:
                                        'Alumni in World Wide',
                                        style: SafeGoogleFont (
                                          'Poppins',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.6*ffem/fem,
                                          color: Color(0xff05004e),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // visitorinsightsq6R (6:216)
                            width: 720*fem,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(12*fem),
                              image: DecorationImage (
                                fit: BoxFit.cover,
                                image: AssetImage (
                                  'assets/images/auto-group-oznf.png',
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  // cardheaderuMB (6:222)
                                  left: 6.0913696289*fem,
                                  top: 0*fem,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(22.91*fem, 24*fem, 22.91*fem, 19.4*fem),
                                    width: 713.91*fem,
                                    height: 75.4*fem,
                                    child: KText(
                                      text:
                                      'App Usage',
                                      style: SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 20*ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.6*ffem/fem,
                                        color: Color(0xff05004e),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // axisZRj (6:226)
                                  left: 62.1319732666*fem,
                                  top: 109.5689620972*fem,
                                  child: Container(
                                    width: 516*fem,
                                    height: 165*fem,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // axisU2u (6:231)
                                          width: double.infinity,
                                          height: 1*fem,
                                          decoration: BoxDecoration (
                                            color: Color(0x0a464e5f),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40*fem,
                                        ),
                                        Container(
                                          // axisnZP (6:230)
                                          width: double.infinity,
                                          height: 1*fem,
                                          decoration: BoxDecoration (
                                            color: Color(0x0a464e5f),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40*fem,
                                        ),
                                        Container(
                                          // axisKJR (6:229)
                                          width: double.infinity,
                                          height: 1*fem,
                                          decoration: BoxDecoration (
                                            color: Color(0x0a464e5f),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40*fem,
                                        ),
                                        Container(
                                          // axis4G1 (6:228)
                                          width: double.infinity,
                                          height: 1*fem,
                                          decoration: BoxDecoration (
                                            color: Color(0x0a464e5f),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40*fem,
                                        ),
                                        Container(
                                          // axisQ4y (6:227)
                                          width: double.infinity,
                                          height: 1*fem,
                                          decoration: BoxDecoration (
                                            color: Color(0x0a464e5f),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // x6V (6:232)
                                  left: 45.6040649414*fem,
                                  top: 294.540222168*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 8*fem,
                                      height: 16*fem,
                                      child: KText(
                                        text:
                                        '0',
                                        //textAlign: TextAlign.right,
                                        style: SafeGoogleFont (
                                          'Poppins',
                                          fontSize: 12*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3333333333*ffem/fem,
                                          color: Color(0xff7a91b0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // SXT (6:233)
                                  left: 34.6040344238*fem,
                                  top: 246.2356262207*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 19*fem,
                                      height: 16*fem,
                                      child: KText(
                                        text:
                                        '100',
                                        //textAlign: TextAlign.right,
                                        style: SafeGoogleFont (
                                          'Poppins',
                                          fontSize: 12*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3333333333*ffem/fem,
                                          color: Color(0xff7a91b0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // vBj (6:234)
                                  left: 31.6040496826*fem,
                                  top: 196.7528686523*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 22*fem,
                                      height: 16*fem,
                                      child: KText(
                                       text: '200',
                                     //   textAlign: TextAlign.right,
                                        style: SafeGoogleFont (
                                          'Poppins',
                                          fontSize: 12*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3333333333*ffem/fem,
                                          color: Color(0xff7a91b0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // R8V (6:235)
                                  left: 30.6040344238*fem,
                                  top: 149.6264343262*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 23*fem,
                                      height: 16*fem,
                                      child: KText(
                                        text:'300',
                                        //textAlign: TextAlign.right,
                                        style: SafeGoogleFont (
                                          'Poppins',
                                          fontSize: 12*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3333333333*ffem/fem,
                                          color: Color(0xff7a91b0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // XBX (6:236)
                                  left: 30.6040344238*fem,
                                  top: 101.3218383789*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 23*fem,
                                      height: 16*fem,
                                      child: KText(
                                        text:'400',
                                      //  textAlign: TextAlign.right,
                                        style: SafeGoogleFont (
                                          'Poppins',
                                          fontSize: 12*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3333333333*ffem/fem,
                                          color: Color(0xff7a91b0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // jan28H (6:237)
                                  left: 84.8071136475*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 18*fem,
                                      height: 11*fem,
                                      child: KText(
                                       text: 'Jan',
                                      //  textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // febW3T (6:238)
                                  left: 140.8477020264*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 18*fem,
                                      height: 11*fem,
                                      child: KText(
                                        text:
                                        'Feb',
                                       // textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // marzzD (6:239)
                                  left: 182.3781738281*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 19*fem,
                                      height: 11*fem,
                                      child: KText(
                                        text: 'Mar',
                                       // textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // apruLV (6:240)
                                  left: 239.4187469482*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 17*fem,
                                      height: 11*fem,
                                      child: KText(
                                        text:  'Apr',
                                       // textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // maybz1 (6:241)
                                  left: 294.5685424805*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 20*fem,
                                      height: 11*fem,
                                      child: KText(
                                        text:'May',
                                       // textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // junVJh (6:242)
                                  left: 350.3908691406*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 18*fem,
                                      height: 11*fem,
                                      child: KText(
                                        text: 'Jun',
                                        //textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // junBSR (6:243)
                                  left: 406.4315185547*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 18*fem,
                                      height: 11*fem,
                                      child: KText(
                                        text:  'Jun',
                                      //  textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // julUwK (6:244)
                                  left: 464.4721374512*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 14*fem,
                                      height: 11*fem,
                                      child: KText(
                                        text:'Jul',
                                       // textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // septmZ3 (6:245)
                                  left: 503.8299865723*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 23*fem,
                                      height: 11*fem,
                                      child: KText(
                                        text:'Sept',
                                        //textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // octpXK (6:246)
                                  left: 561.1522827148*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 18*fem,
                                      height: 11*fem,
                                      child: KText(
                                        text: 'Oct',
                                        //textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // novvKT (6:247)
                                  left: 617.3020019531*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 19*fem,
                                      height: 11*fem,
                                      child: KText(
                                        text: 'Nov',
                                        //textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // desou3 (6:248)
                                  left: 673.3426513672*fem,
                                  top: 308.6781616211*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 19*fem,
                                      height: 11*fem,
                                      child: KText(
                                        text:  'Des',
                                        //textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Epilogue',
                                          fontSize: 10*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.025*ffem/fem,
                                          color: Color(0xff464e5f),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // frame10Jqo (6:249)
                                  left: 81.6243896484*fem,
                                  top: 110.7471237183*fem,
                                  child: Container(
                                    width: 589.64*fem,
                                    height: 192.04*fem,
                                    child: Center(
                                      // autogrouperqmEDf (T1eGi8HtX396G1Z4V3ERqM)
                                      child: SizedBox(
                                        width: 589.64*fem,
                                        height: 192.04*fem,
                                        child: Image.asset(
                                          'assets/images/auto-group-erqm.png',
                                          width: 589.64*fem,
                                          height: 192.04*fem,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // ellipse40jgD (6:256)
                                  left: 462.9442138672*fem,
                                  top: 121.3505783081*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 17.06*fem,
                                      height: 16.49*fem,
                                      child: Image.asset(
                                        'assets/images/ellipse-40.png',
                                        width: 17.06*fem,
                                        height: 16.49*fem,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // group10pBs (6:258)
                                  left: 129.4540100098*fem,
                                  top: 367.5862121582*fem,
                                  child: Container(
                                    width: 383*fem,
                                    height: 12*fem,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // frame9X6H (6:267)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                          padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 48*fem, 0*fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // rectangle2172Yq (6:269)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                                                width: 12*fem,
                                                height: 12*fem,
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(2*fem),
                                                  color: Color(0xffa700ff),
                                                ),
                                              ),
                                              KText(
                                                // loyalcustomerswvh (6:270)
                                                text:'Alumnus',
                                                style: SafeGoogleFont (
                                                  'Epilogue',
                                                  fontSize: 12*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.025*ffem/fem,
                                                  color: Color(0xff464e5f),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // frame8HUm (6:263)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                          padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 39*fem, 0*fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // rectangle2171Qm (6:265)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                                                width: 12*fem,
                                                height: 12*fem,
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(2*fem),
                                                  color: Color(0xffef4444),
                                                ),
                                              ),
                                              KText(
                                                // newcustomers8VP (6:266)
                                                text: 'Students',
                                                style: SafeGoogleFont (
                                                  'Epilogue',
                                                  fontSize: 12*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.025*ffem/fem,
                                                  color: Color(0xff464e5f),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // frame74tq (6:259)
                                          padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 33*fem, 0*fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // rectangle21713P (6:261)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                                                width: 12*fem,
                                                height: 12*fem,
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(2*fem),
                                                  color: Color(0xff3cd856),
                                                ),
                                              ),
                                              KText(
                                                // uniquecustomersjEH (6:262)
                                                text:'Connections',
                                                style: SafeGoogleFont (
                                                  'Epilogue',
                                                  fontSize: 12*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.025*ffem/fem,
                                                  color: Color(0xff464e5f),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // cardtitleTvy (8:1270)
                      margin: EdgeInsets.fromLTRB(81*fem, 0*fem, 0*fem, 27*fem),
                      child: KText(
                        text:'Alumni\'s Waiting for Verification ',
                        style:
                        SafeGoogleFont (
                          'Poppins',
                          fontSize: 20*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6*ffem/fem,
                          color: Color(0xff05004e),
                        ),
                      ),
                    ),

                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Users").orderBy("timestamp",descending: false).snapshots(),
                      builder: (context, snapshot) {

                        if(!snapshot.hasData){
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        if(snapshot.hasData==null){
                          return const Center(child: CircularProgressIndicator(),);
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics:const  NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {

                            var _userdata=snapshot.data!.docs[index];

                          if(_userdata['verifyed']==false){
                            return   Container(
                              padding: EdgeInsets.fromLTRB(26.07*fem, 19.56*fem, 39.11*fem, 19.56*fem),
                              width: 1119.87*fem,
                              height: 78.22*fem,
                              decoration: BoxDecoration (
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.circular(10*fem),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:250,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.34*fem, 0*fem),
                                          width: 39.11*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xfff6d0d0),
                                            borderRadius: BorderRadius.circular(19.5553703308*fem),
                                          ),
                                          child: Center(
                                            // imgFVB (8:2248)
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: 39.11*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(19.5553703308*fem),
                                                  image: DecorationImage (
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage (
                                                        _userdata['UserImg'].toString()
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(

                                          margin: EdgeInsets.fromLTRB(0*fem, 4.14*fem, 129.49*fem, 0*fem),
                                          child: KText(
                                            text:_userdata['Name'],
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 18*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    width:250,
                                    child: KText(
                                      text:_userdata['Email'],
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 18*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xff030229),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width:200,
                                    child: KText(
                                      text:_userdata['Phone'].toString(),
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 18*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xff030229),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width:150,
                                    child: Padding(
                                      padding:  EdgeInsets.only(left:width/54.64,right: width/54.64),
                                      child: Container(
                                        width:width/34.15,
                                        height: double.infinity,
                                        decoration: BoxDecoration (
                                          color:_userdata['Gender']=="Male"?
                                          Color(0x195b92ff):
                                          Color(0xffFEF3F0),
                                          borderRadius: BorderRadius.circular(33*fem),
                                        ),
                                        child: Center(
                                          child: KText(
                                            text:_userdata['Gender'],
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 16*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: _userdata['Gender']=="Male"?
                                              Color(0xff5b92ff):Color(0xffFE8F6B),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),



                                  SizedBox(width:width/17.075),
                                  GestureDetector(
                                    onTap: (){
                                      // setState(() {
                                      //   if(isFloatingOpen) floating!.remove();
                                      //   else {
                                      //     floating = createFloating(context);
                                      //     Overlay.of(context).insert(floating!);
                                      //   }
                                      //   isFloatingOpen = !isFloatingOpen;
                                      // });
                                      setState(() {
                                        viewDocid=_userdata.id;
                                        viewUser_details=!viewUser_details;
                                      });
                                    },
                                    child: SizedBox(
                                      width:60,
                                      height:25,
                                      child: Container(
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.65*fem),
                                          width: 18.25*fem,
                                          height: 15.56*fem,
                                          decoration: BoxDecoration(
                                              color:Color(0xff605bff),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Center(child: KText(
                                            text:viewUser_details?"Close":
                                            "View" , style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3625*ffem/fem,
                                            color: Color(0xffFFFFFF),
                                          ),),)
                                        // Image.asset(
                                        //   'assets/images/menu-fRb.png',
                                        //   width: 18.25*fem,
                                        //   height: 4.56*fem,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return  SizedBox(
                            child: Center(child: KText( text:"No data", style:  SafeGoogleFont (
                              'Poppins',
                              fontSize: 20*ffem,
                              fontWeight: FontWeight.w600,
                            ),)),
                          );
                          },);
                      },),
                    // Container(
                    //   // table1mwf (8:1251)
                    //   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 41.33*fem, 16.85*fem),
                    //   padding: EdgeInsets.fromLTRB(33.71*fem, 25.28*fem, 50.56*fem, 25.28*fem),
                    //   height: 101.12*fem,
                    //   decoration: BoxDecoration (
                    //     color: Color(0xffffffff),
                    //     borderRadius: BorderRadius.circular(10*fem),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color(0x11030229),
                    //         offset: Offset(1*fem, 17*fem),
                    //         blurRadius: 22*fem,
                    //       ),
                    //     ],
                    //   ),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         // imagebgkYh (8:1255)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 18.74*fem, 0*fem),
                    //         width: 50.56*fem,
                    //         height: double.infinity,
                    //         decoration: BoxDecoration (
                    //           color: Color(0xffe4e1fb),
                    //           borderRadius: BorderRadius.circular(25.2794094086*fem),
                    //         ),
                    //         child: Center(
                    //           // imageETs (8:1257)
                    //           child: SizedBox(
                    //             width: double.infinity,
                    //             height: 50.56*fem,
                    //             child: Container(
                    //               decoration: BoxDecoration (
                    //                 borderRadius: BorderRadius.circular(25.2794094086*fem),
                    //                 image: DecorationImage (
                    //                   image: AssetImage (
                    //                     'assets/images/image-bg-V93.png',
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // johndeoLG1 (8:1254)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 5.88*fem, 214.27*fem, 0*fem),
                    //         child: KText(
                    //           'John Deo',
                    //           style: SafeGoogleFont (
                    //             'Nunito',
                    //             fontSize: 24*ffem,
                    //             fontWeight: FontWeight.w400,
                    //             height: 1.3625*ffem/fem,
                    //             color: Color(0xff030229),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // johndoe2211gmailcom2uX (8:1266)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 207.77*fem, 3.71*fem),
                    //         child: KText(
                    //           'johndoe2211@gmail.com',
                    //           style: SafeGoogleFont (
                    //             'Nunito',
                    //             fontSize: 22*ffem,
                    //             fontWeight: FontWeight.w400,
                    //             height: 1.3625*ffem/fem,
                    //             color: Color(0xff030229),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // 8hf (8:1264)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 107.28*fem, 3.71*fem),
                    //         child: KText(
                    //           '+33757005467',
                    //           style: SafeGoogleFont (
                    //             'Nunito',
                    //             fontSize: 22*ffem,
                    //             fontWeight: FontWeight.w400,
                    //             height: 1.3625*ffem/fem,
                    //             color: Color(0xff030229),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // buttonr7s (8:1267)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 3.37*fem, 117.97*fem, 1.69*fem),
                    //         width: 111.23*fem,
                    //         height: double.infinity,
                    //         decoration: BoxDecoration (
                    //           color: Color(0x195b92ff),
                    //           borderRadius: BorderRadius.circular(33*fem),
                    //         ),
                    //         child: Center(
                    //           child: KText(
                    //             'Male',
                    //             style: SafeGoogleFont (
                    //               'Nunito',
                    //               fontSize: 22*ffem,
                    //               fontWeight: FontWeight.w400,
                    //               height: 1.3625*ffem/fem,
                    //               color: Color(0xff5b92ff),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // menug6u (8:1258)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 0.84*fem, 0*fem, 0*fem),
                    //         width: 23.59*fem,
                    //         height: 5.9*fem,
                    //         child: Image.asset(
                    //           'assets/images/menu-ZtM.png',
                    //           width: 23.59*fem,
                    //           height: 5.9*fem,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   // bgLSM (8:1233)
                    //   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 41.33*fem, 16.85*fem),
                    //   padding: EdgeInsets.fromLTRB(33.71*fem, 25.28*fem, 50.56*fem, 25.28*fem),
                    //   height: 101.12*fem,
                    //   decoration: BoxDecoration (
                    //     color: Color(0xffffffff),
                    //     borderRadius: BorderRadius.circular(10*fem),
                    //   ),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         // imgbgc8y (8:1237)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 18.74*fem, 0*fem),
                    //         width: 50.56*fem,
                    //         height: double.infinity,
                    //         decoration: BoxDecoration (
                    //           color: Color(0xffcbeaf0),
                    //           borderRadius: BorderRadius.circular(25.2794094086*fem),
                    //         ),
                    //         child: Center(
                    //           // imgjDb (8:1239)
                    //           child: SizedBox(
                    //             width: double.infinity,
                    //             height: 50.56*fem,
                    //             child: Container(
                    //               decoration: BoxDecoration (
                    //                 borderRadius: BorderRadius.circular(25.2794094086*fem),
                    //                 image: DecorationImage (
                    //                   image: AssetImage (
                    //                     'assets/images/img-bg-Hf7.png',
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // shelbygoodedpm (8:1236)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 5.94*fem, 161.27*fem, 0*fem),
                    //         child: KText(
                    //           'Shelby Goode',
                    //           style: SafeGoogleFont (
                    //             'Nunito',
                    //             fontSize: 24*ffem,
                    //             fontWeight: FontWeight.w400,
                    //             height: 1.3625*ffem/fem,
                    //             color: Color(0xff030229),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // shelbygoode481gmailcomLUH (8:1247)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 172.77*fem, 3.71*fem),
                    //         child: KText(
                    //           'shelbygoode481@gmail.com',
                    //           style: SafeGoogleFont (
                    //             'Nunito',
                    //             fontSize: 22*ffem,
                    //             fontWeight: FontWeight.w400,
                    //             height: 1.3625*ffem/fem,
                    //             color: Color(0xff030229),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // 3Nh (8:1245)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 107.28*fem, 3.71*fem),
                    //         child: KText(
                    //           '+33757005467',
                    //           style: SafeGoogleFont (
                    //             'Nunito',
                    //             fontSize: 22*ffem,
                    //             fontWeight: FontWeight.w400,
                    //             height: 1.3625*ffem/fem,
                    //             color: Color(0xff030229),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // button6Ly (8:1248)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 1.69*fem, 102.8*fem, 3.37*fem),
                    //         width: 126.4*fem,
                    //         height: double.infinity,
                    //         decoration: BoxDecoration (
                    //           color: Color(0x19ff8f6b),
                    //           borderRadius: BorderRadius.circular(33*fem),
                    //         ),
                    //         child: Center(
                    //           child: KText(
                    //             'Female',
                    //             style: SafeGoogleFont (
                    //               'Nunito',
                    //               fontSize: 22*ffem,
                    //               fontWeight: FontWeight.w400,
                    //               height: 1.3625*ffem/fem,
                    //               color: Color(0xffff8f6b),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Opacity(
                    //         // menuvqo (8:1240)
                    //         opacity: 0.3,
                    //         child: Container(
                    //           margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.84*fem),
                    //           width: 23.59*fem,
                    //           height: 5.9*fem,
                    //           child: Image.asset(
                    //             'assets/images/menu-YU9.png',
                    //             width: 23.59*fem,
                    //             height: 5.9*fem,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   // bgpAV (8:1214)
                    //   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 41.33*fem, 0*fem),
                    //   padding: EdgeInsets.fromLTRB(33.71*fem, 25.28*fem, 50.56*fem, 25.28*fem),
                    //   height: 101.12*fem,
                    //   decoration: BoxDecoration (
                    //     color: Color(0xffffffff),
                    //     borderRadius: BorderRadius.circular(10*fem),
                    //   ),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         // imgbgTz9 (8:1229)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 18.74*fem, 0*fem),
                    //         width: 50.56*fem,
                    //         height: double.infinity,
                    //         decoration: BoxDecoration (
                    //           color: Color(0xfff6d0d0),
                    //           borderRadius: BorderRadius.circular(25.2794094086*fem),
                    //         ),
                    //         child: Center(
                    //           // imgP77 (8:1231)
                    //           child: SizedBox(
                    //             width: double.infinity,
                    //             height: 50.56*fem,
                    //             child: Container(
                    //               decoration: BoxDecoration (
                    //                 borderRadius: BorderRadius.circular(25.2794094086*fem),
                    //                 image: DecorationImage (
                    //                   fit: BoxFit.cover,
                    //                   image: AssetImage (
                    //                     'assets/images/img-bg-yU5.png',
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // robertbacinsTMs (8:1228)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 6*fem, 162.27*fem, 0*fem),
                    //         child: KText(
                    //           'Robert Bacins',
                    //           style: SafeGoogleFont (
                    //             'Nunito',
                    //             fontSize: 24*ffem,
                    //             fontWeight: FontWeight.w400,
                    //             height: 1.3625*ffem/fem,
                    //             color: Color(0xff030229),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // robertbacins4182comjKP (8:1226)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 218.77*fem, 3.71*fem),
                    //         child: KText(
                    //           'robertbacins4182@.com',
                    //           style: SafeGoogleFont (
                    //             'Nunito',
                    //             fontSize: 22*ffem,
                    //             fontWeight: FontWeight.w400,
                    //             height: 1.3625*ffem/fem,
                    //             color: Color(0xff030229),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // 1nh (8:1224)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 107.28*fem, 3.71*fem),
                    //         child: KText(
                    //           '+33757005467',
                    //           style: SafeGoogleFont (
                    //             'Nunito',
                    //             fontSize: 22*ffem,
                    //             fontWeight: FontWeight.w400,
                    //             height: 1.3625*ffem/fem,
                    //             color: Color(0xff030229),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         // buttonvuf (8:1220)
                    //         margin: EdgeInsets.fromLTRB(0*fem, 1.69*fem, 117.97*fem, 3.37*fem),
                    //         width: 111.23*fem,
                    //         height: double.infinity,
                    //         decoration: BoxDecoration (
                    //           color: Color(0x195b92ff),
                    //           borderRadius: BorderRadius.circular(33*fem),
                    //         ),
                    //         child: Center(
                    //           child: Text(
                    //             'Male',
                    //             style: SafeGoogleFont (
                    //               'Nunito',
                    //               fontSize: 22*ffem,
                    //               fontWeight: FontWeight.w400,
                    //               height: 1.3625*ffem/fem,
                    //               color: Color(0xff5b92ff),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Opacity(
                    //         // menuP2Z (8:1216)
                    //         opacity: 0.3,
                    //         child: Container(
                    //           margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.84*fem),
                    //           width: 23.59*fem,
                    //           height: 5.9*fem,
                    //           child: Image.asset(
                    //             'assets/images/menu-pSu.png',
                    //             width: 23.59*fem,
                    //             height: 5.9*fem,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  _showPopupMenu() async {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    await showMenu(
        context: context,
        color: Color(0xffFFFFFF),
        surfaceTintColor: Color(0xffFFFFFF),
        shadowColor: Colors.black12,
        position:  const RelativeRect.fromLTRB(550, 70, 200, 500),
        items: [
          PopupMenuItem(
            child: PopupMenuButton(
              surfaceTintColor:  Color(0xffFFFFFF),
              color: Color(0xffFFFFFF),
              shadowColor: Colors.transparent,
              onSelected: (val) {
                Navigator.pop(context);
              },
              position: PopupMenuPosition.over,
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'ta',
                    child:  const Text('Tamil'),
                    onTap: () {
                      changeLocale(context, 'ta');
                      flagvalue= "hi";
                      langvalue='Tamil';
                    },
                  ),
                  PopupMenuItem<String>(
                    value: 'hi',
                    child:  const Text('Hindi'),
                    onTap: () {
                      setState(() {
                        changeLocale(context, 'hi');
                        flagvalue= "hi";
                        langvalue='Hindi';
                      });
                    },
                  ),
                  PopupMenuItem<String>(
                    value: 'te',
                    child:  const Text('Telugu'),
                    onTap: () {
                      changeLocale(context, 'te');
                      flagvalue= "hi";
                      langvalue='Telugu';
                    },
                  ),
                  PopupMenuItem<String>(
                    value: 'ml',
                    child:  const Text('Malayalam'),
                    onTap: () {
                      setState(() {
                        changeLocale(context, 'ml');
                        flagvalue= "hi";
                        langvalue='Malayalam';
                      });
                    },
                  ),
                  PopupMenuItem<String>(
                    value: 'kn',
                    child:  const Text('Kannada'),
                    onTap: () {
                      setState(() {
                        changeLocale(context, 'kn');
                        flagvalue= "hi";
                        langvalue='Kannada';
                      });
                    },
                  ),
                  PopupMenuItem<String>(
                    value: 'mr',
                    child:  const Text('Marathi'),
                    onTap: () {
                      setState(() {
                        changeLocale(context, 'mr');
                        flagvalue= "hi";
                        langvalue='Marathi';
                      });
                    },
                  ),
                  PopupMenuItem<String>(
                    value: 'gu',
                    child:  const Text('Gujarati'),
                    onTap: () {
                      setState(() {
                        changeLocale(context, 'gu');
                        flagvalue= "hi";
                        langvalue='Gujarati';
                      });
                    },
                  ),
                  PopupMenuItem<String>(
                    value: 'or',
                    child:  const Text('Odia'),
                    onTap: () {
                      setState(() {
                        changeLocale(context, 'or');
                        flagvalue= "hi";
                        langvalue='Odia';
                      });
                    },
                  ),
                  PopupMenuItem<String>(
                    value: 'bn',
                    child:  const Text('Bengali'),
                    onTap: () {
                      setState(() {
                        changeLocale(context, 'bn');
                        flagvalue= "hi";
                        langvalue='Bengali';
                      });
                    },
                  ),
                ];
              },
              child: Row(
                children: [
                  CountryFlag.fromLanguageCode(
                    "hi",
                    height: height/16.275,
                    width: width/45.53,
                  ),
                  SizedBox(width: width/136.6),
                  const Text("India"),
                ],
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'en_US',
            child: Row(
              children: [
                CountryFlag.fromLanguageCode(
                  "en",
                  height: height/16.275,
                  width: width/45.53,
                ),
                SizedBox(width: width/136.6),
                const Text('English'),
              ],
            ),
            onTap: () {
              changeLocale(context, 'en_US');
              flagvalue= "en";
              langvalue='English';
              //changeHomeViewLanguage();
            },
          ),
          PopupMenuItem<String>(
            value: 'es',
            child: Row(
              children: [
                CountryFlag.fromLanguageCode(
                  "es",
                  height: height/16.275,
                  width: width/45.53,
                ),
                SizedBox(width: width/136.6),
                const Text('Spanish'),
              ],
            ),
            onTap: () {
              setState(() {
                changeLocale(context, 'es');
                flagvalue= "es";
                langvalue='Spanish';
                //changeHomeViewLanguage();
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'pt',
            child: Row(
              children: [
                CountryFlag.fromCountryCode(
                  "PT",
                  height: height/16.275,
                  width: width/45.53,
                ),
                SizedBox(width: width/136.6),
                const Text('Portuguese'),
              ],
            ),
            onTap: () {
              setState(() {
                changeLocale(context, 'pt');
                flagvalue= "PT";
                langvalue='Portuguese';
                //changeHomeViewLanguage();
              });
              setState(() {

              });
            },
          ),
          PopupMenuItem<String>(
            value: 'fr',
            child: Row(
              children: [
                CountryFlag.fromLanguageCode(
                  "fr",
                  height: height/16.275,
                  width: width/45.53,
                ),
                SizedBox(width: width/136.6),
                const Text('French'),
              ],
            ),
            onTap: () {
              setState(() {
                changeLocale(context, 'fr');
                flagvalue= "Fr";
                langvalue='French';
                //changeHomeViewLanguage();
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'nl',
            child: Row(
              children: [
                CountryFlag.fromCountryCode(
                  "NL",
                  height: height/16.275,
                  width: width/45.53,
                ),
                SizedBox(width: width/136.6),
                const Text('Dutch'),
              ],
            ),
            onTap: () {
              setState(() {
                changeLocale(context, 'nl');
                flagvalue= "NL";
                langvalue='Dutch';
                //changeHomeViewLanguage();
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'de',
            child: Row(
              children: [
                CountryFlag.fromLanguageCode(
                  "de",
                  height: height/16.275,
                  width: width/45.53,
                ),
                SizedBox(width: width/136.6),
                const Text('German'),
              ],
            ),
            onTap: () {
              setState(() {
                changeLocale(context, 'de');
                flagvalue= "de";
                langvalue='German';
                //changeHomeViewLanguage();
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'it',
            child: Row(
              children: [
                CountryFlag.fromLanguageCode(
                  "it",
                  height: height/16.275,
                  width: width/45.53,
                ),
                SizedBox(width: width/136.6),
                const Text('Italian'),
              ],
            ),
            onTap: () {
              setState(() {
                changeLocale(context, 'it');
                flagvalue= "it";
                langvalue='Italian';
                //changeHomeViewLanguage();
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'sv',
            child: Row(
              children: [
                CountryFlag.fromCountryCode(
                  "SE",
                  height: height/16.275,
                  width: width/45.53,
                ),
                SizedBox(width: width/136.6),
                const Text('Swedish'),
              ],
            ),
            onTap: () {
              setState(() {
                changeLocale(context, 'sv');
                flagvalue= "SE";
                langvalue='Swedish';
                //changeHomeViewLanguage();
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'ltz',
            child: Row(
              children: [
                CountryFlag.fromCountryCode(
                  "lu",
                  height: height/16.275,
                  width: width/45.53,
                ),
                SizedBox(width: width/136.6),
                const Text('Luxembourish'),
              ],
            ),
            onTap: () {
              setState(() {
                changeLocale(context, 'ltz');
                flagvalue= "lu";
                langvalue='Luxembourish';
                //changeHomeViewLanguage();
              });
            },
          ),
        ],
        elevation: 8.0,
        useRootNavigator: true);

    setState(() {

    });
  }

}
