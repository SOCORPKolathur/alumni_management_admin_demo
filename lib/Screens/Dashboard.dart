import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int dawer = 0;
  var pages;
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
        width: 1575*fem,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // topbar7QD (6:110)
                padding: EdgeInsets.fromLTRB(40*fem, 30*fem, 66*fem, 30*fem),
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
                      child: Text(
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
                    Container(
                      // searchbarvMf (6:149)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 58*fem, 0*fem),
                      padding: EdgeInsets.fromLTRB(28*fem, 16.5*fem, 329*fem, 16.5*fem),
                      height: double.infinity,
                      decoration: BoxDecoration (
                        color: Color(0xfff9fafb),
                        borderRadius: BorderRadius.circular(16*fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // magnifierD5s (6:150)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 12*fem, 0*fem),
                            width: 24*fem,
                            height: 24*fem,
                            child: Image.asset(
                              'assets/images/magnifier-27s.png',
                              width: 24*fem,
                              height: 24*fem,
                            ),
                          ),
                          Text(
                            // searchherevW5 (6:152)
                            'Search here...',
                            style: SafeGoogleFont (
                              'Poppins',
                              fontSize: 18*ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5*ffem/fem,
                              color: Color(0xff737791),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
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
                                  child: Image.asset(
                                    'assets/images/united-j1s.png',
                                    width: 22.5*fem,
                                    height: 22.5*fem,
                                  ),
                                ),
                                Text(
                                  // engusYQy (6:130)
                                  'Eng (US)',
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
                          Container(
                            // chevrondown5A1 (6:131)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                            width: 9.94*fem,
                            height: 6*fem,
                            child: Image.asset(
                              'assets/images/chevron-down-1wo.png',
                              width: 9.94*fem,
                              height: 6*fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // menuaMf (6:133)
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
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
                          Container(
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
                                  width: 124*fem,
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
                                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 53*fem, 0*fem),
                                              child: Text(
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
                                            Container(
                                              // group2186132H (6:137)
                                              width: 16*fem,
                                              height: 16*fem,
                                              child: Image.asset(
                                                'assets/images/group-21861-oGV.png',
                                                width: 16*fem,
                                                height: 16*fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
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
                        padding: EdgeInsets.fromLTRB(31*fem, 23*fem, 39*fem, 28*fem),
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
                                          child: Text(
                                            'Dashboard',
                                            style: SafeGoogleFont (
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
                                          child: Text(
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
                                          child: Text(
                                            '1660',
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        Text(
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
                                          child: Text(
                                            '849',
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        Text(
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
                                          child: Text(
                                            '598',
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        Text(
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
                                          child: Text(
                                            '45',
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        Text(
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
                                          child: Text(
                                            '60',
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        Text(
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
                      margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 26*fem, 33*fem),
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
                                      child: Text(
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
                                    child: Text(
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
                                      child: Text(
                                        '0',
                                        textAlign: TextAlign.right,
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
                                      child: Text(
                                        '100',
                                        textAlign: TextAlign.right,
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
                                      child: Text(
                                        '200',
                                        textAlign: TextAlign.right,
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
                                      child: Text(
                                        '300',
                                        textAlign: TextAlign.right,
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
                                      child: Text(
                                        '400',
                                        textAlign: TextAlign.right,
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
                                      child: Text(
                                        'Jan',
                                        textAlign: TextAlign.center,
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
                                      child: Text(
                                        'Feb',
                                        textAlign: TextAlign.center,
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
                                      child: Text(
                                        'Mar',
                                        textAlign: TextAlign.center,
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
                                      child: Text(
                                        'Apr',
                                        textAlign: TextAlign.center,
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
                                      child: Text(
                                        'May',
                                        textAlign: TextAlign.center,
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
                                      child: Text(
                                        'Jun',
                                        textAlign: TextAlign.center,
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
                                      child: Text(
                                        'Jun',
                                        textAlign: TextAlign.center,
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
                                      child: Text(
                                        'Jul',
                                        textAlign: TextAlign.center,
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
                                      child: Text(
                                        'Sept',
                                        textAlign: TextAlign.center,
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
                                      child: Text(
                                        'Oct',
                                        textAlign: TextAlign.center,
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
                                      child: Text(
                                        'Nov',
                                        textAlign: TextAlign.center,
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
                                      child: Text(
                                        'Des',
                                        textAlign: TextAlign.center,
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
                                              Text(
                                                // loyalcustomerswvh (6:270)
                                                'Alumnus',
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
                                              Text(
                                                // newcustomers8VP (6:266)
                                                'Students',
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
                                              Text(
                                                // uniquecustomersjEH (6:262)
                                                'Connections',
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
                      child: Text(
                        'Alumni\'s Waiting for Verification ',
                        style: SafeGoogleFont (
                          'Poppins',
                          fontSize: 20*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6*ffem/fem,
                          color: Color(0xff05004e),
                        ),
                      ),
                    ),
                    Container(
                      // table1mwf (8:1251)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 41.33*fem, 16.85*fem),
                      padding: EdgeInsets.fromLTRB(33.71*fem, 25.28*fem, 50.56*fem, 25.28*fem),
                      height: 101.12*fem,
                      decoration: BoxDecoration (
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10*fem),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x11030229),
                            offset: Offset(1*fem, 17*fem),
                            blurRadius: 22*fem,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // imagebgkYh (8:1255)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 18.74*fem, 0*fem),
                            width: 50.56*fem,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              color: Color(0xffe4e1fb),
                              borderRadius: BorderRadius.circular(25.2794094086*fem),
                            ),
                            child: Center(
                              // imageETs (8:1257)
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.56*fem,
                                child: Container(
                                  decoration: BoxDecoration (
                                    borderRadius: BorderRadius.circular(25.2794094086*fem),
                                    image: DecorationImage (
                                      image: AssetImage (
                                        'assets/images/image-bg-V93.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // johndeoLG1 (8:1254)
                            margin: EdgeInsets.fromLTRB(0*fem, 5.88*fem, 214.27*fem, 0*fem),
                            child: Text(
                              'John Deo',
                              style: SafeGoogleFont (
                                'Nunito',
                                fontSize: 24*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3625*ffem/fem,
                                color: Color(0xff030229),
                              ),
                            ),
                          ),
                          Container(
                            // johndoe2211gmailcom2uX (8:1266)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 207.77*fem, 3.71*fem),
                            child: Text(
                              'johndoe2211@gmail.com',
                              style: SafeGoogleFont (
                                'Nunito',
                                fontSize: 22*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3625*ffem/fem,
                                color: Color(0xff030229),
                              ),
                            ),
                          ),
                          Container(
                            // 8hf (8:1264)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 107.28*fem, 3.71*fem),
                            child: Text(
                              '+33757005467',
                              style: SafeGoogleFont (
                                'Nunito',
                                fontSize: 22*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3625*ffem/fem,
                                color: Color(0xff030229),
                              ),
                            ),
                          ),
                          Container(
                            // buttonr7s (8:1267)
                            margin: EdgeInsets.fromLTRB(0*fem, 3.37*fem, 117.97*fem, 1.69*fem),
                            width: 111.23*fem,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              color: Color(0x195b92ff),
                              borderRadius: BorderRadius.circular(33*fem),
                            ),
                            child: Center(
                              child: Text(
                                'Male',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 22*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff5b92ff),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // menug6u (8:1258)
                            margin: EdgeInsets.fromLTRB(0*fem, 0.84*fem, 0*fem, 0*fem),
                            width: 23.59*fem,
                            height: 5.9*fem,
                            child: Image.asset(
                              'assets/images/menu-ZtM.png',
                              width: 23.59*fem,
                              height: 5.9*fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // bgLSM (8:1233)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 41.33*fem, 16.85*fem),
                      padding: EdgeInsets.fromLTRB(33.71*fem, 25.28*fem, 50.56*fem, 25.28*fem),
                      height: 101.12*fem,
                      decoration: BoxDecoration (
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10*fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // imgbgc8y (8:1237)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 18.74*fem, 0*fem),
                            width: 50.56*fem,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              color: Color(0xffcbeaf0),
                              borderRadius: BorderRadius.circular(25.2794094086*fem),
                            ),
                            child: Center(
                              // imgjDb (8:1239)
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.56*fem,
                                child: Container(
                                  decoration: BoxDecoration (
                                    borderRadius: BorderRadius.circular(25.2794094086*fem),
                                    image: DecorationImage (
                                      image: AssetImage (
                                        'assets/images/img-bg-Hf7.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // shelbygoodedpm (8:1236)
                            margin: EdgeInsets.fromLTRB(0*fem, 5.94*fem, 161.27*fem, 0*fem),
                            child: Text(
                              'Shelby Goode',
                              style: SafeGoogleFont (
                                'Nunito',
                                fontSize: 24*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3625*ffem/fem,
                                color: Color(0xff030229),
                              ),
                            ),
                          ),
                          Container(
                            // shelbygoode481gmailcomLUH (8:1247)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 172.77*fem, 3.71*fem),
                            child: Text(
                              'shelbygoode481@gmail.com',
                              style: SafeGoogleFont (
                                'Nunito',
                                fontSize: 22*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3625*ffem/fem,
                                color: Color(0xff030229),
                              ),
                            ),
                          ),
                          Container(
                            // 3Nh (8:1245)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 107.28*fem, 3.71*fem),
                            child: Text(
                              '+33757005467',
                              style: SafeGoogleFont (
                                'Nunito',
                                fontSize: 22*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3625*ffem/fem,
                                color: Color(0xff030229),
                              ),
                            ),
                          ),
                          Container(
                            // button6Ly (8:1248)
                            margin: EdgeInsets.fromLTRB(0*fem, 1.69*fem, 102.8*fem, 3.37*fem),
                            width: 126.4*fem,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              color: Color(0x19ff8f6b),
                              borderRadius: BorderRadius.circular(33*fem),
                            ),
                            child: Center(
                              child: Text(
                                'Female',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 22*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xffff8f6b),
                                ),
                              ),
                            ),
                          ),
                          Opacity(
                            // menuvqo (8:1240)
                            opacity: 0.3,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.84*fem),
                              width: 23.59*fem,
                              height: 5.9*fem,
                              child: Image.asset(
                                'assets/images/menu-YU9.png',
                                width: 23.59*fem,
                                height: 5.9*fem,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // bgpAV (8:1214)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 41.33*fem, 0*fem),
                      padding: EdgeInsets.fromLTRB(33.71*fem, 25.28*fem, 50.56*fem, 25.28*fem),
                      height: 101.12*fem,
                      decoration: BoxDecoration (
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10*fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // imgbgTz9 (8:1229)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 18.74*fem, 0*fem),
                            width: 50.56*fem,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              color: Color(0xfff6d0d0),
                              borderRadius: BorderRadius.circular(25.2794094086*fem),
                            ),
                            child: Center(
                              // imgP77 (8:1231)
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.56*fem,
                                child: Container(
                                  decoration: BoxDecoration (
                                    borderRadius: BorderRadius.circular(25.2794094086*fem),
                                    image: DecorationImage (
                                      fit: BoxFit.cover,
                                      image: AssetImage (
                                        'assets/images/img-bg-yU5.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // robertbacinsTMs (8:1228)
                            margin: EdgeInsets.fromLTRB(0*fem, 6*fem, 162.27*fem, 0*fem),
                            child: Text(
                              'Robert Bacins',
                              style: SafeGoogleFont (
                                'Nunito',
                                fontSize: 24*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3625*ffem/fem,
                                color: Color(0xff030229),
                              ),
                            ),
                          ),
                          Container(
                            // robertbacins4182comjKP (8:1226)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 218.77*fem, 3.71*fem),
                            child: Text(
                              'robertbacins4182@.com',
                              style: SafeGoogleFont (
                                'Nunito',
                                fontSize: 22*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3625*ffem/fem,
                                color: Color(0xff030229),
                              ),
                            ),
                          ),
                          Container(
                            // 1nh (8:1224)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 107.28*fem, 3.71*fem),
                            child: Text(
                              '+33757005467',
                              style: SafeGoogleFont (
                                'Nunito',
                                fontSize: 22*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3625*ffem/fem,
                                color: Color(0xff030229),
                              ),
                            ),
                          ),
                          Container(
                            // buttonvuf (8:1220)
                            margin: EdgeInsets.fromLTRB(0*fem, 1.69*fem, 117.97*fem, 3.37*fem),
                            width: 111.23*fem,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              color: Color(0x195b92ff),
                              borderRadius: BorderRadius.circular(33*fem),
                            ),
                            child: Center(
                              child: Text(
                                'Male',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 22*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff5b92ff),
                                ),
                              ),
                            ),
                          ),
                          Opacity(
                            // menuP2Z (8:1216)
                            opacity: 0.3,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.84*fem),
                              width: 23.59*fem,
                              height: 5.9*fem,
                              child: Image.asset(
                                'assets/images/menu-pSu.png',
                                width: 23.59*fem,
                                height: 5.9*fem,
                              ),
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
    );
  }
}
