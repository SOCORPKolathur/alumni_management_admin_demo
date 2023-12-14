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

class UsersManagement extends StatefulWidget {
  String?Username;
   UsersManagement({this.Username});

  @override
  State<UsersManagement> createState() => _UsersManagementState();
}

class _UsersManagementState extends State<UsersManagement> {

  bool dashboard = false;
  bool userManagement = false;
  bool reports = false;
  bool users = false;
  bool gallery = false;
  bool  events= false;
  bool  news= false;
  bool  message= false;
  bool  setting= false;

  String Uservalue="Select";
  String Userdocid="";
  String Authusertype="admin";

  final  _formKey=GlobalKey<FormState>();

  List<String>PermissionLis = [];
  List<String>list = [];


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
        if(document.docs[j]['permission'][i]=="userManagement"){
          setState(() {
            userManagement=true;
            PermissionLis.add("userManagement");
          });
        }
        if(document.docs[j]['permission'][i]=="reports"){
          setState(() {
            reports=true;
            PermissionLis.add("reports");
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
        if(document.docs[j]['permission'][i]=="news"){
          setState(() {
            news=true;
            PermissionLis.add("news");
          });
        }
        if(document.docs[j]['permission'][i]=="message"){
          setState(() {
            message=true;
            PermissionLis.add("message");
          });
        }
        if(document.docs[j]['permission'][i]=="setting"){
          setState(() {
            setting=true;
            PermissionLis.add("setting");
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
        padding:  EdgeInsets.only(left:width/170.75,right: width/170.75),
        child: Container(
          height:height/1.0015,
          child: SingleChildScrollView(
            physics:const  ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: height/61.43),
                      child: KText(
                        text:"User Managements",
                      style:  SafeGoogleFont (
                          'Poppins',
                          fontSize: 25*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6*ffem/fem,
                          color: Color(0xff05004e),
                        ),
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
                              color: Color(0xff5D5FEF),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child:  Center(child:  KText( text:"Add User",style:
                          SafeGoogleFont (
                            'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          ),))
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
                              color: Color(0xff5D5FEF),
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
                                    value: userManagement,
                                    onChanged: (val) {
                                      setState(() {
                                        userManagement =
                                        !userManagement;
                                        if (userManagement == true) {
                                          PermissionLis.add("userManagement");
                                        }
                                        else{
                                          PermissionLis.remove("userManagement");
                                        }
                                      });
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
                                    value: reports,
                                    onChanged: (val) {
                                      setState(() {
                                        reports =
                                        !reports;
                                      });
                                      if (reports == true) {
                                        PermissionLis.add("reports");
                                      }
                                      else{
                                        PermissionLis.remove("reports");
                                      }
                                    }),
                                SizedBox(width: width/273.2,),
                                KText( text:"Reports",style:SafeGoogleFont (
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
                                    value: news,
                                    onChanged: (val) {
                                      setState(() {
                                        news =
                                        !news;
                                      });
                                      if (news == true) {
                                        PermissionLis.add("news");
                                      }
                                      else{
                                        PermissionLis.remove("news");
                                      }
                                    }),
                                SizedBox(width: width/273.2,),
                                KText( text:"News",style:SafeGoogleFont (
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
                                    value: setting,
                                    onChanged: (val) {
                                      setState(() {
                                        setting =
                                        !setting;
                                      });
                                      if (setting == true) {
                                        PermissionLis.add("setting");
                                      }
                                      else{
                                        PermissionLis.remove("setting");
                                      }
                                    }),
                                SizedBox(width: width/273.2,),
                                KText( text:"Setting",style:SafeGoogleFont (
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
                                    text: "Si.No",
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
                                                    _deletepopup(data.id);
                                                  },
                                                  child: Material(

                                                    borderRadius: BorderRadius.circular(100),
                                                    color: Colors.white,
                                                    child: Container(
                                                      height:height/21,
                                                      width:width/17.075,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(100),
                                                          color: Colors.white
                                                      ),
                                                      child: Center(child: Icon(Icons.delete)),
                                                    ),
                                                    elevation: 10,
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

              ],
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
                          color: Color(0xff5D5FEF),
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
       reports = false;
       users = false;
       gallery = false;
        events= false;
        news= false;
        message= false;
        setting= false;
    });
    var document = await FirebaseFirestore.instance.collection("AdminUser").where("username",isEqualTo:value).get();
    for(int j=0;j<document.docs.length;j++){
      setState(() {
        Userdocid=document.docs[j].id;
      });
      print(Userdocid);
      print(PermissionLis);
      for(int i=0;i<document.docs[j]['permission'].length;i++){
        if(document.docs[j]['permission'][i]=="dashboard"){
          setState(() {
            dashboard=true;
            PermissionLis.add("dashboard");
          });
        }
        if(document.docs[j]['permission'][i]=="userManagement"){
          setState(() {
            userManagement=true;
            PermissionLis.add("userManagement");
          });
        }
        if(document.docs[j]['permission'][i]=="reports"){
          setState(() {
            reports=true;
            PermissionLis.add("reports");
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
        if(document.docs[j]['permission'][i]=="news"){
          setState(() {
            news=true;
            PermissionLis.add("news");
          });
        }
        if(document.docs[j]['permission'][i]=="message"){
          setState(() {
            message=true;
            PermissionLis.add("message");
          });
        }
        if(document.docs[j]['permission'][i]=="setting"){
          setState(() {
            setting=true;
            PermissionLis.add("setting");
          });
        }
      }
    }
  }

  ///delete popup
  String deletefile="https://assets5.lottiefiles.com/packages/lf20_tqsLQJ3Q73.json";

  _deletepopup(docid){
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
                  KText( text:"Are You Sure Want to Delete",style:
                  SafeGoogleFont (
                    'Poppins',
                    fontSize: 19*ffem,
                    fontWeight: FontWeight.w700,
                  ),),

                   SizedBox(height:height/32.55),

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
                          color: const Color(0xff5D5FEF)
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
  documentcreatfunc(){
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


  adduserdialogBox(){
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context, builder:(context) {
        return
          StatefulBuilder(builder: (context, setState) {
            return Form(
              key: _formKey,
              child: Padding(
                padding:  EdgeInsets.only(top: height/6.51,bottom: height/6.51,left: width/3.9028,right:width/3.9028),
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(
                      vertical: height/32.55,
                        horizontal: width/68.3
                    ),
                    child: SizedBox(
                      width: width/2.732,
                      child: Center(
                        child: Column(
                          children: [
                            KText( text:"Add New User",style:
                            SafeGoogleFont (
                              'Poppins',
                              fontSize: 19*ffem,
                              fontWeight: FontWeight.w700,
                            ),),

                            SizedBox(
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  KText(
                                    text:"User Name",
                                    style:
                                    SafeGoogleFont (
                                      'Poppins',
                                      fontSize: 19*ffem,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: height/41.143,),

                                  Container(
                                    width: width / 3.0,
                                    height: height / 14.42,
                                    //color: Color(0xffDDDEEE),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffDDDEEE),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r"[a-z0-9-@ ,.]+|\s")),
                                        // FilteringTextInputFormatter.allow(RegExp("[a-z]")),
                                      ],
                                      controller: userName,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      style: GoogleFonts.poppins(
                                          fontSize: width / 106.6),
                                      decoration: InputDecoration(
                                        hintText: "Type a User Name",
                                        contentPadding: EdgeInsets.only(
                                            left: width / 68.3,
                                            bottom: height / 82.125),
                                        border: InputBorder.none,
                                      ),
                                      validator: (value) => value!.isEmpty?"Field is Empty":null,
                                    ),
                                  ),
                                ],
                              ),),
                            SizedBox(height:height/45.5),

                            SizedBox(
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  KText(
                                    text:"Password",
                                    style:
                                    SafeGoogleFont (
                                      'Poppins',
                                      fontSize: 19*ffem,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: height/41.143,),

                                  Container(
                                    width: width / 3.0,
                                    height: height / 14.42,
                                    //color: Color(0xffDDDEEE),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffDDDEEE),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: TextFormField(
                                        controller: passWord,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: GoogleFonts.poppins(
                                            fontSize: width / 106.6),
                                        decoration: InputDecoration(
                                          hintText: "Type a Password",
                                          contentPadding: EdgeInsets.only(
                                              left: width / 68.3,
                                              bottom: height / 82.125),
                                          border: InputBorder.none,
                                        ),
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return  "Field is Empty";
                                          }
                                          if(value!.isNotEmpty){
                                            if(value.length<6){
                                              return  "Please fill the Password";
                                            }
                                          }
                                        }

                                    ),
                                  ),
                                ],
                              ),),
                            SizedBox(height:height/45.5),
                            KText(
                              text:  "( Hint : User Name Allows Only Email Address and Password is Minimum 6 Characters )",
                              style:
                              SafeGoogleFont (
                                'Poppins',
                                fontSize: 19*ffem,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height:height/45.5),
                            Row(
                              children: [
                                SizedBox(width:width/18.0705),
                                KText( text:"Select the User Type",style:
                                SafeGoogleFont (
                                  'Poppins',
                                  fontSize: 19*ffem,
                                  fontWeight: FontWeight.w700,
                                ),),
                              ],
                            ),

                            SizedBox(
                              height:height/10.85,
                              width:width/2.2766,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:width/9.1066,
                                    child: RadioListTile(
                                      title:  KText( text:"Admin",style: SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 19*ffem,
                                        fontWeight: FontWeight.w700,
                                      ),),
                                      value: "admin",
                                      groupValue: Authusertype,
                                      onChanged: (value){
                                        setState(() {
                                          Authusertype = value.toString();
                                        });
                                      },
                                    ),
                                  ),

                                  SizedBox(
                                    width:width/8.5375,
                                    child: RadioListTile(
                                      title:  KText( text:"Staff", style:SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 19*ffem,
                                        fontWeight: FontWeight.w700,
                                      ),),
                                      value: "staff",
                                      groupValue: Authusertype,
                                      onChanged: (value){
                                        setState(() {
                                          Authusertype = value.toString();
                                        });
                                      },
                                    ),
                                  ),

                                  SizedBox(
                                    width:width/8.5375,
                                    child: RadioListTile(
                                      title:  KText( text:"Others",style: SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 19*ffem,
                                        fontWeight: FontWeight.w700,
                                      ),),
                                      value: "others",
                                      groupValue: Authusertype,
                                      onChanged: (value){
                                        setState(() {
                                          Authusertype = value.toString();
                                        });
                                      },
                                    ),
                                  ),


                                ],
                              ),
                            ),
                            SizedBox(height:height/40.5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      Authusertype="admin";
                                      passWord.clear();
                                      userName.clear();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      width: width/11.3833,
                                      height: height/17.1315,
                                      decoration: BoxDecoration(
                                          color: Color(0xffFFFFFF),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child:  Center(child:  KText( text:"Cancel",style:  SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 19*ffem,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black
                                      ),))
                                  ),
                                ),
                                SizedBox(width:width/153.6),

                                InkWell(
                                  onTap: (){
                                    if(_formKey.currentState!.validate()&&passWord.text.length>6){
                                      documentcreatfunc();
                                    }


                                  },
                                  child: Container(
                                      width: width/11.3833,
                                      height: height/17.1315,
                                      decoration: BoxDecoration(
                                          color: Color(0xff5D5FEF),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child:  Center(child:  KText( text:"Submit",style:  SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 19*ffem,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white
                                      ),))
                                  ),
                                ),
                                SizedBox(width:width/153.6),
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
          },);
      },);
  }

}
