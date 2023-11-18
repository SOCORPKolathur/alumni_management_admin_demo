import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/Language_Model.dart';
import '../utils.dart';

class Users_Screen extends StatefulWidget {
  const Users_Screen({super.key});

  @override
  State<Users_Screen> createState() => _Users_ScreenState();
}

class _Users_ScreenState extends State<Users_Screen> {

  bool viewUser_details=false;
  GlobalKey floatingKey = LabeledGlobalKey("Floating");
  bool isFloatingOpen = false;
  OverlayEntry ?floating;

  String viewDocid="";


  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return FadeInRight(
      child: Container(
        width: 1574*fem,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: width/170.75,
              vertical: height/81.375
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width:width/1.6457,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      ///Alumni text
                      SizedBox(height:height/26.04),
                      Row(
                        children: [
                          SizedBox(
                            width:width/1.6457,
                            height: 54.96*fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // alumnilistFYu (8:2323)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 775.46*fem, 6.11*fem),
                                  child:
                                  KText(
                                    text: 'Alumni List',
                                    style: SafeGoogleFont (
                                      'Nunito',
                                      fontSize: 24*ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.3625*ffem/fem,
                                      color: Color(0xff030229),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: (){
                                    print("Clikeddddddd");

                                  },
                                  child: Container(
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
                                        KText(
                                          // addalumniytD (8:2328)
                                          text:'Add Alumni',
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:height/26.04),
                      ///stream titles text
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(26.07*fem, 19.56*fem, 39.11*fem, 19.56*fem),
                            width: 1119.87*fem,
                            height: 55.22*fem,

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(

                                  width:width/6.83,
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // namekWM (8:2306)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.75*fem, 0*fem),
                                        child: KText(
                                          text:'Name',
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
                                SizedBox(

                                  width:width/6.83,
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // emailfv9 (8:2312)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.15*fem, 0*fem),
                                        child: KText(
                                          text: 'Email',
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
                                SizedBox(

                                  width:width/9.1066,
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // phonenumberntH (8:2316)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 18.33*fem, 0*fem),
                                        child: KText(
                                          text: 'Phone number',
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
                                SizedBox(
                                  width:width/9.1066,
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width:width/54.64),
                                      Container(
                                        // gender8qf (8:2320)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 15.18*fem, 0*fem),
                                        child: KText(
                                          text:'Gender',
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
                                SizedBox(width:width/27.32),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:height/65.1),
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
                                      width:width/6.83,
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
                                              text: _userdata['Name'],
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
                                      width:width/6.83,
                                      child: KText(
                                        text: _userdata['Email'],
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
                                      width:width/9.1066,
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
                                      width:width/9.1066,
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
                                              text:   _userdata['Gender'],
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
                                    GestureDetector(
                                      onTap: (){
                                        print("heloeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                                        print(isFloatingOpen);
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
                                        print(viewUser_details);
                                      },
                                      child: SizedBox(
                                        width:width/27.32,
                                        height:height/26.04,
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.65*fem),
                                          width: 18.25*fem,
                                          height: 15.56*fem,
                                         decoration: BoxDecoration(
                                           color:Color(0xff605bff),
                                           borderRadius: BorderRadius.circular(5)
                                         ),
                                          child: Center(child: KText(
                                            text:  viewUser_details?"Close":
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
                            },);
                        },),
                    ],
                  ),
                ),
                viewUser_details==true?
                SlideInRight(
                  duration: Duration(milliseconds: 500),
                  from:viewUser_details==true? 500:-100,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(31.29*fem, 80.83*fem, 32.59*fem, 412.32*fem),
                    width: 353.71*fem,
                    height: 1163.32*fem,
                    decoration: BoxDecoration (
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(10*fem),
                    ),
                    child:
                    FutureBuilder(
                        future: FirebaseFirestore.instance.collection("Users").doc(viewDocid).get(),
                        builder: (context, snapshot) {

                          if(!snapshot.hasData){
                            return const Center(child: CircularProgressIndicator(),);
                          }
                          if(snapshot.hasData==null){
                            return const Center(child: CircularProgressIndicator(),);
                          }

                          var getdata=snapshot.data;

                          return  Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 51.65*fem),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // imgbgtZX (8:2072)
                                      margin: EdgeInsets.fromLTRB(99.94*fem, 0*fem, 99.64*fem, 20.91*fem),
                                      width: width/4.5533,
                                      height: 91.26*fem,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF7F7F8),
                                          borderRadius: BorderRadius.circular(100)
                                      ),

                                      child: Image.network(getdata!['UserImg']),
                                    ),
                                    Container(
                                      // prakashdeoP8u (8:2071)
                                      margin: EdgeInsets.fromLTRB(6.02*fem, 0*fem, 0*fem, 8*fem),
                                      child: KText(
                                        text:  getdata['Name'],
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
                                      child: KText(
                                        text:  getdata['Occupation'],
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 14*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff030229),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
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
                                            child: KText(
                                              text: 'Contact Info',
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: 18*ffem,
                                                fontWeight: FontWeight.w600,
                                                height: 1.3625*ffem/fem,
                                                color: Color(0xff030229),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 302.46*fem,
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
                                                KText(
                                                  text:   getdata['Email'],
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

                                    SizedBox(
                                      width: 302.46*fem,
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
                                            child: KText(
                                              text:  getdata['Phone'],
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
                                    SizedBox(height:height/43.4),

                                    SizedBox(
                                      width: 342.46*fem,
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
                                                  child: KText(
                                                    text:   getdata['Address'],
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
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                  // group649mPf (10:82)
                                  margin: EdgeInsets.fromLTRB(64.43*fem, 0*fem, 64.41*fem, 19*fem),
                                  width: 362.46*fem,
                                  height: 30*fem,
                                  decoration: BoxDecoration (
                                    borderRadius: BorderRadius.circular(22.5*fem),
                                    color: Color(0xff26c0e2),
                                  ),
                                  child:
                                  Center(
                                    child: KText(
                                      text: 'Download Images',
                                    //  textAlign: TextAlign.center,
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

                              GestureDetector(
                                onTap:(){},
                                child: Container(
                                  // group6502iu (10:85)
                                  margin: EdgeInsets.fromLTRB(50.43*fem, 0*fem, 52.41*fem, 0*fem),
                                  width: double.infinity,
                                  height: 30*fem,
                                  decoration: BoxDecoration (
                                    color: Color(0xffffd56b),
                                    borderRadius: BorderRadius.circular(22.5*fem),
                                  ),
                                  child: Center(
                                    child: KText(
                                      text: 'Download Documents',
                                    //  textAlign: TextAlign.center,
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
                              ),
                            ],
                          );
                        },
                    ),
                  ),
                ):
               SizedBox(
                 width: 353.71*fem,
                 height: 1163.32*fem,
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  OverlayEntry createFloating(context) {
    RenderBox?  renderBox =  floatingKey.currentContext!
        .findRenderObject() as RenderBox;
    Offset offset = renderBox!.localToGlobal(Offset.zero);
    return OverlayEntry(
        builder: (context) {
          return Positioned(
              left: offset.dx,
              width: renderBox.size.width,
              top: offset.dy - 50,
              child: Material(
                  elevation: 20,
                  child: Container(
                      height: 50,
                      color: Colors.blue,
                      child: KText( text:"I'm floating overlay"  ,style: SafeGoogleFont ('Nunito'
                      ),)
                  )
              )
          );
        }
    );
  }


}
