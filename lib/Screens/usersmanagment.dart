import 'package:alumni_management_admin/utils.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class UsersManagement extends StatefulWidget {
  const UsersManagement({super.key});

  @override
  State<UsersManagement> createState() => _UsersManagementState();
}

class _UsersManagementState extends State<UsersManagement> {

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return FadeInRight(
      child: Container(
        // autogroupoqukgSD (T1ghpQWA8tTeNcoXbfoQUK)
        width: 1575*fem,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            /*  Container(
                // topbarpHX (8:1317)
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 7*fem),
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
                      // alumnimanagment6kq (8:1360)
                      margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 40*fem, 0*fem),
                      child: Text(
                        'Alumni Managment',
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
                      // searchbarofF (8:1356)
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
                            // magnifiertRo (8:1357)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 12*fem, 0*fem),
                            width: 24*fem,
                            height: 24*fem,
                            child: Image.asset(
                              'assets/images/magnifier.png',
                              width: 24*fem,
                              height: 24*fem,
                            ),
                          ),
                          Text(
                            // searchhereCxH (8:1359)
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
                      // languangeLYh (8:1319)
                      margin: EdgeInsets.fromLTRB(0*fem, 16.5*fem, 58*fem, 16.5*fem),
                      padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 7.06*fem, 0*fem),
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // textTNR (8:1320)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 23*fem, 0*fem),
                            padding: EdgeInsets.fromLTRB(0.75*fem, 0*fem, 0*fem, 0*fem),
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // united9m3 (8:1321)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.75*fem, 0*fem),
                                  width: 22.5*fem,
                                  height: 22.5*fem,
                                  child: Image.asset(
                                    'assets/images/united.png',
                                    width: 22.5*fem,
                                    height: 22.5*fem,
                                  ),
                                ),
                                Text(
                                  // engusQws (8:1337)
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
                            // chevrondown9Pf (8:1338)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                            width: 9.94*fem,
                            height: 6*fem,
                            child: Image.asset(
                              'assets/images/chevron-down.png',
                              width: 9.94*fem,
                              height: 6*fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // menuFBo (8:1340)
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // notificationsPoo (8:1349)
                            margin: EdgeInsets.fromLTRB(0*fem, 2*fem, 24*fem, 0*fem),
                            width: 48*fem,
                            height: 48*fem,
                            child: Image.asset(
                              'assets/images/notifications.png',
                              width: 48*fem,
                              height: 48*fem,
                            ),
                          ),
                          Container(
                            // group1000002734i5P (8:1341)
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // rectangle139349F (8:1342)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 20*fem, 0*fem),
                                  width: 60*fem,
                                  height: 60*fem,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16*fem),
                                    child: Image.asset(
                                      'assets/images/rectangle-1393.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  // group21862Me9 (8:1343)
                                  margin: EdgeInsets.fromLTRB(0*fem, 6*fem, 0*fem, 6*fem),
                                  width: 124*fem,
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // autogroupw2mqssP (T1gm24fofjnFtrqGMVw2mq)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // dinesh1To (8:1348)
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
                                              // group21861XS9 (8:1344)
                                              width: 16*fem,
                                              height: 16*fem,
                                              child: Image.asset(
                                                'assets/images/group-21861-2hF.png',
                                                width: 16*fem,
                                                height: 16*fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        // admin3vH (8:1347)
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
              ),*/
              Container(
                // autogroupnqzdo8m (T1gi69YvmcjfWeTh5WNqZd)
                width: 1554*fem,
                height: 1173.32*fem,
                child: Stack(
                  children: [
                    Positioned(
                      // profilebgvUH (8:2063)
                      left: 1160.28515625*fem,
                      top: 0*fem,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(31.29*fem, 80.83*fem, 32.59*fem, 412.32*fem),
                        width: 393.71*fem,
                        height: 1173.32*fem,
                        decoration: BoxDecoration (
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10*fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // profilenamemjo (8:2065)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 51.65*fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // imgbgtZX (8:2072)
                                    margin: EdgeInsets.fromLTRB(119.94*fem, 0*fem, 118.64*fem, 20.91*fem),
                                    width: double.infinity,
                                    height: 91.26*fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // bgD61 (8:2073)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 91.26*fem,
                                              height: 91.26*fem,
                                              child: Image.asset(
                                                'assets/images/bg.png',
                                                width: 91.26*fem,
                                                height: 91.26*fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // ellipse587x5 (8:2076)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 91.26*fem,
                                              height: 91.26*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(45.6291923523*fem),
                                                  image: DecorationImage (
                                                    image: AssetImage (
                                                      'assets/images/ellipse-58-bg.png',
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
                                  Container(
                                    // prakashdeoP8u (8:2071)
                                    margin: EdgeInsets.fromLTRB(6.02*fem, 0*fem, 0*fem, 8*fem),
                                    child: Text(
                                      'Prakash Deo',
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 22*ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xff030229),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // uiuxdesignergth (8:2069)
                                    margin: EdgeInsets.fromLTRB(8.02*fem, 0*fem, 0*fem, 47.55*fem),
                                    child: Text(
                                      'UI/UX Designer',
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 14*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xff030229),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // linezuP (8:2066)
                                    width: 329.83*fem,
                                    height: 0.5*fem,
                                    child: Image.asset(
                                      'assets/images/line-s1T.png',
                                      width: 329.83*fem,
                                      height: 0.5*fem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // contactinfoXuK (8:2109)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 24.77*fem, 68.12*fem),
                              width: 302.46*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // autogroupndnkSWV (T1gj4sRR27hYZoCNm3ndnK)
                                    padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 26.07*fem),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // contactinfomYm (8:2134)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 40.18*fem),
                                          child: Text(
                                            'Contact Info',
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 18*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // emailH1K (8:2126)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 79.26*fem, 0*fem),
                                          width: double.infinity,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Opacity(
                                                // messagezwK (8:2129)
                                                opacity: 0.3,
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.34*fem, 0*fem),
                                                  width: 20.86*fem,
                                                  height: 19.56*fem,
                                                  child: Image.asset(
                                                    'assets/images/message.png',
                                                    width: 20.86*fem,
                                                    height: 19.56*fem,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // kajope5182ummohcom5xm (8:2128)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1.47*fem),
                                                child: Text(
                                                  'kajope5182@ummoh.com',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 16*ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff030229),
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
                                    // autogroup8z8fNws (T1giYoTBaTc7Nkx6Vd8Z8F)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 25.57*fem),
                                    width: double.infinity,
                                    height: 72.2*fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // line7Pf (8:2118)
                                          left: 0*fem,
                                          top: 0*fem,
                                          child: Container(
                                            width: 302.46*fem,
                                            height: 72.2*fem,
                                          ),
                                        ),
                                        Positioned(
                                          // phonenumberr6M (8:2121)
                                          left: 0*fem,
                                          top: 26.0738296509*fem,
                                          child: Container(
                                            width: 141.2*fem,
                                            height: 23.47*fem,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Opacity(
                                                  // call9r9 (8:2124)
                                                  opacity: 0.3,
                                                  child: Container(
                                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.34*fem, 0*fem),
                                                    width: 20.86*fem,
                                                    height: 20.86*fem,
                                                    child: Image.asset(
                                                      'assets/images/call.png',
                                                      width: 20.86*fem,
                                                      height: 20.86*fem,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  // SqF (8:2123)
                                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1.47*fem),
                                                  child: Text(
                                                    '33757005467',
                                                    style: SafeGoogleFont (
                                                      'Nunito',
                                                      fontSize: 16*ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.3625*ffem/fem,
                                                      color: Color(0xff030229),
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
                                    // locationxob (8:2110)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 102.26*fem, 0*fem),
                                    width: double.infinity,
                                    height: 50.68*fem,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Opacity(
                                          // locationUmw (8:2114)
                                          opacity: 0.3,
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(0*fem, 5.21*fem, 16.95*fem, 0*fem),
                                            width: 18.25*fem,
                                            height: 22.16*fem,
                                            child: Image.asset(
                                              'assets/images/location.png',
                                              width: 18.25*fem,
                                              height: 22.16*fem,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // textP8D (8:2111)
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // hogcamproadLJM (8:2112)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6.68*fem),
                                                child: Text(
                                                  '2239  Hog Camp Road',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 16*ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff030229),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                // schaumburgE8q (8:2113)
                                                'Schaumburg',
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 16*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff030229),
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
                              // group649mPf (10:82)
                              margin: EdgeInsets.fromLTRB(64.43*fem, 0*fem, 64.41*fem, 19*fem),
                              width: double.infinity,
                              height: 30*fem,
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(22.5*fem),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    // rectangle186fzq (10:83)
                                    left: 17.8403320312*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 166.51*fem,
                                        height: 30*fem,
                                        child: Container(
                                          decoration: BoxDecoration (
                                            borderRadius: BorderRadius.circular(22.5*fem),
                                            color: Color(0xff26c0e2),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // downloadimagesAAu (10:84)
                                    left: 35*fem,
                                    top: 4*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 131*fem,
                                        height: 22*fem,
                                        child: Text(
                                          'Download Images',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3625*ffem/fem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // group6502iu (10:85)
                              margin: EdgeInsets.fromLTRB(50.43*fem, 0*fem, 52.41*fem, 0*fem),
                              width: double.infinity,
                              height: 30*fem,
                              decoration: BoxDecoration (
                                color: Color(0xffffd56b),
                                borderRadius: BorderRadius.circular(22.5*fem),
                              ),
                              child: Center(
                                child: Text(
                                  'Download Documents',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont (
                                    'Nunito',
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3625*ffem/fem,
                                    color: Color(0xff030229),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // bgsjX (8:2231)
                      left: 0*fem,
                      top: 349.389251709*fem,
                      child: Container(
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
                            Container(
                              // imgbgjFw (8:2246)
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
                                        image: AssetImage (
                                          'assets/images/img-bg-EKT.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // robertbacinsxeV (8:2245)
                              margin: EdgeInsets.fromLTRB(0*fem, 4.14*fem, 129.49*fem, 0*fem),
                              child: Text(
                                'Robert Bacins',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // robertbacins4182com4xR (8:2243)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 158.21*fem, 1.07*fem),
                              child: Text(
                                'robertbacins4182@.com',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // afs (8:2241)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 75.98*fem, 1.07*fem),
                              child: Text(
                                '+33757005467',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // buttonVH3 (8:2237)
                              margin: EdgeInsets.fromLTRB(0*fem, 1.3*fem, 91.26*fem, 2.61*fem),
                              width: 86.04*fem,
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
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3625*ffem/fem,
                                    color: Color(0xff5b92ff),
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              // menu96h (8:2233)
                              opacity: 0.3,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.65*fem),
                                width: 18.25*fem,
                                height: 4.56*fem,
                                child: Image.asset(
                                  'assets/images/menu-fRb.png',
                                  width: 18.25*fem,
                                  height: 4.56*fem,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // bg2gH (10:7)
                      left: 0*fem,
                      top: 455*fem,
                      child: Container(
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
                            Container(
                              // imgbgV45 (10:22)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.34*fem, 0*fem),
                              width: 39.11*fem,
                              height: double.infinity,
                              decoration: BoxDecoration (
                                color: Color(0xfff6d0d0),
                                borderRadius: BorderRadius.circular(19.5553703308*fem),
                              ),
                              child: Center(
                                // imgbN1 (10:24)
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 39.11*fem,
                                  child: Container(
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(19.5553703308*fem),
                                      image: DecorationImage (
                                        fit: BoxFit.cover,
                                        image: AssetImage (
                                          'assets/images/img-bg-8Ro.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // robertbacinsTv1 (10:21)
                              margin: EdgeInsets.fromLTRB(0*fem, 4.14*fem, 129.49*fem, 0*fem),
                              child: Text(
                                'Robert Bacins',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // robertbacins4182comxbs (10:19)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 158.21*fem, 1.07*fem),
                              child: Text(
                                'robertbacins4182@.com',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // qvZ (10:17)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 75.98*fem, 1.07*fem),
                              child: Text(
                                '+33757005467',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // buttonxEV (10:13)
                              margin: EdgeInsets.fromLTRB(0*fem, 1.3*fem, 91.26*fem, 2.61*fem),
                              width: 86.04*fem,
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
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3625*ffem/fem,
                                    color: Color(0xff5b92ff),
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              // menu1Tf (10:9)
                              opacity: 0.3,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.65*fem),
                                width: 18.25*fem,
                                height: 4.56*fem,
                                child: Image.asset(
                                  'assets/images/menu-CM7.png',
                                  width: 18.25*fem,
                                  height: 4.56*fem,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // bgVNq (8:2250)
                      left: 0*fem,
                      top: 258.1308898926*fem,
                      child: Container(
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
                            Container(
                              // imgbgYc1 (8:2254)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.34*fem, 0*fem),
                              width: 39.11*fem,
                              height: double.infinity,
                              decoration: BoxDecoration (
                                color: Color(0xffcbeaf0),
                                borderRadius: BorderRadius.circular(19.5553703308*fem),
                              ),
                              child: Center(
                                // imgGH7 (8:2256)
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 39.11*fem,
                                  child: Container(
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(19.5553703308*fem),
                                      image: DecorationImage (
                                        image: AssetImage (
                                          'assets/images/img-bg-iG9.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // shelbygoodeNqw (8:2253)
                              margin: EdgeInsets.fromLTRB(0*fem, 4.14*fem, 128.49*fem, 0*fem),
                              child: Text(
                                'Shelby Goode',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // shelbygoode481gmailcomfq3 (8:2264)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 121.21*fem, 1.07*fem),
                              child: Text(
                                'shelbygoode481@gmail.com',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // NUZ (8:2262)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 75.98*fem, 1.07*fem),
                              child: Text(
                                '+33757005467',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // buttontSu (8:2265)
                              margin: EdgeInsets.fromLTRB(0*fem, 1.3*fem, 79.53*fem, 2.61*fem),
                              width: 97.78*fem,
                              height: double.infinity,
                              decoration: BoxDecoration (
                                border: Border.all(color: Color(0x19fff4f0)),
                                color: Color(0x19ff8f6b),
                                borderRadius: BorderRadius.circular(33*fem),
                              ),
                              child: Center(
                                child: Text(
                                  'Female',
                                  style: SafeGoogleFont (
                                    'Nunito',
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3625*ffem/fem,
                                    color: Color(0xffff8f6b),
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              // menuYnM (8:2257)
                              opacity: 0.3,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.65*fem),
                                width: 18.25*fem,
                                height: 4.56*fem,
                                child: Image.asset(
                                  'assets/images/menu-wff.png',
                                  width: 18.25*fem,
                                  height: 4.56*fem,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // table1e4h (8:2268)
                      left: 0*fem,
                      top: 166.8724975586*fem,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(26.07*fem, 19.56*fem, 39.11*fem, 19.56*fem),
                        width: 1119.87*fem,
                        height: 78.22*fem,
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
                              // imagebg48R (8:2272)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.34*fem, 0*fem),
                              width: 39.11*fem,
                              height: double.infinity,
                              decoration: BoxDecoration (
                                color: Color(0xffe4e1fb),
                                borderRadius: BorderRadius.circular(19.5553703308*fem),
                              ),
                              child: Center(
                                // imageaMf (8:2274)
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 39.11*fem,
                                  child: Container(
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(19.5553703308*fem),
                                      image: DecorationImage (
                                        image: AssetImage (
                                          'assets/images/image-bg.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // johndeoVUd (8:2271)
                              margin: EdgeInsets.fromLTRB(0*fem, 4.14*fem, 168.49*fem, 0*fem),
                              child: Text(
                                'John Deo',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // johndoe2211gmailcomp17 (8:2283)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 149.21*fem, 1.07*fem),
                              child: Text(
                                'johndoe2211@gmail.com',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // XgD (8:2281)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 75.98*fem, 1.07*fem),
                              child: Text(
                                '+33757005467',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // buttonFMK (8:2284)
                              margin: EdgeInsets.fromLTRB(0*fem, 2.61*fem, 91.26*fem, 1.3*fem),
                              width: 86.04*fem,
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
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3625*ffem/fem,
                                    color: Color(0xff5b92ff),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // menu6Mw (8:2275)
                              margin: EdgeInsets.fromLTRB(0*fem, 0.65*fem, 0*fem, 0*fem),
                              width: 18.25*fem,
                              height: 4.56*fem,
                              child: Image.asset(
                                'assets/images/menu-GAd.png',
                                width: 18.25*fem,
                                height: 4.56*fem,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*Positioned(
                      // editdeletebZb (8:2287)
                      left: 1062.5083007812*fem,
                      top: 221.6275024414*fem,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(13.04*fem, 13.04*fem, 13.04*fem, 13.04*fem),
                        width: 143.41*fem,
                        height: 102.99*fem,
                        decoration: BoxDecoration (
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10*fem),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x19000000),
                              offset: Offset(0*fem, 10*fem),
                              blurRadius: 10*fem,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // edit2uo (8:2289)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6.52*fem),
                              padding: EdgeInsets.fromLTRB(13.36*fem, 9.13*fem, 63.04*fem, 8.07*fem),
                              width: double.infinity,
                              decoration: BoxDecoration (
                                color: Color(0x0c5b92ff),
                                borderRadius: BorderRadius.circular(5*fem),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // editKP7 (8:2292)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0.25*fem, 8.15*fem, 0*fem),
                                    width: 9.78*fem,
                                    height: 9.78*fem,
                                    child: Image.asset(
                                      'assets/images/edit.png',
                                      width: 9.78*fem,
                                      height: 9.78*fem,
                                    ),
                                  ),
                                  Text(
                                    // editct1 (8:2291)
                                    'Edit',
                                    style: SafeGoogleFont (
                                      'Nunito',
                                      fontSize: 13*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3625*ffem/fem,
                                      color: Color(0xff5b92ff),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // deleteMKo (8:2296)
                              padding: EdgeInsets.fromLTRB(13.36*fem, 9.13*fem, 47.04*fem, 8.07*fem),
                              width: double.infinity,
                              decoration: BoxDecoration (
                                color: Color(0x0ce71d36),
                                borderRadius: BorderRadius.circular(5*fem),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // iconlybolddeleteFg5 (8:2298)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0.25*fem, 8.15*fem, 0*fem),
                                    width: 9.78*fem,
                                    height: 10.86*fem,
                                    child: Image.asset(
                                      'assets/images/iconly-bold-delete.png',
                                      width: 9.78*fem,
                                      height: 10.86*fem,
                                    ),
                                  ),
                                  Text(
                                    // deleteZRs (8:2303)
                                    'Delete',
                                    style: SafeGoogleFont (
                                      'Nunito',
                                      fontSize: 13*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3625*ffem/fem,
                                      color: Color(0xffe71d36),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),*/
                    Positioned(
                      // tableheadingVqK (8:2304)
                      left: 26.0738525391*fem,
                      top: 132.9764709473*fem,
                      child: Container(
                        width: 932.14*fem,
                        height: 21*fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // nameDFX (8:2305)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 233.36*fem, 0*fem),
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // namekWM (8:2306)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.75*fem, 0*fem),
                                    child: Text(
                                      'Name',
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 15*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xff030229),
                                      ),
                                    ),
                                  ),
                                  Opacity(
                                    // arrowdown2TvZ (8:2307)
                                    opacity: 0.7,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0*fem, 1.6*fem, 0*fem, 0*fem),
                                      width: 7.82*fem,
                                      height: 6.52*fem,
                                      child: Image.asset(
                                        'assets/images/arrow-down-2.png',
                                        width: 7.82*fem,
                                        height: 6.52*fem,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // emailYqX (8:2309)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 297.24*fem, 0*fem),
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // emailfv9 (8:2312)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.15*fem, 0*fem),
                                    child: Text(
                                      'Email',
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 15*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xff030229),
                                      ),
                                    ),
                                  ),
                                  Opacity(
                                    // arrowdown3b37 (8:2310)
                                    opacity: 0.7,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0*fem, 1.6*fem, 0*fem, 0*fem),
                                      width: 7.82*fem,
                                      height: 6.52*fem,
                                      child: Image.asset(
                                        'assets/images/arrow-down-3.png',
                                        width: 7.82*fem,
                                        height: 6.52*fem,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // phonenumbergKT (8:2313)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 80.83*fem, 0*fem),
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // phonenumberntH (8:2316)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 18.33*fem, 0*fem),
                                    child: Text(
                                      'Phone number',
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 15*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xff030229),
                                      ),
                                    ),
                                  ),
                                  Opacity(
                                    // arrowdown46e5 (8:2314)
                                    opacity: 0.7,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0*fem, 1.6*fem, 0*fem, 0*fem),
                                      width: 7.82*fem,
                                      height: 6.52*fem,
                                      child: Image.asset(
                                        'assets/images/arrow-down-4.png',
                                        width: 7.82*fem,
                                        height: 6.52*fem,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // genderyxm (8:2317)
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // gender8qf (8:2320)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 15.18*fem, 0*fem),
                                    child: Text(
                                      'Gender',
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 15*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xff030229),
                                      ),
                                    ),
                                  ),
                                  Opacity(
                                    // arrowdown5rFs (8:2318)
                                    opacity: 0.7,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0*fem, 1.6*fem, 0*fem, 0*fem),
                                      width: 7.82*fem,
                                      height: 6.52*fem,
                                      child: Image.asset(
                                        'assets/images/arrow-down-5.png',
                                        width: 7.82*fem,
                                        height: 6.52*fem,
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
                    Positioned(
                      // hedingbuttonLgq (8:2321)
                      left: 0*fem,
                      top: 39.110748291*fem,
                      child: Container(
                        width: 1118.57*fem,
                        height: 54.76*fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // alumnilistFYu (8:2323)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 775.46*fem, 6.11*fem),
                              child: Text(
                                'Alumni List',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 24*ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                            Container(
                              // bgmXF (8:2325)
                              padding: EdgeInsets.fromLTRB(26.07*fem, 17.04*fem, 56.96*fem, 12.72*fem),
                              height: double.infinity,
                              decoration: BoxDecoration (
                                color: Color(0xff605bff),
                                borderRadius: BorderRadius.circular(10*fem),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // plusUAm (8:2329)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 21.04*fem, 4.32*fem),
                                    width: 13.04*fem,
                                    height: 13.04*fem,
                                    child: Image.asset(
                                      'assets/images/plus.png',
                                      width: 13.04*fem,
                                      height: 13.04*fem,
                                    ),
                                  ),
                                  Text(
                                    // addalumniytD (8:2328)
                                    'Add Alumni',
                                    style: SafeGoogleFont (
                                      'Nunito',
                                      fontSize: 18*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3625*ffem/fem,
                                      color: Color(0xffffffff),
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
      ),
    );
  }
}
