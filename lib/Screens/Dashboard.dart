import 'package:alumni_management_admin/Screens/Setting_Screen.dart';
import 'package:alumni_management_admin/Screens/audio_podcasts.dart';
import 'package:alumni_management_admin/Screens/donations_tab.dart';
import 'package:alumni_management_admin/common_widgets/about_us_tab.dart';
import 'package:alumni_management_admin/common_widgets/dashboardgraph.dart';
import 'package:alumni_management_admin/common_widgets/developer_card_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:country_flags/country_flags.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

import '../Constant_.dart';
import '../DashBoard(Unverifed User Model)/UnVeriyedModel.dart';
import '../Demo_Page.dart';
import '../Models/Language_Model.dart';
import '../PieChart_all_department.dart';
import '../utils.dart';
import 'Notification_Screen.dart';
import 'Signin.dart';
import 'Users_Screen.dart';
import 'demo.dart';

class DashBoard extends StatefulWidget {
  String?usermail;
   DashBoard({this.usermail});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int dawer = 0;
  var pages;
  bool filtervalue = false;
  String filterChageValue = "Name";



  int documentlength =0 ;
  int pagecount =0 ;
  int temp = 1;
  List list = new List<int>.generate(1000, (i) => i + 1);
  doclength() async {

    final QuerySnapshot result = await FirebaseFirestore.instance.collection('Users').where("verifyed",isEqualTo:false).get();
    final List < DocumentSnapshot > documents = result.docs;
    setState(() {
      documentlength = documents.length;
      pagecount= ((documentlength~/4) +1) as int;

    });
    print(pagecount);
  }

  @override
  void initState() {
    UnVeriFyedUserData();
    totalalumnifunc();
    doclength();
    setState(() {
      UserViewed=false;
    });
    // TODO: implement initState
    super.initState();
  }


  int TotalUsers=0;
  int verifyedUsers=0;
  int UnverifyedUsers=0;
  int totalEvents=0;
  int unVerifiedJobs =0;
  int jobPost=0;
  String viewDocid="";
  bool viewUser_details=false;

  totalalumnifunc()async{
    var document=await FirebaseFirestore.instance.collection("Users").get();
    var verifyedusers=await FirebaseFirestore.instance.collection("Users").where("verifyed",isEqualTo:true).get();
    var Unverifyedusers=await FirebaseFirestore.instance.collection("Users").where("verifyed",isEqualTo:false).get();
    var eventsCount=await FirebaseFirestore.instance.collection("Batch_events").get();

    var jobpostCount=await FirebaseFirestore.instance.collection("JobPosts").get();
    var unverifiedJobsCount = await FirebaseFirestore.instance.collection("JobPosts").where("verify",isEqualTo: false).get();
    setState(() {
      TotalUsers=document.docs.length;
      verifyedUsers=verifyedusers.docs.length;
      UnverifyedUsers=Unverifyedusers.docs.length;
      totalEvents=eventsCount.docs.length;
      unVerifiedJobs = unverifiedJobsCount.docs.length;
      jobPost=jobpostCount.docs.length;
    });

  }


  UnVeriFyedUserData()async{
    var Unverifyedusersdata=await FirebaseFirestore.instance.collection("Users").orderBy("Name").get();
    for(int x=0;x<Unverifyedusersdata.docs.length;x++){
      if(Unverifyedusersdata.docs[x]['verifyed']==false){
        setState(() {
          unVerifyedUserData.add(
              UnVerfiyedUser(
                  UserBatch: Unverifyedusersdata.docs[x]['yearofpassed'].toString(),
                  UserDocId: Unverifyedusersdata.docs[x].id.toString(),
                  UserEmail: Unverifyedusersdata.docs[x]['email'].toString(),
                  UserFirstName: Unverifyedusersdata.docs[x]['Name'].toString(),
                  UserGender: Unverifyedusersdata.docs[x]['Gender'].toString(),
                  UserImg: Unverifyedusersdata.docs[x]['UserImg'].toString(),
                  UserLastName: Unverifyedusersdata.docs[x]['lastName'].toString(),
                  UserPhoneNumber: Unverifyedusersdata.docs[x]['Phone'].toString()
              )
          );
        });
      }
    }
    print(unVerifyedUserData.length);
    print("User Unverifyed Data List+++++++++++++++++++++++++++");
  }

  String imgUrl="";

  TextEditingController firstNamecon = TextEditingController();
  TextEditingController middleNamecon = TextEditingController();
  TextEditingController lastNamecon = TextEditingController();
  TextEditingController dateofBirthcon = TextEditingController();
  TextEditingController gendercon = TextEditingController(text: "Select");
  TextEditingController alterEmailIdcon = TextEditingController();
  TextEditingController aadhaarNumbercon = TextEditingController();
  TextEditingController phoneNumbercon = TextEditingController();
  TextEditingController mobileNumbercon = TextEditingController();
  TextEditingController emailIDcon = TextEditingController();
  TextEditingController adreesscon = TextEditingController();
  TextEditingController citycon = TextEditingController(text: "Select City");
  TextEditingController pinCodecon = TextEditingController();
  TextEditingController statecon = TextEditingController(text: "Select State");
  TextEditingController countrycon = TextEditingController(text: "Select Country");
  TextEditingController yearPassedcon = TextEditingController();
  TextEditingController subjectStremdcon = TextEditingController(text:"Select Department");
  TextEditingController classcon = TextEditingController();
  TextEditingController rollnocon = TextEditingController();
  TextEditingController lastvisitcon = TextEditingController();
  TextEditingController housecon = TextEditingController();
  TextEditingController statusmessagecon = TextEditingController();
  TextEditingController educationquvalificationcon = TextEditingController();
  TextEditingController additionalquvalificationcon = TextEditingController();
  TextEditingController occupationcon = TextEditingController();
  TextEditingController designationcon = TextEditingController();
  TextEditingController company_concerncon = TextEditingController();
  TextEditingController maritalStatuscon = TextEditingController(text: "Marital Status");
  TextEditingController spouseNamecon = TextEditingController();
  TextEditingController anniversaryDatecon = TextEditingController();
  TextEditingController no_of_childreancon = TextEditingController();
  TextEditingController ownBussinesscon = TextEditingController();
  TextEditingController alumniEmployedController = TextEditingController(text: "No");
  TextEditingController requestedLanguageController = TextEditingController();

  bool UserViewed=false;

  List <UnVerfiyedUser> unVerifyedUserData=[];

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return UserViewed==false?
      FadeInRight(
      duration: const Duration(milliseconds: 600),

      child: SizedBox(
        // autogroupnx99mr9 (T1hGz35EtnvJDP43Jynx99)
        width: 1574*fem,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                // topbar7QD (6:110)
                padding: EdgeInsets.fromLTRB(39*fem, 30*fem, 40*fem, 30*fem),
                width: double.infinity,
                height: 120*fem,
                decoration: const BoxDecoration (
                  color: Color(0xffffffff),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // alumnimanagment1kV (6:153)
                      width:width/2.3,
                      margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 10*fem, 0*fem),
                      child: KText(
                        text:
                        'IKIA COLLEGE ADMIN',
                        style: SafeGoogleFont (
                          'Poppins',
                          fontSize: 36*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.3999999364*ffem/fem,
                          color: const Color(0xff151d48),
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

                   // SizedBox(width:  580*fem,),
                    SizedBox(
                      // menuaMf (6:133)
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap:(){
                              _showPopupMenu(context);
                            },
                            child: Container(
                              width:width/12,
                              // margin: EdgeInsets.fromLTRB(0*fem, 16.5*fem, 58*fem, 16.5*fem),
                              // padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 7.06*fem, 0*fem),
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

                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1.75*fem, 0*fem),
                                          width: 32.5*fem,
                                          height: 42.5*fem,
                                          child:
                                          CountryFlag.fromLanguageCode(
                                            Constants.flagvalue.toString(),
                                            borderRadius: 20,
                                            // width: 9.94*fem,
                                            // height: 6*fem,
                                          ),
                                        ),
                                        KText(
                                          text:
                                          // engusYQy (6:130)
                                          Constants.langvalue.toString(),
                                          style: SafeGoogleFont (
                                            'Poppins',
                                            fontSize: 18*ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.5*ffem/fem,
                                            color: const Color(0xff374557),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),


                          Container(
                            // group1000002734dqj (6:134)
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Constants().primaryAppColor.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(8)
                            ),

                            child: Center(
                              child: IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Notification_Screen(),));
                              }, icon: Icon(Icons.notifications_active, color: Constants().primaryAppColor)),
                            ),
                          ),
                          SizedBox(width:10),
                          Container(
                            // group1000002734dqj (6:134)
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Constants().primaryAppColor.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(8)
                            ),

