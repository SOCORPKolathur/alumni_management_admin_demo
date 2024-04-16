import 'package:alumni_management_admin/Constant_.dart';
import 'package:alumni_management_admin/utils.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../Models/Language_Model.dart';
import '../common_widgets/developer_card_widget.dart';

class UsersManagement extends StatefulWidget {
  String?Username;
   UsersManagement({this.Username});

  @override
  State<UsersManagement> createState() => _UsersManagementState();
}

class _UsersManagementState extends State<UsersManagement> {

  bool dashboard = false;
  bool alumnitracking = false;
  bool users = false;
  bool faculty = false;
  bool gallery = false;

  bool acidemicyear = false;
  bool department = false;
  bool classes = false;
  bool houses = false;
  bool userManagement = false;
  bool loginreports = false;

  bool messages = false;


  bool  email= false;
  bool  sms= false;
  bool  notifications= false;
  bool  blogs= false;
  bool  audiopodcast= false;

  bool  events= false;
  bool  collageact= false;
  bool  jobads= false;
  bool  jobpost= false;
  bool  socialmedia= false;



  String Uservalue="Select";
  String Userdocid="";
  String Authusertype="admin";

  final  _formKey=GlobalKey<FormState>();

  List<String>PermissionLis = [];
  List<String>list = [];

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter the Correct the Email'
        : null;


  }
  TextEditingController userName=TextEditingController();
  TextEditingController passWord=TextEditingController();
  @override
  void initState() {
    mangementpermision();
    // TODO: implement initState
    super.initState();
  }

  mangementpermision() async {

    print("User Document idddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    print(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      PermissionLis.clear();
      list.clear();
    });
    setState(() {
      list.add("Select");
    });
    var doc1 = await FirebaseFirestore.instance.collection("AdminUser").get();
    for(int i=0;i<doc1.docs.length;i++){
      setState(() {
        list.add(doc1.docs[i]['username']);
      });
    }
    print(":list fo dicument");
    print(list);
    var document = await FirebaseFirestore.instance.collection("AdminUser").where("username",isEqualTo:widget.Username).get();
    for(int j=0;j<document.docs.length;j++){
      setState(() {
        Uservalue=document.docs[j]['username'];
        Userdocid=document.docs[j].id;
      });
      for(int i=0;i<document.docs[j]['permission'].length;i++){
        if(document.docs[j]['permission'][i]=="dashboard"){
          setState(() {
            dashboard=true;
            PermissionLis.add("dashboard");
          });
        }
        if(document.docs[j]['permission'][i]=="user management"){
          setState(() {
            userManagement=true;
            PermissionLis.add("user management");
          });
        }
        if(document.docs[j]['permission'][i]=="Alumni Tracking"){
          setState(() {
            alumnitracking=true;
            PermissionLis.add("Alumni Tracking");
          });
        }
        if(document.docs[j]['permission'][i]=="users"){
          setState(() {
            users=true;
            PermissionLis.add("users");
          });
        }
        if(document.docs[j]['permission'][i]=="gallery"){
          setState(() {
            gallery=true;
            PermissionLis.add("gallery");
          });
        }
        if(document.docs[j]['permission'][i]=="events"){
          setState(() {
            events=true;
            PermissionLis.add("events");
          });
        }
        if(document.docs[j]['permission'][i]=="Faculty"){
          setState(() {
            faculty=true;
            PermissionLis.add("Faculty");
          });
        }
        if(document.docs[j]['permission'][i]=="messages"){
          setState(() {
            messages=true;
            PermissionLis.add("messages");
          });
        }
        if(document.docs[j]['permission'][i]=="academic year"){
          setState(() {
            acidemicyear=true;
            PermissionLis.add("academic year");
          });
        }
        if(document.docs[j]['permission'][i]=="department"){
          setState(() {
            department=true;
            PermissionLis.add("department");
          });
        }
        if(document.docs[j]['permission'][i]=="Classes"){
          setState(() {
            classes=true;
            PermissionLis.add("Classes");
          });
        }
        if(document.docs[j]['permission'][i]=="Houses"){
          setState(() {
            houses=true;
            PermissionLis.add("Houses");
          });
        }
        if(document.docs[j]['permission'][i]=="login reports"){
          setState(() {
            loginreports=true;
            PermissionLis.add("login reports");
          });
        }
        if(document.docs[j]['permission'][i]=="email"){
          setState(() {
            email=true;
            PermissionLis.add("email");
          });
        }

        if(document.docs[j]['permission'][i]=="SMS"){
          setState(() {
            sms=true;
            PermissionLis.add("SMS");
          });
        }

        if(document.docs[j]['permission'][i]=="notifications"){
          setState(() {
            notifications=true;
            PermissionLis.add("notifications");
          });
        }


        if(document.docs[j]['permission'][i]=="blogs"){
          setState(() {
            blogs=true;
            PermissionLis.add("blogs");
          });
        }
        if(document.docs[j]['permission'][i]=="audio podcasts"){
          setState(() {
            audiopodcast=true;
            PermissionLis.add("audio podcasts");
          });
        }
        if(document.docs[j]['permission'][i]=="collage activities"){
          setState(() {
            collageact=true;
            PermissionLis.add("collage activities");
          });
        }
        if(document.docs[j]['permission'][i]=="job advertisement"){
          setState(() {
            jobads=true;
            PermissionLis.add("job advertisement");
          });
        }
        if(document.docs[j]['permission'][i]=="job posts"){
          setState(() {
            jobpost=true;
            PermissionLis.add("job posts");
          });
        }
        if(document.docs[j]['permission'][i]=="social media"){
          setState(() {
            socialmedia=true;
            PermissionLis.add("social media");
          });
        }

      }
    }
    print("End of the fuinctionnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
    print("End of the fuinctionnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
    print("End of the fuinctionnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");

  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return
      Padding(
        padding:  EdgeInsets.only(left:width/160.75,right: width/170.75,top:height/30.0769),
        child: FadeInRight(
          child: SizedBox(
            height:height/1.0015,
            child: SingleChildScrollView(
              physics:const  ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      KText(
                        text:"User Management",
                      style:  SafeGoogleFont (
                          'Poppins',
                        fontSize: width / 82.538,
                          fontWeight: FontWeight.w600,
                          height: 1.6*ffem/fem,
                          color: Color(0xff05004e),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height/41.143,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width:width/38.4),
                      SizedBox(

                          child: Row(
                            children: [
                              SizedBox(width:width/10.24),
                              KText( text:"Select the Role  : ",style:
                              SafeGoogleFont (
                                'Poppins',
                              )),
                              SizedBox(width:width/153.6),
                              Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xffFFFFFF),
                                child: SizedBox(
                                  width:width/5.464,
                                  height:height/13.02,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2<String>(
                                      isExpanded: true,
                                      hint: KText(
                                          text:'Select',
                                        style:
                                        SafeGoogleFont (
                                          'Poppins',
                                        )
                                      ),
                                      items: list.map((String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: KText(
                                            text: item,
                                          style:  SafeGoogleFont (
                                            'Poppins',
                                          )
                                        ),
                                      ))
                                          .toList(),
                                      value: Uservalue,
                                      onChanged: (String? value) {
                                        setState(() {
                                          Uservalue = value!;
                                        });
                                        setthevalue(value);
                                      },
                                      buttonStyleData:  ButtonStyleData(
                                      ),decoration: InputDecoration(
                                        border: InputBorder.none
                                    ),

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),

                      SizedBox(width:width/51.2),

                      InkWell(
                        onTap: (){
                          adduserdialogBox();
                        },
                        child: Container(
                            width: width/10.5076,
                            height: height/16.275,
                            decoration: BoxDecoration(
                                color: Constants().primaryAppColor,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add,color: Colors.white,),
                                Padding(
                                  padding:  EdgeInsets.only(left:width/170.75),
                                  child: KText( text:"Add User",style:
                                  SafeGoogleFont (
                                    'Poppins',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                  ),),
                                ),
                              ],
                            )
                        ),
                      ),
                      SizedBox(width:width/51.2),
                      InkWell(
                        onTap: (){
                            updatefunction();
                            successpopuop("Permission Add Successfully....");
                        },
                        child: Container(
                            width: width/10.5076,
                            height: height/16.275,
                            decoration: BoxDecoration(
                                color: Constants().primaryAppColor,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child:  Center(child:  KText( text:"Add Permission",style:SafeGoogleFont (
                                'Poppins',
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            ),))
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height/41.143,),

                  Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: width/170.75,
                      vertical: height/81.375
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: height/32.55,),

                        Row(
                          children: [
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: dashboard,
                                      onChanged: (val) {
                                        setState(() {
                                          dashboard = !dashboard;
                                        });
                                        if (dashboard == true) {
                                          PermissionLis.add("dashboard");
                                        }
                                        else{
                                          PermissionLis.remove("dashboard");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"DashBoard"
                                      ,style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: alumnitracking,
                                      onChanged: (val) {
                                        setState(() {
                                          alumnitracking =
                                          !alumnitracking;
                                          if (alumnitracking == true) {
                                            PermissionLis.add("Alumni Tracking");
                                          }
                                          else{
                                            PermissionLis.remove("Alumni Tracking");
                                          }
                                        });
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Alumni Tracking",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: height/36.95,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            KText(
                              text:"Database",
                              style:  SafeGoogleFont (
                                'Poppins',
                                fontSize: width / 82.538,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,

                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 600,
                              child: Divider()),
                        ),
                        SizedBox(height: height/156.95,),
                        Row(
                          children: [
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: users,
                                      onChanged: (val) {
                                        setState(() {
                                          users =
                                          !users;
                                        });
                                        if (users == true) {
                                          PermissionLis.add("users");
                                        }
                                        else{
                                          PermissionLis.remove("users");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Users",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: faculty,
                                      onChanged: (val) {
                                        setState(() {
                                          faculty =
                                          !faculty;
                                        });
                                        if (faculty == true) {
                                          PermissionLis.add("Faculty");
                                        }
                                        else{
                                          PermissionLis.remove("Faculty");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Faculty",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: gallery,
                                      onChanged: (val) {
                                        setState(() {
                                          gallery =
                                          !gallery;
                                        });
                                        if (gallery == true) {
                                          PermissionLis.add("gallery");
                                        }
                                        else{
                                          PermissionLis.remove("gallery");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Gallery",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: height/36.95,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            KText(
                              text:"Masters",
                              style:  SafeGoogleFont (
                                'Poppins',
                                fontSize: width / 82.538,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,

                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 600,
                              child: Divider()),
                        ),
                        SizedBox(height: height/156.95,),
                        Row(
                          children: [
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: acidemicyear,
                                      onChanged: (val) {
                                        setState(() {
                                          acidemicyear =
                                          !acidemicyear;
                                        });
                                        if (acidemicyear == true) {
                                          PermissionLis.add("academic year");
                                        }
                                        else{
                                          PermissionLis.remove("academic year");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Academic year",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: department,
                                      onChanged: (val) {
                                        setState(() {
                                          department =
                                          !department;
                                        });
                                        if (department == true) {
                                          PermissionLis.add("department");
                                        }
                                        else{
                                          PermissionLis.remove("department");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Department",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: classes,
                                      onChanged: (val) {
                                        setState(() {
                                          classes =
                                          !classes;
                                        });
                                        if (classes == true) {
                                          PermissionLis.add("Classes");
                                        }
                                        else{
                                          PermissionLis.remove("Classes");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Classes",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: houses,
                                      onChanged: (val) {
                                        setState(() {
                                          houses =
                                          !houses;
                                        });
                                        if (houses == true) {
                                          PermissionLis.add("Houses");
                                        }
                                        else{
                                          PermissionLis.remove("Houses");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Houses",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: height/36.95,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            KText(
                              text:"Security",
                              style:  SafeGoogleFont (
                                'Poppins',
                                fontSize: width / 82.538,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,

                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 600,
                              child: Divider()),
                        ),
                        SizedBox(height: height/156.95,),
                        Row(
                          children: [
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: userManagement,
                                      onChanged: (val) {
                                        setState(() {
                                          userManagement =
                                          !userManagement;
                                        });
                                        if (userManagement == true) {
                                          PermissionLis.add("user management");
                                        }
                                        else{
                                          PermissionLis.remove("user management");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"User Management",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: loginreports,
                                      onChanged: (val) {
                                        setState(() {
                                          loginreports =
                                          !loginreports;
                                        });
                                        if (loginreports == true) {
                                          PermissionLis.add("login reports");
                                        }
                                        else{
                                          PermissionLis.remove("login reports");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Login Reports",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),



                          ],
                        ),
                        SizedBox(height: height/36.95,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            KText(
                              text:"Communication",
                              style:  SafeGoogleFont (
                                'Poppins',
                                fontSize: width / 82.538,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,

                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 600,
                              child: Divider()),
                        ),
                        SizedBox(height: height/156.95,),
                        Row(
                          children: [
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: messages,
                                      onChanged: (val) {
                                        setState(() {
                                          messages =
                                          !messages;
                                        });
                                        if (messages == true) {
                                          PermissionLis.add("messages");
                                        }
                                        else{
                                          PermissionLis.remove("messages");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Messages",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: sms,
                                      onChanged: (val) {
                                        setState(() {
                                          sms =
                                          !sms;
                                        });
                                        if (sms == true) {
                                          PermissionLis.add("SMS");
                                        }
                                        else{
                                          PermissionLis.remove("SMS");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"SMS",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: email,
                                      onChanged: (val) {
                                        setState(() {
                                          email =
                                          !email;
                                        });
                                        if (email == true) {
                                          PermissionLis.add("email");
                                        }
                                        else{
                                          PermissionLis.remove("email");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Email",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: notifications,
                                      onChanged: (val) {
                                        setState(() {
                                          notifications =
                                          !notifications;
                                        });
                                        if (notifications == true) {
                                          PermissionLis.add("notifications");
                                        }
                                        else{
                                          PermissionLis.remove("notifications");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Notifications",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: blogs,
                                      onChanged: (val) {
                                        setState(() {
                                          blogs =
                                          !blogs;
                                        });
                                        if (blogs == true) {
                                          PermissionLis.add("blogs");
                                        }
                                        else{
                                          PermissionLis.remove("blogs");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Blogs",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: audiopodcast,
                                      onChanged: (val) {
                                        setState(() {
                                          audiopodcast =
                                          !audiopodcast;
                                        });
                                        if (audiopodcast == true) {
                                          PermissionLis.add("audio podcasts");
                                        }
                                        else{
                                          PermissionLis.remove("audio podcasts");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Audio Podcasts",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: height/36.95,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            KText(
                              text:"Engagement",
                              style:  SafeGoogleFont (
                                'Poppins',
                                fontSize: width / 82.538,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,

                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 600,
                              child: Divider()),
                        ),
                        SizedBox(height: height/156.95,),
                        Row(
                          children: [
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: events,
                                      onChanged: (val) {
                                        setState(() {
                                          events =
                                          !events;
                                        });
                                        if (events == true) {
                                          PermissionLis.add("events");
                                        }
                                        else{
                                          PermissionLis.remove("events");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Events",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: collageact,
                                      onChanged: (val) {
                                        setState(() {
                                          collageact =
                                          !collageact;
                                        });
                                        if (collageact == true) {
                                          PermissionLis.add("collage activities");
                                        }
                                        else{
                                          PermissionLis.remove("collage activities");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Collage Activities",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: jobads,
                                      onChanged: (val) {
                                        setState(() {
                                          jobads =
                                          !jobads;
                                        });
                                        if (jobads == true) {
                                          PermissionLis.add("job advertisement");
                                        }
                                        else{
                                          PermissionLis.remove("job advertisement");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Job Advertisement",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: jobpost,
                                      onChanged: (val) {
                                        setState(() {
                                          jobpost =
                                          !jobpost;
                                        });
                                        if (jobpost == true) {
                                          PermissionLis.add("job posts");
                                        }
                                        else{
                                          PermissionLis.remove("job posts");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Job Posts",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/6.83,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: socialmedia,
                                      onChanged: (val) {
                                        setState(() {
                                          socialmedia =
                                          !socialmedia;
                                        });
                                        if (socialmedia == true) {
                                          PermissionLis.add("social media");
                                        }
                                        else{
                                          PermissionLis.remove("social media");
                                        }
                                      }),
                                  SizedBox(width: width/273.2,),
                                  KText( text:"Social Media",style:SafeGoogleFont (
                                    'Poppins',
                                  )),
                                ],
                              ),
                            ),

                          ],
                        ),

                        SizedBox(height: height/36.95,),



                      ],
                    ),
                  ),

                  SizedBox(height: height/130.2,),
                  Row(
                    children: [
                      KText(
                        text:"Users Lists",
                        style:  SafeGoogleFont (
                          'Poppins',
                          fontSize: 25*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6*ffem/fem,
                          color: Color(0xff05004e),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:height/130.2),
                  SizedBox(
                    width:width/1.2418,
                    child:
                    SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            height:height/13.02,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color:  const Color(0xffDDDEEE),
                            ),
                            child: Row(

                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                SizedBox(
                                  width: width/27.32,
                                  height: height/16.275,
                                  child: Center(
                                    child: KText(
                                      text: "SL.No",
                                      style:
                                      SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 19*ffem,
                                        color: Color(0xff000000)
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: width/2.1015,
                                  height: height/16.275,
                                  child: Center(
                                    child: KText(
                                      text:"User Name",
                                      style:
                                      SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 19*ffem,
                                          color: Color(0xff000000)
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: width/6.83,
                                  height: height/16.275,
                                  child: Center(
                                    child: KText(
                                      text:"Password",
                                      style:
                                      SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 19*ffem, color: Color(0xff000000)
                                      ),
                                    ),
                                  ),
                                ),



                                SizedBox(
                                  width: width/6.83,
                                  height: height/16.275,
                                  child: Center(
                                    child: KText(
                                      text: "Actions",
                                      style:
                                      SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 19*ffem,
                                         color: Color(0xff000000)
                                      ),
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ),
                          SizedBox(height:height/81.375),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("AdminUser").orderBy("timestamp").snapshots(),
                            builder: (context, snapshot) {

                              if(snapshot.hasData==null){
                                return const Center(child: CircularProgressIndicator(),);
                              }
                              if(!snapshot.hasData){
                                return const Center(child: CircularProgressIndicator(),);
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {

                                  var data=snapshot.data!.docs[index];
                                  return
                                    Padding(
                                      padding:  EdgeInsets.only(bottom:height/81.375),
                                      child: Material(
                                        color: Color(0xffFFFFFF),
                                        elevation: 20,
                                        borderRadius: BorderRadius.circular(4),
                                        shadowColor: Colors.black12,
                                        child: SizedBox(
                                          height:height/13.02,
                                          child: Row(

                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [


                                              SizedBox(
                                                width: width/27.32,
                                                height: height/14.466,
                                                child: Center(
                                                  child: KText(
                                                    text: (index+1).toString(),
                                                    style:
                                                    SafeGoogleFont (
                                                      'Poppins',
                                                      fontSize: 19*ffem,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                width: width/2.1015,
                                                height: height/14.466,
                                                child: Center(
                                                  child: KText(
                                                    text:   data['username'].toString(),
                                                    style:
                                                    SafeGoogleFont (
                                                      'Poppins',
                                                      fontSize: 19*ffem,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                width: width/6.83,
                                                height: height/14.466,
                                                child: Center(
                                                  child: KText(
                                                    text:   data['password'].toString(),
                                                    style:
                                                    SafeGoogleFont (
                                                      'Poppins',
                                                      fontSize: 19*ffem,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                width: width/6.83,
                                                height: height/14.466,
                                                child:
                                                Center(
                                                  child: InkWell(
                                                    onTap:(){
                                                      _deletepopup(data.id,data['username'].toString());
                                                    },
                                                    child: Material(

                                                      borderRadius: BorderRadius.circular(100),
                                                      color: Colors.white,
                                                      elevation: 10,
                                                      child: Container(
                                                        height:height/21,
                                                        width:width/17.075,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(100),
                                                            color: Colors.white
                                                        ),
                                                        child: const Center(child: Icon(Icons.delete)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                },);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height:height/32.55),

                  SizedBox(height: height / 65.1),
                  DeveloperCardWidget(),
                  SizedBox(height: height / 65.1),

                ],
              ),
            ),
          ),
        ),
      );
  }

  ///Permission update function
  updatefunction() async {

    print("Lists -------------------------------- document Id");
    print(PermissionLis);
    print(Userdocid);

    FirebaseFirestore.instance.collection("AdminUser").doc(Userdocid).update({
      "permission":PermissionLis
    });

  }

  successpopuop(name) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(
              left: width / 3.268,
              right: width / 3.845,
              top: height / 4.106,
              bottom: height / 4.106),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffFFFFFF),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height / 16.425,
              ),
              SizedBox(
                height: height / 3.750,
                width: width / 11.383,
                child: Lottie.asset("assets/Succes animation.json"),
              ),
              SizedBox(
                height: height / 54.75,
              ),
              KText( text:name,style:SafeGoogleFont (
                    'Poppins',
                    fontWeight: FontWeight.w700,
                  )
              ),
              SizedBox(
                height: height / 82.1250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //cancel button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 18.464,
                      width: width / 11.383,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: KText(
                              text:"Cancel",
                              style:SafeGoogleFont (
                            'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          )
                          )),
                    ),
                  ),
                  SizedBox(
                    width: width / 34.15,
                  ),

                  //okay button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                    },
                    child: Container(
                      height: height / 18.464,
                      width: width / 11.383,
                      decoration: BoxDecoration(
                          color: Constants().primaryAppColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: KText(
                            text: "Okay",
                            style: SafeGoogleFont (
                              'Poppins',
                              fontSize: 19*ffem,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: width / 34.15,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }


  errorPopup(name) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(
              left: width / 3.268,
              right: width / 3.845,
              top: height / 4.106,
              bottom: height / 4.106),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffFFFFFF),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height / 16.425,
              ),
              SizedBox(
                height: height / 3.750,
                width: width / 11.383,
                child: Lottie.asset("assets/error (1).json",fit: BoxFit.cover),
              ),
              SizedBox(
                height: height / 54.75,
              ),
              KText( text:name,style:SafeGoogleFont (
                'Poppins',
                fontWeight: FontWeight.w700,
              )
              ),
              SizedBox(
                height: height / 42.1250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //cancel button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 18.464,
                      width: width / 11.383,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: KText(
                              text:"Cancel",
                              style:SafeGoogleFont (
                                  'Poppins',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              )
                          )),
                    ),
                  ),
                  SizedBox(
                    width: width / 34.15,
                  ),

                  //okay button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                    },
                    child: Container(
                      height: height / 18.464,
                      width: width / 11.383,
                      decoration: BoxDecoration(
                          color: Constants().primaryAppColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: KText(
                            text: "Okay",
                            style: SafeGoogleFont (
                                'Poppins',
                                fontSize: 19*ffem,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: width / 34.15,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  setthevalue(value) async {
    print("Entereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    setState(() {
      PermissionLis.clear();
       dashboard = false;
       userManagement = false;
       dashboard = false;
       alumnitracking = false;
       users = false;
       faculty = false;
       gallery = false;

       acidemicyear = false;
       department = false;
       classes = false;
       houses = false;
       userManagement = false;
       loginreports = false;

       messages = false;


        email= false;
        sms= false;
        notifications= false;
        blogs= false;
        audiopodcast= false;

        events= false;
        collageact= false;
        jobads= false;
        jobpost= false;
        socialmedia= false;

    });
    var document = await FirebaseFirestore.instance.collection("AdminUser").where("username",isEqualTo:value).get();
    for(int j=0;j<document.docs.length;j++){
      setState(() {
        Userdocid=document.docs[j].id;
      });
      print(Userdocid);
      print(PermissionLis);

      for(int j=0;j<document.docs.length;j++){
        setState(() {
          Uservalue=document.docs[j]['username'];
          Userdocid=document.docs[j].id;
        });
        for(int i=0;i<document.docs[j]['permission'].length;i++){
          if(document.docs[j]['permission'][i]=="dashboard"){
            setState(() {
              dashboard=true;
              PermissionLis.add("dashboard");
            });
          }
          if(document.docs[j]['permission'][i]=="user management"){
            setState(() {
              userManagement=true;
              PermissionLis.add("user management");
            });
          }
          if(document.docs[j]['permission'][i]=="Alumni Tracking"){
            setState(() {
              alumnitracking=true;
              PermissionLis.add("Alumni Tracking");
            });
          }
          if(document.docs[j]['permission'][i]=="users"){
            setState(() {
              users=true;
              PermissionLis.add("users");
            });
          }
          if(document.docs[j]['permission'][i]=="gallery"){
            setState(() {
              gallery=true;
              PermissionLis.add("gallery");
            });
          }
          if(document.docs[j]['permission'][i]=="events"){
            setState(() {
              events=true;
              PermissionLis.add("events");
            });
          }
          if(document.docs[j]['permission'][i]=="Faculty"){
            setState(() {
              faculty=true;
              PermissionLis.add("Faculty");
            });
          }
          if(document.docs[j]['permission'][i]=="messages"){
            setState(() {
              messages=true;
              PermissionLis.add("messages");
            });
          }
          if(document.docs[j]['permission'][i]=="academic year"){
            setState(() {
              acidemicyear=true;
              PermissionLis.add("academic year");
            });
          }
          if(document.docs[j]['permission'][i]=="department"){
            setState(() {
              department=true;
              PermissionLis.add("department");
            });
          }
          if(document.docs[j]['permission'][i]=="Classes"){
            setState(() {
              classes=true;
              PermissionLis.add("Classes");
            });
          }
          if(document.docs[j]['permission'][i]=="Houses"){
            setState(() {
              houses=true;
              PermissionLis.add("Houses");
            });
          }
          if(document.docs[j]['permission'][i]=="login reports"){
            setState(() {
              loginreports=true;
              PermissionLis.add("login reports");
            });
          }
          if(document.docs[j]['permission'][i]=="email"){
            setState(() {
              email=true;
              PermissionLis.add("email");
            });
          }

          if(document.docs[j]['permission'][i]=="SMS"){
            setState(() {
              sms=true;
              PermissionLis.add("SMS");
            });
          }

          if(document.docs[j]['permission'][i]=="notifications"){
            setState(() {
              notifications=true;
              PermissionLis.add("notifications");
            });
          }


          if(document.docs[j]['permission'][i]=="blogs"){
            setState(() {
              blogs=true;
              PermissionLis.add("blogs");
            });
          }
          if(document.docs[j]['permission'][i]=="audio podcasts"){
            setState(() {
              audiopodcast=true;
              PermissionLis.add("audio podcasts");
            });
          }
          if(document.docs[j]['permission'][i]=="collage activities"){
            setState(() {
              collageact=true;
              PermissionLis.add("collage activities");
            });
          }
          if(document.docs[j]['permission'][i]=="job advertisement"){
            setState(() {
              jobads=true;
              PermissionLis.add("job advertisement");
            });
          }
          if(document.docs[j]['permission'][i]=="job posts"){
            setState(() {
              jobpost=true;
              PermissionLis.add("job posts");
            });
          }
          if(document.docs[j]['permission'][i]=="social media"){
            setState(() {
              socialmedia=true;
              PermissionLis.add("social media");
            });
          }

        }
      }

    }
  }

  ///delete popup
  String deletefile="https://assets5.lottiefiles.com/packages/lf20_tqsLQJ3Q73.json";

  _deletepopup(docid,UserName){
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    showDialog(context: context, builder:(context) {
      return Padding(
        padding:  EdgeInsets.only(top: height/4.34,bottom: height/4.34,left: width/3.9028,right:width/3.9028),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25)
          ),
          child: Scaffold(
            backgroundColor: Color(0xffFFFFFF),
            body:
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   SizedBox(height:height/21.7),
                  KText( text:"Delete this Record",style:
                  SafeGoogleFont (
                    'Poppins',
                    fontSize: 21*ffem,
                    fontWeight: FontWeight.w700,
                  ),),
                  SizedBox(height: height/65.1,),
                  KText( text:" ${UserName}-Will be Deleted",style:
                  SafeGoogleFont (
                    'Poppins',
                    fontSize: 17*ffem,
                    fontWeight: FontWeight.w700,
                  ),),

                   SizedBox(height:height/52.55),

                  SizedBox(
                    height:height/3.6166,
                    width:width/7.5888,
                    child: Lottie.network(deletefile),
                  ),

                   SizedBox(height:height/32.55),

                  InkWell(
                    onTap: (){
                      deletedocument(docid);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height:height/16.275,
                      width:width/7.588,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:  Constants().primaryAppColor
                      ),
                      child: Center(
                        child: KText( text:"Okay",style:
                        SafeGoogleFont (
                          'Poppins',
                          fontSize: 19*ffem,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      );
    },);
  }

  ///delete document
  deletedocument(id){
    FirebaseFirestore.instance.collection("AdminUser").doc(id).delete();
    mangementpermision();
  }

  ///create document function
  documentcreatfunc() async {
    try{
      final User? user =
      (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userName.text,
          password: passWord.text,
      )).user;
    if (user != null) {
    setState(() {
      String _userEmail = user.uid;
    });
    FirebaseFirestore.instance.collection("AdminUser").doc().set({
      "Type":Authusertype,
      "password":passWord.text,
      "permission":[],
      "username":userName.text,
      "timestamp":DateTime.now().millisecondsSinceEpoch
    });
    setState(() {
      Authusertype="admin";
      passWord.clear();
      userName.clear();
    });
    mangementpermision();
    Navigator.pop(context);
    successpopuop("New User Add Successfully....");
    }
    else {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
    }
    }
    catch(e){
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
    }


  }

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Constants().primaryAppColor, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Constants().primaryAppColor),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Please fill required fields !!',
                  style: TextStyle(color: Colors.black)),
            ),
            const Spacer(),
            TextButton(
                onPressed: () => debugPrint("Undid"), child: const Text("Undo"))
          ],
        )),
  );
  adduserdialogBox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(
                  top: height / 6.51,
                  bottom: height / 6.51,
                  left: width / 3.9028,
                  right: width / 3.9028,
                ),
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height / 32.55,
                      horizontal: width / 68.3,
                    ),
                    child: SizedBox(
                      width: width / 2.732,
                      child: Center(
                        child: Column(
                          children: [
                            KText(
                              text: "Add New User",
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 19 * ffem,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      KText(
                                        text: "User Name",
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 19 * ffem,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        " *",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height / 41.143,),
                                  Container(
                                    width: width / 3.0,
                                    height: height / 14.42,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffDDDEEE),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r"[a-z0-9-@ ,.]+|\s")),
                                      ],
                                      controller: userName,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      style: GoogleFonts.poppins(
                                        fontSize: width / 106.6,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Type a User Name",
                                        contentPadding: EdgeInsets.only(
                                          left: width / 68.3,
                                          bottom: height / 82.125,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      validator: (validateEmail){
                                        if (userName.text.isEmpty)  {
                                          return "Field is Empty";
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height / 45.5),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      KText(
                                        text: "Password",
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 19 * ffem,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        " *",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height / 41.143,),
                                  Container(
                                    width: width / 3.0,
                                    height: height / 14.42,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffDDDEEE),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: TextFormField(
                                      controller: passWord,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      style: GoogleFonts.poppins(
                                        fontSize: width / 106.6,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Type a Password",
                                        contentPadding: EdgeInsets.only(
                                          left: width / 68.3,
                                          bottom: height / 82.125,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty && userName.text.isEmpty)  {
                                          return "Field is Empty";
                                        }

                                        if (value.isNotEmpty) {
                                          if (value.length < 6) {
                                            return "Please fill the Password";
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height / 45.5),
                            KText(
                              text: "( Hint : User Name Allows Only Email Address and Password is Minimum 6 Characters )",
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 19 * ffem,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: height / 45.5),
                           /* Row(
                              children: [
                                SizedBox(width: width / 18.0705),
                                KText(
                                  text: "Select the User Type",
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 19 * ffem,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 10.85,
                              width: width / 2.2766,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: width / 9.1066,
                                    child: RadioListTile(
                                      title: KText(
                                        text: "Admin",
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 19 * ffem,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      value: "admin",
                                      groupValue: Authusertype,
                                      onChanged: (value) {
                                        setState(() {
                                          Authusertype = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 8.5375,
                                    child: RadioListTile(
                                      title: KText(
                                        text: "Staff",
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 19 * ffem,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      value: "staff",
                                      groupValue: Authusertype,
                                      onChanged: (value) {
                                        setState(() {
                                          Authusertype = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 8.5375,
                                    child: RadioListTile(
                                      title: KText(
                                        text: "Others",
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 19 * ffem,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      value: "others",
                                      groupValue: Authusertype,
                                      onChanged: (value) {
                                        setState(() {
                                          Authusertype = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height / 40.5),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      Authusertype = "admin";
                                      passWord.clear();
                                      userName.clear();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: width / 11.3833,
                                    height: height / 17.1315,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: KText(
                                        text: "Cancel",
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 19 * ffem,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: width / 153.6),
                                InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate() &&
                                        passWord.text.length > 6) {
                                      documentcreatfunc();
                                    }else if(userName.text.isEmpty){

                                    }
                                  },
                                  child: Container(
                                    width: width / 11.3833,
                                    height: height / 17.1315,
                                    decoration: BoxDecoration(
                                      color: Constants().primaryAppColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: KText(
                                        text: "Submit",
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 19 * ffem,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: width / 153.6),
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
      },
    );
  }



}