                            child: Center(
                              child: IconButton(onPressed: (){
                                _showSettingsPopupMenu(context);
                              }, icon: Icon(Icons.settings, color: Constants().primaryAppColor)),
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
                          border: Border.all(color: const Color(0xfff8f9fa)),
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(20*fem),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x80ededed),
                              offset: Offset(0*fem, 4*fem),
                              blurRadius: 10*fem,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
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
                                              color: const Color(0xff05004e),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // alumnisummeryNkh (6:215)
                                          margin: EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 0*fem),
                                          child:
                                          KText(
                                            text:
                                            'Alumni Summary',
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 16*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.875*ffem/fem,
                                              color: const Color(0xff737791),
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
                                      color: const Color(0xffffe2e5),
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
                                              color: const Color(0xff151d48),
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
                                            color: const Color(0xff415166),
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
                            SizedBox(
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
                                      color: const Color(0xffFFF4DE),
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
                                              color: const Color(0xff151d48),
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
                                            color: const Color(0xff415166),
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
                            SizedBox(
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
                                      color: const Color(0xffDCFCE7),
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
                                            UnverifyedUsers.toString(),
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: const Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        KText(
                                          text:
                                          // totaleventsspV (6:1159)
                                          'Unverified Alumni',
                                          style: SafeGoogleFont (
                                            'Poppins',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5*ffem/fem,
                                            color: const Color(0xff415166),
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
                            SizedBox(
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
                                      color: const Color(0xffF3E8FF),
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
                                            jobPost.toString(),
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: const Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        KText(
                                          text:
                                          // totaleventsspV (6:1159)
                                          'Total  Job posts',
                                          style: SafeGoogleFont (
                                            'Poppins',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5*ffem/fem,
                                            color: const Color(0xff415166),
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
                            SizedBox(
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
                                      color: const Color(0xffd4ecff),
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
                                           unVerifiedJobs.toString(),
                                            style: SafeGoogleFont (
                                              'Poppins',
                                              fontSize: 24*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333*ffem/fem,
                                              color: const Color(0xff151d48),
                                            ),
                                          ),
                                        ),
                                        KText(
                                          text:
                                          // totaleventsspV (6:1159)
                                          'Unverified Jobs ',
                                          style: SafeGoogleFont (
                                            'Poppins',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5*ffem/fem,
                                            color: const Color(0xff415166),
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
                                      border: Border.all(color: const Color(0xfff8f9fa)),
                                     color: const Color(0xffffffff),

                                      borderRadius: BorderRadius.circular(20*fem),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x80ededed),
                                          offset: Offset(0*fem, 4*fem),
                                          blurRadius: 10*fem,
                                        ),
                                      ],
                                    ),
                                    child:const Maopppp(),
                                    // Container(
                                    //   // world15p5 (6:448)
                                    //   width: double.infinity,
                                    //   height: double.infinity,
                                    //   child: Center(
                                    //     // autogroup26c33F7 (T1eKrTDkhXrQ3jmkK726C3)
                                    //     child: SizedBox(
                                    //       width: 649.88*fem,
                                    //       height: 267.49*fem,
                                    //       child: Image.asset(
                                    //         'assets/images/auto-group-26c3.png',
                                    //         width: 649.88*fem,
                                    //         height: 267.49*fem,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ),
                                Positioned(
                                  // cardtitlewmj (6:922)
                                  left: 41.0451660156*fem,
                                  top: 30.3703689575*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 225*fem,
                                      height: 32*fem,
                                      child: KText(
                                        text:
                                        'Alumni in World Wide',
                                        style: SafeGoogleFont (
                                          'Poppins',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.6*ffem/fem,
                                          color: const Color(0xff05004e),
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
                             height:285 ,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(12*fem),
                              image: const DecorationImage (
                                fit: BoxFit.cover,
                                image: AssetImage (
                                  'assets/images/auto-group-oznf.png',
                                ),
                              ),
                            ),
                            child: const LineChartSample2()
                           // LineChartMap(isShowingMainData: true,)
                            // Stack(
                            //   children: [
                            //     Positioned(
                            //       // cardheaderuMB (6:222)
                            //       left: 6.0913696289*fem,
                            //       top: 0*fem,
                            //       child: Container(
                            //         padding: EdgeInsets.fromLTRB(22.91*fem, 24*fem, 22.91*fem, 19.4*fem),
                            //         width: 713.91*fem,
                            //         height: 75.4*fem,
                            //         child: KText(
                            //           text:
                            //           'App Usage',
                            //           style: SafeGoogleFont (
                            //             'Poppins',
                            //             fontSize: 20*ffem,
                            //             fontWeight: FontWeight.w600,
                            //             height: 1.6*ffem/fem,
                            //             color: Color(0xff05004e),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // axisZRj (6:226)
                            //       left: 62.1319732666*fem,
                            //       top: 109.5689620972*fem,
                            //       child: Container(
                            //         width: 516*fem,
                            //         height: 165*fem,
                            //         child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.center,
                            //           children: [
                            //             Container(
                            //               // axisU2u (6:231)
                            //               width: double.infinity,
                            //               height: 1*fem,
                            //               decoration: BoxDecoration (
                            //                 color: Color(0x0a464e5f),
                            //               ),
                            //             ),
                            //             SizedBox(
                            //               height: 40*fem,
                            //             ),
                            //             Container(
                            //               // axisnZP (6:230)
                            //               width: double.infinity,
                            //               height: 1*fem,
                            //               decoration: BoxDecoration (
                            //                 color: Color(0x0a464e5f),
                            //               ),
                            //             ),
                            //             SizedBox(
                            //               height: 40*fem,
                            //             ),
                            //             Container(
                            //               // axisKJR (6:229)
                            //               width: double.infinity,
                            //               height: 1*fem,
                            //               decoration: BoxDecoration (
                            //                 color: Color(0x0a464e5f),
                            //               ),
                            //             ),
                            //             SizedBox(
                            //               height: 40*fem,
                            //             ),
                            //             Container(
                            //               // axis4G1 (6:228)
                            //               width: double.infinity,
                            //               height: 1*fem,
                            //               decoration: BoxDecoration (
                            //                 color: Color(0x0a464e5f),
                            //               ),
                            //             ),
                            //             SizedBox(
                            //               height: 40*fem,
                            //             ),
                            //             Container(
                            //               // axisQ4y (6:227)
                            //               width: double.infinity,
                            //               height: 1*fem,
                            //               decoration: BoxDecoration (
                            //                 color: Color(0x0a464e5f),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // x6V (6:232)
                            //       left: 45.6040649414*fem,
                            //       top: 294.540222168*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 8*fem,
                            //           height: 16*fem,
                            //           child: KText(
                            //             text:
                            //             '0',
                            //             //textAlign: TextAlign.right,
                            //             style: SafeGoogleFont (
                            //               'Poppins',
                            //               fontSize: 12*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.3333333333*ffem/fem,
                            //               color: Color(0xff7a91b0),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // SXT (6:233)
                            //       left: 34.6040344238*fem,
                            //       top: 246.2356262207*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 19*fem,
                            //           height: 16*fem,
                            //           child: KText(
                            //             text:
                            //             '100',
                            //             //textAlign: TextAlign.right,
                            //             style: SafeGoogleFont (
                            //               'Poppins',
                            //               fontSize: 12*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.3333333333*ffem/fem,
                            //               color: Color(0xff7a91b0),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // vBj (6:234)
                            //       left: 31.6040496826*fem,
                            //       top: 196.7528686523*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 22*fem,
                            //           height: 16*fem,
                            //           child: KText(
                            //            text: '200',
                            //          //   textAlign: TextAlign.right,
                            //             style: SafeGoogleFont (
                            //               'Poppins',
                            //               fontSize: 12*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.3333333333*ffem/fem,
                            //               color: Color(0xff7a91b0),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // R8V (6:235)
                            //       left: 30.6040344238*fem,
                            //       top: 149.6264343262*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 23*fem,
                            //           height: 16*fem,
                            //           child: KText(
                            //             text:'300',
                            //             //textAlign: TextAlign.right,
                            //             style: SafeGoogleFont (
                            //               'Poppins',
                            //               fontSize: 12*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.3333333333*ffem/fem,
                            //               color: Color(0xff7a91b0),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // XBX (6:236)
                            //       left: 30.6040344238*fem,
                            //       top: 101.3218383789*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 23*fem,
                            //           height: 16*fem,
                            //           child: KText(
                            //             text:'400',
                            //           //  textAlign: TextAlign.right,
                            //             style: SafeGoogleFont (
                            //               'Poppins',
                            //               fontSize: 12*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.3333333333*ffem/fem,
                            //               color: Color(0xff7a91b0),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // jan28H (6:237)
                            //       left: 84.8071136475*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 18*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //            text: 'Jan',
                            //           //  textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // febW3T (6:238)
                            //       left: 140.8477020264*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 18*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //             text:
                            //             'Feb',
                            //            // textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // marzzD (6:239)
                            //       left: 182.3781738281*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 19*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //             text: 'Mar',
                            //            // textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // apruLV (6:240)
                            //       left: 239.4187469482*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 17*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //             text:  'Apr',
                            //            // textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // maybz1 (6:241)
                            //       left: 294.5685424805*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 20*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //             text:'May',
                            //            // textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // junVJh (6:242)
                            //       left: 350.3908691406*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 18*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //             text: 'Jun',
                            //             //textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // junBSR (6:243)
                            //       left: 406.4315185547*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 18*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //             text:  'Jun',
                            //           //  textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // julUwK (6:244)
                            //       left: 464.4721374512*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 14*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //             text:'Jul',
                            //            // textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // septmZ3 (6:245)
                            //       left: 503.8299865723*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 23*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //             text:'Sept',
                            //             //textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // octpXK (6:246)
                            //       left: 561.1522827148*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 18*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //             text: 'Oct',
                            //             //textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // novvKT (6:247)
                            //       left: 617.3020019531*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 19*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //             text: 'Nov',
                            //             //textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // desou3 (6:248)
                            //       left: 673.3426513672*fem,
                            //       top: 308.6781616211*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 19*fem,
                            //           height: 11*fem,
                            //           child: KText(
                            //             text:  'Des',
                            //             //textAlign: TextAlign.center,
                            //             style: SafeGoogleFont (
                            //               'Epilogue',
                            //               fontSize: 10*ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.025*ffem/fem,
                            //               color: Color(0xff464e5f),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // frame10Jqo (6:249)
                            //       left: 81.6243896484*fem,
                            //       top: 110.7471237183*fem,
                            //       child: Container(
                            //         width: 589.64*fem,
                            //         height: 192.04*fem,
                            //         child: Center(
                            //           // autogrouperqmEDf (T1eGi8HtX396G1Z4V3ERqM)
                            //           child: SizedBox(
                            //             width: 589.64*fem,
                            //             height: 192.04*fem,
                            //             child: Image.asset(
                            //               'assets/images/auto-group-erqm.png',
                            //               width: 589.64*fem,
                            //               height: 192.04*fem,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // ellipse40jgD (6:256)
                            //       left: 462.9442138672*fem,
                            //       top: 121.3505783081*fem,
                            //       child: Align(
                            //         child: SizedBox(
                            //           width: 17.06*fem,
                            //           height: 16.49*fem,
                            //           child: Image.asset(
                            //             'assets/images/ellipse-40.png',
                            //             width: 17.06*fem,
                            //             height: 16.49*fem,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       // group10pBs (6:258)
                            //       left: 129.4540100098*fem,
                            //       top: 367.5862121582*fem,
                            //       child: Container(
                            //         width: 383*fem,
                            //         height: 12*fem,
                            //         child: Row(
                            //           crossAxisAlignment: CrossAxisAlignment.center,
                            //           children: [
                            //             Container(
                            //               // frame9X6H (6:267)
                            //               margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                            //               padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 48*fem, 0*fem),
                            //               height: double.infinity,
                            //               child: Row(
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   Container(
                            //                     // rectangle2172Yq (6:269)
                            //                     margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                            //                     width: 12*fem,
                            //                     height: 12*fem,
                            //                     decoration: BoxDecoration (
                            //                       borderRadius: BorderRadius.circular(2*fem),
                            //                       color: Color(0xffa700ff),
                            //                     ),
                            //                   ),
                            //                   KText(
                            //                     // loyalcustomerswvh (6:270)
                            //                     text:'Alumnus',
                            //                     style: SafeGoogleFont (
                            //                       'Epilogue',
                            //                       fontSize: 12*ffem,
                            //                       fontWeight: FontWeight.w500,
                            //                       height: 1.025*ffem/fem,
                            //                       color: Color(0xff464e5f),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //             Container(
                            //               // frame8HUm (6:263)
                            //               margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                            //               padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 39*fem, 0*fem),
                            //               height: double.infinity,
                            //               child: Row(
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   Container(
                            //                     // rectangle2171Qm (6:265)
                            //                     margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                            //                     width: 12*fem,
                            //                     height: 12*fem,
                            //                     decoration: BoxDecoration (
                            //                       borderRadius: BorderRadius.circular(2*fem),
                            //                       color: Color(0xffef4444),
                            //                     ),
                            //                   ),
                            //                   KText(
                            //                     // newcustomers8VP (6:266)
                            //                     text: 'Students',
                            //                     style: SafeGoogleFont (
                            //                       'Epilogue',
                            //                       fontSize: 12*ffem,
                            //                       fontWeight: FontWeight.w500,
                            //                       height: 1.025*ffem/fem,
                            //                       color: Color(0xff464e5f),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //             Container(
                            //               // frame74tq (6:259)
                            //               padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 33*fem, 0*fem),
                            //               height: double.infinity,
                            //               child: Row(
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   Container(
                            //                     // rectangle21713P (6:261)
                            //                     margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                            //                     width: 12*fem,
                            //                     height: 12*fem,
                            //                     decoration: BoxDecoration (
                            //                       borderRadius: BorderRadius.circular(2*fem),
                            //                       color: Color(0xff3cd856),
                            //                     ),
                            //                   ),
                            //                   KText(
                            //                     // uniquecustomersjEH (6:262)
                            //                     text:'Connections',
                            //                     style: SafeGoogleFont (
                            //                       'Epilogue',
                            //                       fontSize: 12*ffem,
                            //                       fontWeight: FontWeight.w500,
                            //                       height: 1.025*ffem/fem,
                            //                       color: Color(0xff464e5f),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
                          color: const Color(0xff05004e),
                        ),
                      ),
                    ),

                    ///stream titles text
                    Padding(
                      padding: EdgeInsets.only(left: width / 170.75),
                      child: Container(
                        width: width / 1.21,
                        height: 78.22 * fem,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius:
                          BorderRadius.circular(10 * fem),),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            /* SizedBox(
                                                width: width / 6.5,
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // namekWM (8:2306)
                                                      margin: EdgeInsets.fromLTRB(
                                                          0 * fem,
                                                          0 * fem,
                                                          14.75 * fem,
                                                          0 * fem),
                                                      child: KText(
                                                        text: 'Name',
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: 15 * ffem,
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.3625 * ffem / fem,
                                                          color: const Color(0xff030229),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
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
                                                            margin:
                                                                EdgeInsets.fromLTRB(
                                                                    0 * fem,
                                                                    1.6 * fem,
                                                                    0 * fem,
                                                                    0 * fem),
                                                            width: 7.82 * fem,
                                                            height: 6.52 * fem,
                                                            child: Image.asset(
                                                              'assets/images/arrow-down-2.png',
                                                              width: 7.82 * fem,
                                                              height: 6.52 * fem,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: width / 6.5,
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // emailfv9 (8:2312)
                                                      margin: EdgeInsets.fromLTRB(
                                                          0 * fem,
                                                          0 * fem,
                                                          14.15 * fem,
                                                          0 * fem),
                                                      child: KText(
                                                        text: 'Email',
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: 15 * ffem,
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.3625 * ffem / fem,
                                                          color: const Color(0xff030229),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
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
                                                            margin:
                                                                EdgeInsets.fromLTRB(
                                                                    0 * fem,
                                                                    1.6 * fem,
                                                                    0 * fem,
                                                                    0 * fem),
                                                            width: 7.82 * fem,
                                                            height: 6.52 * fem,
                                                            child: Image.asset(
                                                              'assets/images/arrow-down-2.png',
                                                              width: 7.82 * fem,
                                                              height: 6.52 * fem,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: width / 10.1066,
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // phonenumberntH (8:2316)
                                                      margin: EdgeInsets.fromLTRB(
                                                          0 * fem,
                                                          0 * fem,
                                                          18.33 * fem,
                                                          0 * fem),
                                                      child: KText(
                                                        text: 'Phone number',
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: 15 * ffem,
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.3625 * ffem / fem,
                                                          color: const Color(0xff030229),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
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
                                                            margin:
                                                                EdgeInsets.fromLTRB(
                                                                    0 * fem,
                                                                    1.6 * fem,
                                                                    0 * fem,
                                                                    0 * fem),
                                                            width: 7.82 * fem,
                                                            height: 6.52 * fem,
                                                            child: Image.asset(
                                                              'assets/images/arrow-down-2.png',
                                                              width: 7.82 * fem,
                                                              height: 6.52 * fem,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: width / 10.2,
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: width / 54.64),
                                                    Container(
                                                      // gender8qf (8:2320)
                                                      margin: EdgeInsets.fromLTRB(
                                                          0 * fem,
                                                          0 * fem,
                                                          15.18 * fem,
                                                          0 * fem),
                                                      child: KText(
                                                        text: 'Gender',
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: 15 * ffem,
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.3625 * ffem / fem,
                                                          color: const Color(0xff030229),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
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
                                                            margin:
                                                                EdgeInsets.fromLTRB(
                                                                    0 * fem,
                                                                    1.6 * fem,
                                                                    0 * fem,
                                                                    0 * fem),
                                                            width: 7.82 * fem,
                                                            height: 6.52 * fem,
                                                            child: Image.asset(
                                                              'assets/images/arrow-down-2.png',
                                                              width: 7.82 * fem,
                                                              height: 6.52 * fem,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: width / 10.8,
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: width / 54.64),
                                                    Container(
                                                      // gender8qf (8:2320)
                                                      margin: EdgeInsets.fromLTRB(
                                                          0 * fem,
                                                          0 * fem,
                                                          15.18 * fem,
                                                          0 * fem),
                                                      child: KText(
                                                        text: 'Status',
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: 15 * ffem,
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.3625 * ffem / fem,
                                                          color: const Color(0xff030229),
                                                        ),
                                                      ),
                                                    ),
                                                    Opacity(
                                                      // arrowdown5rFs (8:2318)
                                                      opacity: 0.0,
                                                      child: Container(
                                                        margin: EdgeInsets.fromLTRB(
                                                            0 * fem,
                                                            1.6 * fem,
                                                            0 * fem,
                                                            0 * fem),
                                                        width: 7.82 * fem,
                                                        height: 6.52 * fem,
                                                        child: Image.asset(
                                                          'assets/images/arrow-down-5.png',
                                                          width: 7.82 * fem,
                                                          height: 6.52 * fem,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: width / 10.8,
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    KText(
                                                      text: 'Create On',
                                                      style: SafeGoogleFont(
                                                        'Nunito',

                                                        color: const Color(0xff030229),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: width / 14.8,
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    KText(
                                                      text: 'Actions',
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        color: const Color(0xff030229),
                                                      ),
                                                    ),
                                                    Opacity(
                                                      // arrowdown5rFs (8:2318)
                                                      opacity: 0.0,
                                                      child: Container(
                                                        margin: EdgeInsets.fromLTRB(
                                                            0 * fem,
                                                            1.6 * fem,
                                                            0 * fem,
                                                            0 * fem),
                                                        width: 7.82 * fem,
                                                        height: 6.52 * fem,
                                                        child: Image.asset(
                                                          'assets/images/arrow-down-5.png',
                                                          width: 7.82 * fem,
                                                          height: 6.52 * fem,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),*/

                            ///NAme
                            Container(
                              color: Colors.white,
                              width: width / 5.5,
                              height: height / 14.78,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                  left: width / 78.3),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  KText(
                                    text: "Name",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      color: const Color(0xff030229),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width / 170.75),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          filtervalue = !filtervalue;
                                          filterChageValue = "Name";
                                        });
                                        // Sort unVerifyedUserData based on User Phone Number
                                        unVerifyedUserData.sort((a, b) =>
                                        (filterChageValue == "Name"&&filtervalue) ? b.UserFirstName!.compareTo(a.UserFirstName.toString()) :
                                        a.UserFirstName!.compareTo(b.UserFirstName.toString()));
                                      },
                                      child: Transform.rotate(
                                        angle: filtervalue &&
                                            filterChageValue == "Name"
                                            ? 200
                                            : 0,
                                        child: Opacity(
                                          // arrowdown2TvZ (8:2307)
                                          opacity: 0.7,
                                          child: Container(
                                            width: width / 153.6,
                                            height: height / 73.9,
                                            child: Image.asset(
                                              'assets/images/arrow-down-2.png',
                                              width: width / 153.6,
                                              height: height / 73.9,
                                                color:filtervalue &&
                                                    filterChageValue == "Name"?Colors.green:Colors.transparent
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
                              color: Colors.white,
                              width: width / 5.5,
                              height: height / 14.78,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                  left: width / 100.15),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  KText(
                                    text: "Email",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      color: const Color(0xff030229),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width / 170.75),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          filtervalue = !filtervalue;
                                          filterChageValue = "email";
                                        });
                                        unVerifyedUserData.sort((a, b) =>
                                        (filterChageValue == "email"&&filtervalue) ? b.UserEmail!.compareTo(a.UserEmail.toString()) :
                                        a.UserEmail!.compareTo(b.UserEmail.toString()));
                                      },
                                      child: Transform.rotate(
                                        angle: filterChageValue ==
                                            "email" && filtervalue
                                            ? 200
                                            : 0,
                                        child: Opacity(
                                          // arrowdown2TvZ (8:2307)
                                          opacity: 0.7,
                                          child: Container(
                                            width: width / 153.6,
                                            height: height / 73.9,
                                            child: Image.asset(
                                              'assets/images/arrow-down-2.png',
                                              width: width / 153.6,
                                              height: height / 73.9,
                                                color:filtervalue &&
                                                    filterChageValue == "email"?Colors.green:Colors.transparent
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
                              color: Colors.white,
                              width: width / 8.2,
                              height: height / 14.78,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                  left: width / 100.533),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  KText(
                                    text: "Phone Number",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      color: const Color(0xff030229),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width / 170.75),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          filtervalue = !filtervalue;
                                          filterChageValue = "Phone";
                                        });
                                        unVerifyedUserData.sort((a, b) =>
                                        (filterChageValue == "Phone"&&filtervalue) ? b.UserPhoneNumber!.compareTo(a.UserPhoneNumber.toString()) :
                                        a.UserPhoneNumber!.compareTo(b.UserPhoneNumber.toString()));
                                      },
                                      child: Transform.rotate(
                                        angle: filtervalue &&
                                            filterChageValue == "Phone"
                                            ? 200
                                            : 0,
                                        child: Opacity(
                                          // arrowdown2TvZ (8:2307)
                                          opacity: 0.7,
                                          child: Container(
                                            width: width / 153.6,
                                            height: height / 73.9,
                                            child: Image.asset(
                                              'assets/images/arrow-down-2.png',
                                              width: width / 153.6,
                                              height: height / 73.9,
                                                color:filtervalue &&
                                                    filterChageValue == "Phone"?Colors.green:Colors.transparent
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
                              color: Colors.white,
                              width: width / 12,
                              height: height / 14.78,
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment
                                    .end,
                                children: [
                                  KText(
                                    text: "Gender",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      color: const Color(0xff030229),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width / 170.75,
                                        right: width / 54.64),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          filtervalue = !filtervalue;
                                          filterChageValue = "Gender";
                                        });
                                        unVerifyedUserData.sort((a, b) =>
                                        (filterChageValue == "Gender"&&filtervalue) ? b.UserGender!.compareTo(a.UserGender.toString()) :
                                        a.UserGender!.compareTo(b.UserGender.toString()));
                                      },
                                      child: Transform.rotate(
                                        angle: filtervalue &&
                                            filterChageValue == "Gender"
                                            ? 200
                                            : 0,
                                        child: Opacity(
                                          // arrowdown2TvZ (8:2307)
                                          opacity: 0.7,
                                          child: Container(
                                            width: width / 153.6,
                                            height: height / 73.9,
                                            child: Image.asset(
                                              'assets/images/arrow-down-2.png',
                                              width: width / 153.6,
                                              height: height / 73.9,
                                                color:filtervalue &&
                                                    filterChageValue == "Gender"?Colors.green:Colors.transparent
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
                              color: Colors.white,
                              width: width / 15,
                              height: height / 14.78,
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment
                                    .end,
                                children: [
                                  KText(
                                    text: "Batch",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      color: const Color(0xff030229),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width / 170.75,
                                        right: width / 54.64),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          filtervalue = !filtervalue;
                                          filterChageValue = "yearofpassed";
                                        });
                                        unVerifyedUserData.sort((a, b) =>
                                        (filterChageValue == "yearofpassed"&&filtervalue) ? b.UserBatch!.compareTo(a.UserBatch.toString()) :
                                        a.UserBatch!.compareTo(b.UserBatch.toString()));
                                      },
                                      child: Transform.rotate(
                                        angle: filtervalue &&
                                            filterChageValue == "yearofpassed"
                                            ? 200
                                            : 0,
                                        child: Opacity(
                                          // arrowdown2TvZ (8:2307)
                                          opacity: 0.7,
                                          child: Container(
                                            width: width / 153.6,
                                            height: height / 73.9,
                                            child: Image.asset(
                                                'assets/images/arrow-down-2.png',
                                                width: width / 153.6,
                                                height: height / 73.9,
                                                color:filtervalue &&
                                                    filterChageValue == "yearofpassed"?Colors.green:Colors.transparent
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
                              color: Colors.white,
                              width: width / 8.98,
                              height: height / 14.78,
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment
                                    .end,
                                children: [
                                  KText(
                                    text: "Actions",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      color: const Color(0xff030229),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width / 170.75,
                                        right: width / 54.64),
                                    child: Transform.rotate(
                                      angle:
                                           0,
                                      child: Opacity(
                                        // arrowdown2TvZ (8:2307)
                                        opacity: 0.7,
                                        child: Container(
                                          width: width / 153.6,
                                          height: height / 73.9,

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
                    SizedBox(height: height / 65.1),
                    /*StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Users").orderBy(filterChageValue,descending: filtervalue).snapshots(),
                      builder: (context, snapshot) {

                        if(!snapshot.hasData){
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        if(snapshot.hasData==null){
                          return const Center(child: CircularProgressIndicator(),);
                        }

                        return Column(
                          children: [
                            SizedBox(
                              height:height/2.830,
                              width:width/1.0045,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics:const  NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {

                                  var _userdata = snapshot.data!.docs[(temp*4)-4+index];
                                if(_userdata['verifyed']==false){
                                    return   (temp*4)-4+index >= documentlength ?SizedBox():
                                    Container(
                                    padding: EdgeInsets.fromLTRB(26.07*fem, 19.56*fem, 39.11*fem, 19.56*fem),
                                    width: 1119.87*fem,
                                    height: 78.22*fem,
                                    decoration: BoxDecoration (
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10*fem),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width:width/5.464,
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.34*fem, 0*fem),
                                                width: 39.11*fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration (
                                                  color: const Color(0xfff6d0d0),
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
                                                      child:Center(
                                                        child: _userdata['UserImg'].toString()==""?Icon(Icons.person):Text(""),
                                                      )
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(

                                                margin: EdgeInsets.fromLTRB(0*fem, 4.14*fem, 129.49*fem, 0*fem),
                                                child: KText(
                                                  text:"${_userdata['Name']} ${_userdata['lastName']}",
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 18*ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3625*ffem/fem,
                                                    color: const Color(0xff030229),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          width:width/5.464,
                                          child: KText(
                                            text:_userdata['email'],
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 18*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: const Color(0xff030229),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width:width/8.2,
                                          child: KText(
                                            text:_userdata['Phone'].toString(),
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 18*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: const Color(0xff030229),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width:width/12,
                                          child: Padding(
                                            padding:  EdgeInsets.only(left:0,right: width/54.64),
                                            child: Container(
                                              width:width/34.15,
                                              height: double.infinity,
                                              decoration: BoxDecoration (
                                                color:_userdata['Gender']=="Male"?
                                                const Color(0x195b92ff):
                                                const Color(0xffFEF3F0),
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
                                                    const Color(0xff5b92ff):const Color(0xffFE8F6B),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width:width/15.83,
                                          child: KText(
                                            text:_userdata['yearofpassed'].toString(),
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 18*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: const Color(0xff030229),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width:width/30.075),
                                        GestureDetector(
                                          onTap: (){

                                            if(viewDocid=='') {
                                              setState(() {
                                                viewDocid = _userdata.id;
                                              });
                                              ViewinUserDetailsPopup();
                                            }
                                            else{
                                              setState(() {
                                                viewDocid = '';
                                              });
                                            }
                                          },
                                          child: SizedBox(
                                            width:width/22.766,
                                            height:height/26.04,
                                            child: Container(
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.65*fem),
                                                width: 18.25*fem,
                                                height: 15.56*fem,
                                                decoration: BoxDecoration(
                                                    color:Constants().primaryAppColor,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(child: KText(
                                                  text:viewDocid==_userdata.id?"Close":
                                                  "View" , style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 16*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.3625*ffem/fem,
                                                  color: const Color(0xffFFFFFF),
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
                                return  const SizedBox();
                                },),
                            ),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height:50,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: pagecount,
                                      itemBuilder: (context,index){
                                        return InkWell(
                                          onTap: (){
                                            setState(() {
                                              temp=list[index];
                                            });
                                            print(temp);
                                          },
                                          child: Container(
                                              height:30,width:30,
                                              margin: EdgeInsets.only(left:8,right:8,top:10,bottom:10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color:temp.toString() == list[index].toString() ?  Constants().primaryAppColor : Colors.transparent
                                              ),
                                              child: Center(
                                                child: Text(list[index].toString(),style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    color: temp.toString() == list[index].toString() ?  Colors.white : Colors.black

                                                ),),
                                              )
                                          ),
                                        );

                                      }),
                                ),
                                temp > 1 ?
                                Padding(
                                  padding: const EdgeInsets.only(right: 150.0),
                                  child:
                                  InkWell(
                                    onTap:(){
                                      setState(() {
                                        temp= temp-1;
                                      });
                                    },
                                    child: Container(
                                        height:height/16.275,
                                        width:width/11.3833,
                                        decoration:BoxDecoration(
                                            color:Constants().primaryAppColor,
                                            borderRadius: BorderRadius.circular(80)
                                        ),
                                        child: Center(
                                          child: Text("Previous Page",style: SafeGoogleFont(
                                            'Nunito',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),),
                                        )),
                                  ),
                                )  : Container(),
                                Container(
                                  child: temp < pagecount ?
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: InkWell(
                                      onTap:(){
                                        setState(() {
                                          temp= temp+1;
                                        });
                                      },
                                      child:
                                      Container(
                                          height:height/16.275,
                                          width:width/11.3833,
                                          decoration:BoxDecoration(
                                              color:Constants().primaryAppColor,
                                              borderRadius: BorderRadius.circular(80)
                                          ),
                                          child: Center(
                                            child: Text("Next Page",style: SafeGoogleFont(
                                              'Nunito',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),),
                                          )),
                                    ),
                                  )  : Container(),
                                )
                              ],
                            ),
                          ],
                        );
                      },),*/
                    Column(
                      children: [
                        SizedBox(
                          height:height/2.830,
                          width:width/1.0045,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics:const  NeverScrollableScrollPhysics(),
                            itemCount: unVerifyedUserData.length,
                            itemBuilder: (context, index) {

                              var _userdata = unVerifyedUserData[(temp*4)-4+index];

                              return   (temp*4)-4+index >= documentlength ?SizedBox():
                              Container(
                                padding: EdgeInsets.fromLTRB(26.07*fem, 19.56*fem, 39.11*fem, 19.56*fem),
                                width: 1119.87*fem,
                                height: 78.22*fem,
                                decoration: BoxDecoration (
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(10*fem),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:width/5.464,
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.34*fem, 0*fem),
                                            width: 39.11*fem,
                                            height: double.infinity,
                                            decoration: BoxDecoration (
                                              color: const Color(0xfff6d0d0),
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
                                                            _userdata.UserImg.toString()
                                                        ),
                                                      ),
                                                    ),
                                                    child:Center(
                                                      child: _userdata.UserImg.toString()==""?Icon(Icons.person):Text(""),
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(

                                            margin: EdgeInsets.fromLTRB(0*fem, 4.14*fem, 129.49*fem, 0*fem),
                                            child: KText(
                                              text:"${_userdata.UserFirstName.toString()} ${_userdata.UserLastName.toString()}",
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: 18*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.3625*ffem/fem,
                                                color: const Color(0xff030229),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      width:width/5.464,
                                      child: KText(
                                        text:_userdata.UserEmail.toString(),
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 18*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3625*ffem/fem,
                                          color: const Color(0xff030229),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width:width/8.2,
                                      child: KText(
                                        text:_userdata.UserPhoneNumber.toString(),
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 18*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3625*ffem/fem,
                                          color: const Color(0xff030229),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width:width/12,
                                      child: Padding(
                                        padding:  EdgeInsets.only(left:0,right: width/54.64),
                                        child: Container(
                                          width:width/34.15,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color:_userdata.UserGender.toString()=="Male"?
                                            const Color(0x195b92ff):
                                            const Color(0xffFEF3F0),
                                            borderRadius: BorderRadius.circular(33*fem),
                                          ),
                                          child: Center(
                                            child: KText(
                                              text:_userdata.UserGender.toString(),
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: 16*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.3625*ffem/fem,
                                                color: _userdata.UserGender.toString()=="Male"?
                                                const Color(0xff5b92ff):const Color(0xffFE8F6B),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width:width/15.83,
                                      child: KText(
                                        text:_userdata.UserBatch.toString(),
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 18*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3625*ffem/fem,
                                          color: const Color(0xff030229),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width:width/30.075),
                                    GestureDetector(
                                      onTap: (){

                                        if(viewDocid=='') {
                                          setState(() {
                                            viewDocid = _userdata.UserDocId!.toString();
                                          });
                                          ViewinUserDetailsPopup();
                                        }
                                        else{
                                          setState(() {
                                            viewDocid = '';
                                          });
                                        }
                                      },
                                      child: SizedBox(
                                        width:width/22.766,
                                        height:height/26.04,
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.65*fem),
                                            width: 18.25*fem,
                                            height: 15.56*fem,
                                            decoration: BoxDecoration(
                                                color:Constants().primaryAppColor,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(child: KText(
                                              text:viewDocid==_userdata.UserDocId?"Close":
                                              "View" , style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 16*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: const Color(0xffFFFFFF),
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
                            },),
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height:height/13.02,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: pagecount,
                                  itemBuilder: (context,index){
                                    return InkWell(
                                      onTap: (){
                                        setState(() {
                                          temp=list[index];
                                        });
                                        print(temp);
                                      },
                                      child: Container(
                                          height:30,width:30,
                                          margin: EdgeInsets.only(left:8,right:8,top:10,bottom:10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color:temp.toString() == list[index].toString() ?  Constants().primaryAppColor : Colors.transparent
                                          ),
                                          child: Center(
                                            child: Text(list[index].toString(),style: SafeGoogleFont(
                                                'Nunito',
                                                fontWeight: FontWeight.w700,
                                                color: temp.toString() == list[index].toString() ?  Colors.white : Colors.black

                                            ),),
                                          )
                                      ),
                                    );

                                  }),
                            ),
                            temp > 1 ?
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child:
                              InkWell(
                                onTap:(){
                                  setState(() {
                                    temp= temp-1;
                                  });
                                },
                                child: Container(
                                    height:height/16.275,
                                    width:width/11.3833,
                                    decoration:BoxDecoration(
                                        color:Constants().primaryAppColor,
                                        borderRadius: BorderRadius.circular(80)
                                    ),
                                    child: Center(
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.only(left:16.0),
                                        child: Text("Previous Page",style: SafeGoogleFont(
                                          'Nunito',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),),
                                      ),
                                    )),
                              ),
                            )  : Container(),
                            Container(
                              child: temp < pagecount ?
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: InkWell(
                                  onTap:(){
                                    setState(() {
                                      temp= temp+1;
                                    });
                                  },
                                  child:
                                  Container(
                                      height:height/16.275,
                                      width:width/11.3833,
                                      decoration:BoxDecoration(
                                          color:Constants().primaryAppColor,
                                          borderRadius: BorderRadius.circular(80)
                                      ),
                                      child: Center(
                                        child: Text("Next Page",style: SafeGoogleFont(
                                          'Nunito',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),),
                                      )),
                                ),
                              )  : Container(),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height / 65.1),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          UserViewed = !UserViewed;
                        });
                      },
                      child: Container(
                        height: 40,
                        width:120,
                        decoration: BoxDecoration(
                          color: Constants().primaryAppColor,
                          borderRadius:
                          BorderRadius.circular(
                              10 * fem),
                        ),
                        child: Center(
                          child: KText(
                            // addalumniytD (8:2328)
                            text: UserViewed == false
                                ? 'View Alumni'
                                : 'Close Alumni',
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.3625 * ffem / fem,
                              color: const Color(
                                  0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 65.1),
                    DeveloperCardWidget(),
                    SizedBox(height: height / 65.1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ):
    Stack(
      children: [
        Users_Screen(UserViewed: UserViewed,),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              setState(() {
                UserViewed = false;
              });
            },
            child: Icon(Icons.close),
          ),
        ),
      ],
    );

  }


  _showPopupMenu(cxt) async {
    double height=MediaQuery.of(cxt).size.height;
    double width=MediaQuery.of(cxt).size.width;

    await showMenu(
        context: cxt,
        color: const Color(0xffFFFFFF),
        surfaceTintColor: const Color(0xffFFFFFF),
        shadowColor: Colors.black12,
        position:  const RelativeRect.fromLTRB(500, 70, 300, 550),
        items: [


          PopupMenuItem<String>(
            value: 'ta',
            child:  const Text('Tamil'),
            onTap: () {
              changeLocale(cxt, 'ta');
              Constants.flagvalue= "hi";
              Constants.langvalue='Tamil';
            },
          ),
          PopupMenuItem<String>(
            value: 'hi',
            child:  const Text('Hindi'),
            onTap: () {
              setState(() {
                changeLocale(cxt, 'hi');
                Constants. flagvalue= "hi";
                Constants.langvalue='Hindi';
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'te',
            child:  const Text('Telugu'),
            onTap: () {
              changeLocale(cxt, 'te');
              Constants. flagvalue= "hi";
              Constants.langvalue='Telugu';
            },
          ),
          PopupMenuItem<String>(
            value: 'ml',
            child:  const Text('Malayalam'),
            onTap: () {
              setState(() {
                changeLocale(cxt, 'ml');
                Constants. flagvalue= "hi";
                Constants.langvalue='Malayalam';
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'kn',
            child:  const Text('Kannada'),
            onTap: () {
              setState(() {
                changeLocale(cxt, 'kn');
                Constants.flagvalue= "hi";
                Constants. langvalue='Kannada';
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'mr',
            child:  const Text('Marathi'),
            onTap: () {
              setState(() {
                changeLocale(cxt, 'mr');
                Constants.flagvalue= "hi";
                Constants.langvalue='Marathi';
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'gu',
            child:  const Text('Gujarati'),
            onTap: () {
              setState(() {
                changeLocale(cxt, 'gu');
                Constants.flagvalue= "hi";
                Constants.langvalue='Gujarath';
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'ori',
            child:  const Text('Odia'),
            onTap: () {
              setState(() {
                changeLocale(cxt, 'ori');
                Constants. flagvalue= "hi";
                Constants.langvalue='Odia';
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'bn',
            child:  const Text('Bengali'),
            onTap: () {
              setState(() {
                changeLocale(cxt, 'bn');
                Constants.flagvalue= "hi";
                Constants.langvalue='Bengali';
              });
            },
          ),

          /// english Language
          PopupMenuItem<String>(
            value: 'en_US',
            child: const Text('English'),
            onTap: () {
           setState(() {
             changeLocale(cxt, 'en_US');
             Constants.flagvalue= "en";
             Constants. langvalue='English';
           });
              //changeHomeViewLanguage();
            },
          ),

          ///requested language
          PopupMenuItem<String>(
            value: 'es',
            child: Row(
              children: [
                const Text('Requested Language'),
              ],
            ),
            onTap: () {
              requesteLanguagePopup(context);
            },
          ),

        ],
        elevation: 8.0,
        useRootNavigator: true);
  }

  _showSettingsPopupMenu(cxt) async {
    double height=MediaQuery.of(cxt).size.height;
    double width=MediaQuery.of(cxt).size.width;

    await showMenu(
        context: context,
        color: const Color(0xffFFFFFF),
        surfaceTintColor: const Color(0xffFFFFFF),
        shadowColor: Colors.black12,
        position:  const RelativeRect.fromLTRB(60, 70, 15, 55),
        items: [


          PopupMenuItem<String>(
            value: 'st',
            child:  const Text('Settings'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  SettingsTabs(),));
            },
          ),
          PopupMenuItem<String>(
            value: 'about us',
            child:  const Text('About Us'),
            onTap: () {
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  AboutUsTab(),));
              });
            },
          ),
          PopupMenuItem<String>(
            value: 'logout',
            child:  const Text('Logout'),
            onTap: () {
   _signOut();
            },
          ),


        ],
        elevation: 8.0,
        useRootNavigator: true);
  }

  ViewinUserDetailsPopup() async {

    bool currentUserVerifyed=false;
    var document =
        await FirebaseFirestore.instance.collection("Users").doc(viewDocid).get();
    Map<String, dynamic>? value = document.data();
    setState(() {
      firstNamecon.text = value!['Name'].toString();
      middleNamecon.text = value["middleName"].toString();
      lastNamecon.text = value["lastName"].toString();
      adreesscon.text = value['Address'].toString();
      emailIDcon.text = value['email'].toString();
      gendercon.text = value['Gender'].toString();
      occupationcon.text = value['Occupation'].toString();
      phoneNumbercon.text = value['Phone'].toString();
      dateofBirthcon.text = value['dob'].toString();
      alterEmailIdcon.text = value['alteremail'].toString();
      aadhaarNumbercon.text = value['aadhaarNo'].toString();
      mobileNumbercon.text = value['mobileNo'].toString();
      citycon.text = value['city'].toString();
      pinCodecon.text = value['pinCode'].toString();
      statecon.text = value['state'].toString();
      countrycon.text = value['country'].toString();
      yearPassedcon.text = value['yearofpassed'].toString();
      subjectStremdcon.text = value['subjectStream'].toString();
      classcon.text = value['class'].toString();
      rollnocon.text = value['rollNo'].toString();
      lastvisitcon.text = value['lastvisit'].toString();
      housecon.text = value['house'].toString();
      statusmessagecon.text = value['statusmessage'].toString();
      educationquvalificationcon.text = value['educationquvalification'].toString();
      additionalquvalificationcon.text = value['additionalquvalification'].toString();
      designationcon.text = value['designation'].toString();
      company_concerncon.text = value['company_concern'].toString();
      maritalStatuscon.text = value['maritalStatus'].toString();
      spouseNamecon.text = value['spouseName'].toString();
      anniversaryDatecon.text = value['anniversaryDate'].toString();
      no_of_childreancon.text = value['childreancount'].toString();
      imgUrl = value['UserImg'].toString();
      alumniEmployedController.text=value['workingStatus'].toString();
      currentUserVerifyed=value['verifyed'];
      // ownBussinesscon.text=value['Ownbusiness'].toString();
    });


    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;


    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return showDialog(context: context, builder: (context) {
      return
        AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
         decoration: BoxDecoration(
                 color:Colors.white,
           borderRadius: BorderRadius.circular(10)
         ),
            width: width/1.138333,

            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 170.75,
                  vertical: height / 81.375),
              child: SizedBox(
                width: width/1.138333,
                child: Padding(
                  padding: EdgeInsets.only(left:width/17.075),
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: height / 26.04),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            SizedBox(width: width/307.2),
                            KText(
                              text: 'Users Details',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: const Color(0xff030229),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height / 26.04),

                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width/3.7463,
                              child: Row(
                                children: [
                                  Container(
                                    height:  height/6.8,
                                    width: width/14.36,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            100),
                                        color:
                                        const Color(0xffDDDEEE),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(imgUrl)
                                        )),
                                    child:Center(child: imgUrl==""?Icon(Icons.person,size:width/22.76):Text(""),)
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/2.2588,
                              height: height/2.8,
                              child: Column(
                                children: [
                                  ///first name and last name
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'First Name *',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                              height: height/15.114,
                                              width: width/8.0842,
                                              decoration: BoxDecoration(
                                                  color: const Color(
                                                      0xffDDDEEE),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      3)),
                                              child:
                                              TextFormField(
                                                readOnly: true,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                controller:firstNamecon,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                      RegExp("[a-zA-Z ]")),
                                                ],
                                                maxLength: 25,
                                                decoration: const InputDecoration(
                                                  border: InputBorder
                                                      .none,
                                                  contentPadding: EdgeInsets.only(
                                                      bottom:
                                                      10,
                                                      top:
                                                      2,
                                                      left:
                                                      10),
                                                  counterText:
                                                  "",
                                                ),



                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'Middle Name ',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/8.0842,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                  maxLength:25,
                                                  readOnly: true,
                                                  controller:
                                                  middleNamecon,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[a-zA-Z ]")),
                                                  ],
                                                  decoration:
                                                  const InputDecoration(
                                                    counterText:"",
                                                    border: InputBorder
                                                        .none,
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'Last Name *',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/8.0842,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  lastNamecon,

                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[a-zA-Z ]")),
                                                  ],
                                                  maxLength:
                                                  25,
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    counterText:
                                                    "",
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                  validator: (value) => value!
                                                      .isEmpty
                                                      ? 'Field is required'
                                                      : null,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: height/73.9),

                                  ///date of birth and

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      /// date of birth
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'Date Of Birth *',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                              height: height/15.114,
                                              width: width/5.12,
                                              decoration: BoxDecoration(
                                                  color: const Color(
                                                      0xffDDDEEE),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      3)),
                                              child:
                                              TextFormField(
                                                readOnly: true,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                controller:
                                                dateofBirthcon,
                                                decoration:
                                                const InputDecoration(
                                                  border:
                                                  InputBorder
                                                      .none,
                                                  contentPadding: EdgeInsets.only(
                                                      bottom:
                                                      10,
                                                      top: 2,
                                                      left:
                                                      10),
                                                ),


                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text: 'Gender ',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/5.12,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  controller:
                                                  gendercon,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[a-zA-Z]")),
                                                  ],
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: height/73.9),

                                  ///adhaaar card and emailid
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'Alternate Email Id',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/5.12,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  controller:
                                                  alterEmailIdcon,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[a-z@0-9.]")),
                                                  ],
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                  validator:
                                                      (value) {
                                                    // if (isEmail(value!)) {
                                                    //     return 'Enter the Correct the Email';
                                                    //   }

                                                    return null;
                                                  },
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'Aadhaar Number ',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/5.12,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  controller:
                                                  aadhaarNumbercon,
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    counterText:
                                                    "",
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                        ///contact info
                        Row(
                          children: [
                            SizedBox(width: width/307.2),
                            KText(
                              text: 'Contact Details',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 25 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4,
                              right: 4,
                              top: 4,
                              bottom: 4),
                          child: Container(
                            height: 1,
                            width: width/1.4422,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(height: height/36.95),
                        Row(
                          children: [
                            SizedBox(
                                width: width/2.4,
                                height: height/2.8,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(6.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceAround,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      ///phone number
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'Phone Number *',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/3.84,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  phoneNumbercon,
                                                  maxLength:
                                                  10,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[0-9]")),
                                                  ],
                                                  decoration: const InputDecoration(
                                                      border: InputBorder
                                                          .none,
                                                      contentPadding: EdgeInsets.only(
                                                          bottom:
                                                          10,
                                                          top:
                                                          2,
                                                          left:
                                                          10),
                                                      counterText:
                                                      ""),
                                                  validator:
                                                      (value) {
                                                    if (value!
                                                        .isNotEmpty) {
                                                      if (value.length !=
                                                          10) {
                                                        return 'Enter the Phone no correctly';
                                                      }
                                                    }
                                                    return null;
                                                  },
                                                ))
                                          ],
                                        ),
                                      ),

                                      /// mobile number
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'Alternate Mobile Number',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/3.84,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  mobileNumbercon,
                                                  maxLength:
                                                  10,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[0-9]")),
                                                  ],
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    counterText: "",
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                  validator: (value) {
                                                    if (value!
                                                        .isNotEmpty) {
                                                      if (value.length !=
                                                          10) {
                                                        return 'Enter the Mobile no correctly';
                                                      }
                                                    }
                                                    return null;
                                                  },
                                                ))
                                          ],
                                        ),
                                      ),

                                      /// Email iD
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'Email ID',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/3.84,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  controller:
                                                  emailIDcon,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[a-z@0-9.]")),
                                                  ],
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              width: width/3.49090,
                              height: height/2.8,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    KText(
                                      text: 'Address',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: 20 * ffem,
                                        fontWeight:
                                        FontWeight.w700,
                                        height: 1.3625 *
                                            ffem /
                                            fem,
                                        color:
                                        const Color(0xff000000),
                                      ),
                                    ),
                                    SizedBox(height: height/123.1666),
                                    Container(
                                        height: height/3.3,
                                        width: width/3.57209,
                                        decoration: BoxDecoration(
                                            color: const Color(
                                                0xffDDDEEE),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                3)),
                                        child: TextFormField(
                                            readOnly: true,
                                          controller:
                                          adreesscon,
                                          maxLines: null,
                                          expands: true,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .allow(RegExp(
                                                "[a-zA-Z0-9 ,]")),
                                          ],
                                          decoration:
                                          const InputDecoration(
                                            border:
                                            InputBorder
                                                .none,
                                            contentPadding:
                                            EdgeInsets.only(
                                                bottom:
                                                10,
                                                top: 10,
                                                left: 10),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            children: [
                              ///State Dropdown
                              SizedBox(
                                height: height/7.5,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    KText(
                                      text: 'State *',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: 20 * ffem,
                                        fontWeight:
                                        FontWeight.w700,
                                        height: 1.3625 *
                                            ffem /
                                            fem,
                                        color:
                                        const Color(0xff000000),
                                      ),
                                    ),
                                    SizedBox(height: height/123.1666),
                                    Container(
                                        height: height/15.114,
                                        width: width/6.4,
                                        decoration: BoxDecoration(
                                            color: const Color(
                                                0xffDDDEEE),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                3)),
                                        padding:const EdgeInsets.only(left:5),
                                        child:
                                        TextField(
                                            readOnly: true,
                                          controller:statecon,
                                          decoration:
                                          const InputDecoration(
                                            border: InputBorder
                                                .none,
                                            contentPadding:
                                            EdgeInsets.only(
                                                bottom: 10,
                                                top: 2,
                                                left: 10),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: width/46.5454),

                              ///city
                              SizedBox(
                                height: height/7.5,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    KText(
                                      text: 'City *',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: 20 * ffem,
                                        fontWeight:
                                        FontWeight.w700,
                                        height: 1.3625 *
                                            ffem /
                                            fem,
                                        color:
                                        const Color(0xff000000),
                                      ),
                                    ),
                                    SizedBox(height: height/123.1666),
                                    Container(
                                        height: height/15.114,
                                        width: width/6.4,
                                        decoration: BoxDecoration(
                                            color: const Color(
                                                0xffDDDEEE),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                3)),
                                        child:TextField(
                                            readOnly: true,
                                          controller:citycon,
                                          decoration:
                                          const InputDecoration(
                                            border: InputBorder
                                                .none,
                                            contentPadding:
                                            EdgeInsets.only(
                                                bottom: 10,
                                                top: 2,
                                                left: 10),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: width/43.8857),

                              ///Pin Code
                              SizedBox(
                                height: height/7.5,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    KText(
                                      text: 'Pin Code *',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: 20 * ffem,
                                        fontWeight:
                                        FontWeight.w700,
                                        height: 1.3625 *
                                            ffem /
                                            fem,
                                        color:
                                        const Color(0xff000000),
                                      ),
                                    ),
                                    SizedBox(height: height/123.1666),
                                    Container(
                                        height: height/15.114,
                                        width: width/6.4,
                                        decoration: BoxDecoration(
                                            color: const Color(
                                                0xffDDDEEE),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                3)),
                                        child: TextFormField(
                                            readOnly: true,
                                          controller:
                                          pinCodecon,
                                          maxLength: 6,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .allow(RegExp(
                                                "[0-9]")),
                                          ],
                                          decoration:
                                          const InputDecoration(
                                            border:
                                            InputBorder
                                                .none,
                                            contentPadding:
                                            EdgeInsets.only(
                                                bottom:
                                                10,
                                                top: 2,
                                                left: 10),
                                            counterText: "",
                                          ),
                                          validator: (value) {
                                            if (value!
                                                .isEmpty) {
                                              return 'Field is required';
                                            } else if (value!
                                                .isNotEmpty) {
                                              if (value!
                                                  .length <
                                                  6) {
                                                return 'Please Enter Pin code Correctly';
                                              }
                                            }
                                            return null;
                                          },
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(width: width/43.8857),

                              ///Country Dropdown
                              SizedBox(
                                height: height/7.5,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    KText(
                                      text: 'Country *',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: 20 * ffem,
                                        fontWeight:
                                        FontWeight.w700,
                                        height: 1.3625 *
                                            ffem /
                                            fem,
                                        color:
                                        const Color(0xff000000),
                                      ),
                                    ),
                                    SizedBox(height: height/123.1666),
                                    Container(
                                        height: height/15.114,
                                        width: width/6.4,
                                        decoration: BoxDecoration(
                                            color: const Color(
                                                0xffDDDEEE),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                3)),
                                        child:TextField(
                                            readOnly: true,
                                          controller:countrycon,
                                          decoration:
                                          const InputDecoration(
                                            border: InputBorder
                                                .none,
                                            contentPadding:
                                            EdgeInsets.only(
                                                bottom: 10,
                                                top: 2,
                                                left: 10),
                                          ),
                                        )
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///alumni details
                        SizedBox(height: height/36.95),
                        Row(
                          children: [
                            SizedBox(width: width/307.2),
                            KText(
                              text: 'Alumni Details',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 25 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4,
                              right: 4,
                              top: 4,
                              bottom: 4),
                          child: Container(
                            height: 1,
                            width: width/1.4422,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(height: height/36.95),

                        Row(
                          children: [
                            SizedBox(
                              height: height/2.8,
                              width: width/2.19428,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  ///subject stream and containers
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'Year Passed *',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/4.6545,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                  readOnly:true,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller: yearPassedcon,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[0-9]")),
                                                  ],
                                                  onTap:() async {
                                                    final DateTime? picked = await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime.now(),
                                                      initialDatePickerMode: DatePickerMode.year,
                                                    );

                                                    if (picked != null && picked != DateTime.now()) {
                                                      print('Selected year: ${picked.year}');
                                                      setState((){
                                                        yearPassedcon.text=picked.year.toString();
                                                      });
                                                    }
                                                  },
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                  validator: (value) => value!
                                                      .isEmpty
                                                      ? 'Field is required'
                                                      : null,
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'Department *',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/4.6545,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  controller:
                                                  subjectStremdcon,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[a-zA-Z ]")),
                                                  ],
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                  // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                )

                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///class anb roll no container

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text: 'Class *',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/4.6545,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  classcon,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[a-zA-Z ]")),
                                                  ],
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                  validator: (value) => value!
                                                      .isEmpty
                                                      ? 'Field is required'
                                                      : null,
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text: 'Roll No',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/4.6545,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  controller:
                                                  rollnocon,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[a-zA-Z0-9 ]")),
                                                  ],
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                  //validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///house and last visit container
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text: 'House',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/4.6545,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  controller:
                                                  housecon,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[a-zA-Z0-9 ]")),
                                                  ],
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                  //  validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height/9.369,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            KText(
                                              text:
                                              'Your Last Visit',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                height:
                                                1.3625 *
                                                    ffem /
                                                    fem,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                            ),
                                            SizedBox(
                                                height: height/123.1666),
                                            Container(
                                                height: height/15.114,
                                                width: width/4.6545,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xffDDDEEE),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child:
                                                TextFormField(
                                                    readOnly: true,
                                                  controller:
                                                  lastvisitcon,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                        RegExp("[a-zA-Z0-9 ]")),
                                                  ],
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder
                                                        .none,
                                                    contentPadding: EdgeInsets.only(
                                                        bottom:
                                                        10,
                                                        top:
                                                        2,
                                                        left:
                                                        10),
                                                  ),
                                                  // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 25),
                              child: SizedBox(
                                height: height/2.8,
                                width: width/4.1513,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    KText(
                                      text:
                                      'My Status Message *',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: 20 * ffem,
                                        fontWeight:
                                        FontWeight.w700,
                                        height: 1.3625 *
                                            ffem /
                                            fem,
                                        color:
                                        const Color(0xff000000),
                                      ),
                                    ),
                                    SizedBox(height: height/123.1666),
                                    Container(
                                        height: height/3.15,
                                        width: width/4.45217,
                                        decoration: BoxDecoration(
                                            color: const Color(
                                                0xffDDDEEE),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                3)),
                                        child: TextFormField(
                                            readOnly: true,
                                          controller:
                                          statusmessagecon,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          maxLines: null,
                                          expands: true,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .allow(RegExp(
                                                "[a-zA-Z ,]")),
                                          ],
                                          decoration:
                                          const InputDecoration(
                                            border:
                                            InputBorder
                                                .none,
                                            contentPadding:
                                            EdgeInsets.only(
                                                bottom:
                                                10,
                                                top: 10,
                                                left: 10),
                                          ),
                                          validator: (value) =>
                                          value!.isEmpty
                                              ? 'Field is required'
                                              : null,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///alumni education Qualifications
                        SizedBox(height: height/36.95),
                        Row(
                          children: [
                            SizedBox(width: width/307.2),
                            KText(
                              text: 'Alumni Qualifications',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 25 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4,
                              right: 4,
                              top: 4,
                              bottom: 4),
                          child: Container(
                            height: 1,
                            width: width/1.4422,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(height: height/36.95),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                KText(
                                  text:
                                  'Educational Qualification',
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: 20 * ffem,
                                    fontWeight:
                                    FontWeight.w700,
                                    height:
                                    1.3625 * ffem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                                SizedBox(height: height/123.1666),
                                Container(
                                    height: height/10.5571,
                                    width: width/3.01176,
                                    decoration: BoxDecoration(
                                        color: const Color(
                                            0xffDDDEEE),
                                        borderRadius:
                                        BorderRadius
                                            .circular(3)),
                                    child: TextFormField(
                                        readOnly: true,
                                      controller:
                                      educationquvalificationcon,
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .allow(RegExp(
                                            "[a-zA-Z ]")),
                                      ],
                                      decoration:
                                      const InputDecoration(
                                        border:
                                        InputBorder.none,
                                        contentPadding:
                                        EdgeInsets.only(
                                            bottom: 10,
                                            top: 2,
                                            left: 10),
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(width: width/30.72),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                KText(
                                  text:
                                  'Additional Qualification',
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: 20 * ffem,
                                    fontWeight:
                                    FontWeight.w700,
                                    height:
                                    1.3625 * ffem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                                SizedBox(height: height/123.1666),
                                Container(
                                    height: height/10.5571,
                                    width: width/3.01176,
                                    decoration: BoxDecoration(
                                        color: const Color(
                                            0xffDDDEEE),
                                        borderRadius:
                                        BorderRadius
                                            .circular(3)),
                                    child: TextFormField(
                                        readOnly: true,
                                      controller:
                                      additionalquvalificationcon,
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .allow(RegExp(
                                            "[a-zA-Z ]")),
                                      ],
                                      decoration:
                                      const InputDecoration(
                                        border:
                                        InputBorder.none,
                                        contentPadding:
                                        EdgeInsets.only(
                                            bottom: 10,
                                            top: 2,
                                            left: 10),
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: height/36.95),
                        Row(
                          children: [
                            SizedBox(width: width/307.2),
                            KText(
                              text: 'Professional Details',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 25 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4,
                              right: 4,
                              top: 4,
                              bottom: 4),
                          child: Container(
                            height: 1,
                            width: width/1.4422,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(height: height/36.95),

                        Row(
                          children: [
                            SizedBox(
                              height: height/9.369,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Are You Working',
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 20 * ffem,
                                      fontWeight:
                                      FontWeight.w700,
                                      height:
                                      1.3625 * ffem / fem,
                                      color:
                                      const Color(0xff000000),
                                    ),
                                  ),
                                  SizedBox(height: height/123.1666),
                                  Container(
                                      height: height/15.114,
                                      width: width/6.6782,
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xffDDDEEE),
                                          borderRadius:
                                          BorderRadius
                                              .circular(3)),
                                      child:
                                      TextField(
                                          readOnly: true,
                                          controller:alumniEmployedController,
                                        decoration:
                                        const InputDecoration(
                                          border: InputBorder
                                              .none,
                                          contentPadding:
                                          EdgeInsets.only(
                                              bottom: 10,
                                              top: 2,
                                              left: 10),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                            /*    ///ownBussinesscon

                                                    Padding(
                                                    padding:EdgeInsets.only(left:width/68.0666),
                                                child:
                                                SizedBox(
                                                  height: height/9.369,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      KText(
                                                        text: 'Own Business',
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: 20 * ffem,
                                                          fontWeight: FontWeight.w700,
                                                          height: 1.3625 * ffem / fem,
                                                          color: const Color(0xff000000),
                                                        ),
                                                      ),
                                                      SizedBox(height: height/123.1666),
                                                      Container(
                                                          height: height/15.114,
                                                          width: width/4.6545,
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xffDDDEEE),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(3)),
                                                          child: TextFormField(
                                                            controller: ownBussinesscon,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                  "[a-zA-Z]")),
                                                            ],
                                                            decoration:
                                                            const InputDecoration(
                                                              border:
                                                              InputBorder.none,
                                                              contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 10,
                                                                  top: 2,
                                                                  left: 10),
                                                            ),
                                                            // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                          ))
                                                    ],
                                                  ),
                                                )),*/

                          ],
                        ),
                        SizedBox(height: height/36.95),
                        alumniEmployedController.text=="Yes"?
                        Row(
                          children: [
                            SizedBox(
                              height: height/9.369,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Occupations',
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 20 * ffem,
                                      fontWeight:
                                      FontWeight.w700,
                                      height:
                                      1.3625 * ffem / fem,
                                      color:
                                      const Color(0xff000000),
                                    ),
                                  ),
                                  SizedBox(height: height/123.1666),
                                  Container(
                                      height: height/15.114,
                                      width: width/4.6545,
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xffDDDEEE),
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              3)),
                                      child: TextFormField(
                                          readOnly: true,
                                        controller:
                                        occupationcon,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .allow(RegExp(
                                              "[a-zA-Z ]")),
                                        ],
                                        decoration:
                                        const InputDecoration(
                                          border: InputBorder
                                              .none,
                                          contentPadding:
                                          EdgeInsets.only(
                                              bottom: 10,
                                              top: 2,
                                              left: 10),
                                        ),
                                        // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(width: width/38.4),
                            SizedBox(
                              height: height/9.369,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Designation',
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 20 * ffem,
                                      fontWeight:
                                      FontWeight.w700,
                                      height:
                                      1.3625 * ffem / fem,
                                      color:
                                      const Color(0xff000000),
                                    ),
                                  ),
                                  SizedBox(height: height/123.1666),
                                  Container(
                                      height: height/15.114,
                                      width: width/4.6545,
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xffDDDEEE),
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              3)),
                                      child: TextFormField(
                                          readOnly: true,
                                        controller:
                                        designationcon,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .allow(RegExp(
                                              "[a-zA-Z ]")),
                                        ],
                                        decoration:
                                        const InputDecoration(
                                          border: InputBorder
                                              .none,
                                          contentPadding:
                                          EdgeInsets.only(
                                              bottom: 10,
                                              top: 2,
                                              left: 10),
                                        ),
                                        //validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(width: width/38.4),
                            SizedBox(
                              height: height/9.369,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text:
                                    "Company/Concern's Name",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 20 * ffem,
                                      fontWeight:
                                      FontWeight.w700,
                                      height:
                                      1.3625 * ffem / fem,
                                      color:
                                      const Color(0xff000000),
                                    ),
                                  ),
                                  SizedBox(height: height/123.1666),
                                  Container(
                                      height: height/15.114,
                                      width: width/4.6545,
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xffDDDEEE),
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              3)),
                                      child: TextFormField(
                                          readOnly: true,
                                        controller:
                                        company_concerncon,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .allow(RegExp(
                                              "[a-zA-Z ]")),
                                        ],
                                        decoration:
                                        const InputDecoration(
                                          border: InputBorder
                                              .none,
                                          contentPadding:
                                          EdgeInsets.only(
                                              bottom: 10,
                                              top: 2,
                                              left: 10),
                                        ),
                                        // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ):
                        alumniEmployedController.text=="Own Business"?
                        Row(
                          children: [


                            SizedBox(
                              height: height/9.369,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text:
                                    "Company Name",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 20 * ffem,
                                      fontWeight:
                                      FontWeight.w700,
                                      height:
                                      1.3625 * ffem / fem,
                                      color:
                                      const Color(0xff000000),
                                    ),
                                  ),
                                  SizedBox(height: height/123.1666),
                                  Container(
                                      height: height/15.114,
                                      width: width/4.6545,
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xffDDDEEE),
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              3)),
                                      child: TextFormField(
                                          readOnly: true,
                                        controller:
                                        company_concerncon,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .allow(RegExp(
                                              "[a-zA-Z ]")),
                                        ],
                                        decoration:
                                        const InputDecoration(
                                          border: InputBorder
                                              .none,
                                          contentPadding:
                                          EdgeInsets.only(
                                              bottom: 10,
                                              top: 2,
                                              left: 10),
                                        ),
                                        // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(width: width/38.4),
                            SizedBox(
                              height: height/9.369,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Type',
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 20 * ffem,
                                      fontWeight:
                                      FontWeight.w700,
                                      height:
                                      1.3625 * ffem / fem,
                                      color:
                                      const Color(0xff000000),
                                    ),
                                  ),
                                  SizedBox(height: height/123.1666),
                                  Container(
                                      height: height/15.114,
                                      width: width/4.6545,
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xffDDDEEE),
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              3)),
                                      child: TextFormField(
                                          readOnly: true,
                                        controller:
                                        occupationcon,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .allow(RegExp(
                                              "[a-zA-Z ]")),
                                        ],
                                        decoration:
                                        const InputDecoration(
                                          border: InputBorder
                                              .none,
                                          contentPadding:
                                          EdgeInsets.only(
                                              bottom: 10,
                                              top: 2,
                                              left: 10),
                                        ),
                                        // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ):
                        const SizedBox(),

                        ///Material Status
                        SizedBox(height: height/36.95),
                        Row(
                          children: [
                            SizedBox(width: width/307.2),
                            KText(
                              text: 'Marital Information',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 25 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4,
                              right: 4,
                              top: 4,
                              bottom: 4),
                          child: Container(
                            height: 1,
                            width: width/1.4422,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(height: height/36.95),
                        Row(
                          children: [
                            SizedBox(
                              height: height/9.369,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Are You Married',
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 20 * ffem,
                                      fontWeight:
                                      FontWeight.w700,
                                      height:
                                      1.3625 * ffem / fem,
                                      color:
                                      const Color(0xff000000),
                                    ),
                                  ),
                                  SizedBox(height: height/123.1666),
                                  Container(
                                      height: height/15.114,
                                      width: width/6.6782,
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xffDDDEEE),
                                          borderRadius:
                                          BorderRadius
                                              .circular(3)),
                                      child:
                                      TextField(
                                          readOnly: true,
                                        controller:maritalStatuscon,
                                        decoration:
                                        const InputDecoration(
                                          border: InputBorder
                                              .none,
                                          contentPadding:
                                          EdgeInsets.only(
                                              bottom: 10,
                                              top: 2,
                                              left: 10),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: width/38.4),
                            maritalStatuscon.text == "Yes"
                                ? SizedBox(
                                child: Row(children: [
                                  SizedBox(
                                    height: height/9.369,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        KText(
                                          text:
                                          'Spouse Name',
                                          style:
                                          SafeGoogleFont(
                                            'Nunito',
                                            fontSize:
                                            20 * ffem,
                                            fontWeight:
                                            FontWeight
                                                .w700,
                                            height: 1.3625 *
                                                ffem /
                                                fem,
                                            color: const Color(
                                                0xff000000),
                                          ),
                                        ),
                                        SizedBox(height: height/123.1666),
                                        Container(
                                            height: height/15.114,
                                            width: width/6.4,
                                            decoration: BoxDecoration(
                                                color: const Color(
                                                    0xffDDDEEE),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    3)),
                                            child:
                                            TextFormField(
                                                readOnly: true,
                                              controller:
                                              spouseNamecon,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                    "[a-zA-Z ]")),
                                              ],
                                              decoration:
                                              const InputDecoration(
                                                border:
                                                InputBorder
                                                    .none,
                                                contentPadding: EdgeInsets.only(
                                                    bottom:
                                                    10,
                                                    top: 2,
                                                    left:
                                                    10),
                                              ),
                                              //validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: width/38.4),
                                  SizedBox(
                                    height: height/9.369,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        KText(
                                          text:
                                          "Anniversary Date ",
                                          style:
                                          SafeGoogleFont(
                                            'Nunito',
                                            fontSize:
                                            20 * ffem,
                                            fontWeight:
                                            FontWeight
                                                .w700,
                                            height: 1.3625 *
                                                ffem /
                                                fem,
                                            color: const Color(
                                                0xff000000),
                                          ),
                                        ),
                                        SizedBox(height: height/123.1666),
                                        Container(
                                            height: height/15.114,
                                            width: width/6.4,
                                            decoration: BoxDecoration(
                                                color: const Color(
                                                    0xffDDDEEE),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    3)),
                                            child:
                                            TextFormField(

                                              readOnly:
                                              true,
                                              controller:
                                              anniversaryDatecon,
                                              decoration:
                                              const InputDecoration(
                                                border:
                                                InputBorder
                                                    .none,
                                                contentPadding: EdgeInsets.only(
                                                    bottom:
                                                    10,
                                                    top: 2,
                                                    left:
                                                    10),
                                              ),

                                              // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: width/38.4),
                                  SizedBox(
                                    height: height/9.369,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        KText(
                                          text:
                                          "No. Of Chindren",
                                          style:
                                          SafeGoogleFont(
                                            'Nunito',
                                            fontSize:
                                            20 * ffem,
                                            fontWeight:
                                            FontWeight
                                                .w700,
                                            height: 1.3625 *
                                                ffem /
                                                fem,
                                            color: const Color(
                                                0xff000000),
                                          ),
                                        ),
                                        SizedBox(height: height/123.1666),
                                        Container(
                                            height: height/15.114,
                                            width: width/6.4,
                                            decoration: BoxDecoration(
                                                color: const Color(
                                                    0xffDDDEEE),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    3)),
                                            child:
                                            TextFormField(
                                                readOnly: true,
                                              controller:
                                              no_of_childreancon,
                                              maxLength: 2,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                    "[0-9]")),
                                              ],
                                              decoration:
                                              const InputDecoration(
                                                border:
                                                InputBorder
                                                    .none,
                                                contentPadding: EdgeInsets.only(
                                                    bottom:
                                                    10,
                                                    top: 2,
                                                    left:
                                                    10),
                                                counterText:
                                                "",
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ]))
                                : const SizedBox(),
                          ],
                        ),
                        SizedBox(height: height/24.633),

                        ///buttons Verifyed  and Close

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width/2.2925,
                            ),

                            ///Verify button
                            GestureDetector(
                              onTap: () {
                                FirebaseFirestore.instance.collection("Users").doc(viewDocid).update({
                                  "verifyed": !currentUserVerifyed
                                });
                                UnVeriFyedUserData();
                                Navigator.pop(context);
                                Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) =>MyWidget(email: FirebaseAuth.instance.currentUser!.email)
                                ));



                              },
                              child: Container(
                                  height: height/18.475,
                                  width: width/12.8,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffD60A0B),
                                    borderRadius:
                                    BorderRadius.circular(
                                        4),
                                  ),
                                  child: Center(
                                    child: KText(
                                      text:currentUserVerifyed==true?"Un Verifyed": 'Verify',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: 19 * ffem,
                                        fontWeight:
                                        FontWeight.w400,
                                        height: 1.3625 *
                                            ffem /
                                            fem,
                                        color:
                                        const Color(0xffFFFFFF),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: width/76.8,
                            ),



                            ///Close Button
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: height/18.475,
                                  width: width/12.8,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                    BorderRadius.circular(
                                        4),
                                  ),
                                  child: Center(
                                    child: KText(
                                      text: 'Close',
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: 19 * ffem,
                                        fontWeight:
                                        FontWeight.w400,
                                        height: 1.3625 *
                                            ffem /
                                            fem,
                                        color:
                                        const Color(0xffFFFFFF),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(height: height/24.633),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
    },);



  }


  /// requested language popup


requesteLanguagePopup(ctx){

  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  Size size = MediaQuery.of(context).size;
    return showDialog(context: context, builder: (ctx) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          width: width / 3.2418,
          height:270,
          margin: EdgeInsets.symmetric(horizontal: width / 68.3, vertical: height / 32.55),
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
                height: size.height * 0.1,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 68.3, vertical: height / 81.375),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(
                        text: "Requested Language",
                        style: SafeGoogleFont(
                          'Nunito',
                          fontSize: width / 88.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xffF7FAFC),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  padding: EdgeInsets.symmetric(horizontal: width / 68.3, vertical: height / 32.55),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: "Language Name ",
                                style: SafeGoogleFont(
                                  'Nunito',
                                  fontSize: width / 105.571,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: height / 108.5),
                              Material(
                                borderRadius: BorderRadius.circular(3),
                                color: Color(0xffDDDEEE),
                                elevation: 5,
                                child: SizedBox(
                                  height: height / 16.02,
                                  width: size.width * 0.17,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height / 81.375,
                                        horizontal: width / 170.75),
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .allow(RegExp(
                                            "[a-zA-Z ]")),
                                      ],
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: width / 105.571,
                                      ),
                                      minLines: 1,
                                      controller: requestedLanguageController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width / 105.571,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),

                      Padding(
                        padding:  EdgeInsets.only(top:30),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width/10.6,
                            ),

                            /// Submit Button
                            GestureDetector(
                              onTap: () async {
                                if (requestedLanguageController.text !=  "") {
                                  Navigator.pop(context);
                                  CoolAlert.show(
                                    barrierDismissible: true,
                                      context: ctx,
                                      type: CoolAlertType.success,
                                      text: "Requested Language  Submitted successfully!",
                                      width: size.width * 0.4,
                                      backgroundColor: Constants()
                                         .primaryAppColor
                                          .withOpacity(0.8));
                                  FirebaseFirestore.instance.collection("requestlanguage").doc().set({
                                    "name":requestedLanguageController.text,
                                    "timestamp":DateTime.now().millisecondsSinceEpoch,
                                    "date":"${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                                    "time":DateFormat("hh:mm a").format(DateTime.now())
                                  });
                                  setState(() {
                                    requestedLanguageController.clear();
                                  });
                                }
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
                                      text: 'Submit',
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
                                  requestedLanguageController.clear();
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
              ),
            ],
          ),
        ),
      );
    },);

}

  LogoutPopup() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ZoomIn(
          duration: Duration(milliseconds: 300),
          child: Padding(
            padding: EdgeInsets.only(
                top: height / 4.61875,
                bottom: height / 4.61875,
                left: width / 3.84,
                right: width / 3.84),
            child: Material(
              color: Colors.white,
              shadowColor: Color(0xff245BCA),
              borderRadius: BorderRadius.circular(8),
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Scaffold(
                  backgroundColor: Color(0xffFFFFFF),
                  body: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height / 9.2375),
                        KText(
                            text: "Are You Sure Want to Logout",
                            style: SafeGoogleFont('Nunito',
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: width / 85.3333)),
                        SizedBox(height: height / 36.95),
                        SizedBox(
                          height: height / 4.105555,
                          width: width / 8.53333,
                          child: SvgPicture.asset(Constants().userLogoutSvg),
                        ),
                        SizedBox(height: height / 36.95),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: height / 18.475,
                                width: width / 8.5333,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: KText(
                                      text: "Cancel",
                                      style: SafeGoogleFont('Nunito',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: width / 96)),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _signOut();
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: height / 18.475,
                                width: width / 8.5333,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Constants().primaryAppColor),
                                child: Center(
                                  child: KText(
                                    text: "Okay",
                                    style: SafeGoogleFont('Nunito',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: width / 96),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SigninPage(),
        ));
  }
}



