import 'dart:convert';
import 'dart:html';
import 'package:alumni_management_admin/common_widgets/developer_card_widget.dart';
import 'package:alumni_management_admin/utils.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constant_.dart';
import '../Models/Language_Model.dart';



class SettingsTabs extends StatefulWidget {
  SettingsTabs({super.key});

  @override
  State<SettingsTabs> createState() => _SettingsTabsState();
}

class _SettingsTabsState extends State<SettingsTabs> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController altPhoneController = TextEditingController();
  TextEditingController buildingnoController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController adminEmailController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();
  TextEditingController managerEmailController = TextEditingController();
  TextEditingController managerPasswordController = TextEditingController();
  TextEditingController committeeEmailController = TextEditingController();
  TextEditingController committeePasswordController = TextEditingController();
  TextEditingController staffEmailController = TextEditingController();
  TextEditingController staffPasswordController = TextEditingController();
  TextEditingController memberIDPrefixController = TextEditingController();
  TextEditingController familyIDPrefixController = TextEditingController();

  TextEditingController verseController = TextEditingController();
  TextEditingController textController = TextEditingController();

  bool isAdminPasswordVisible = true;
  bool isManagerPasswordVisible = true;
  bool isCommitteePasswordVisible = true;
  bool isStaffPasswordVisible = true;

  String Logo = '';

  setData() async {
    var details1=await FirebaseFirestore.instance.collection("AlumniDetails").get();
    var details=await FirebaseFirestore.instance.collection("AlumniDetails").doc(details1.docs[0].id).get();
    Map<String,dynamic>?value=details.data();
    setState(() {
      Logo = value!['logo'];
      nameController.text = value['name'];
      phoneController.text = value['phone'];
      emailController.text = value['email'];
      altPhoneController.text =value['alterphoneNO'];
      buildingnoController.text = value['buildingNo'];
      streetController.text = value['street'];
      areaController.text = value['area'];
      cityController.text = value['city'];
      stateController.text = value['state'];
      pincodeController.text = value['pin code'];
      websiteController.text = value['wedsite'];
      memberIDPrefixController.text = value['memberID'];
      familyIDPrefixController.text = value['familyID'];
    });


  }


  File? Url;
  var Uploaddocument;
  addImage() {
    InputElement input = FileUploadInputElement() as InputElement
      ..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        setState(() {
          Url = file;
          Uploaddocument = reader.result;
          Logo = "";
        });
        imageupload();
      });
    });
  }
  // used this in Update page too
  imageupload() async {
    var snapshot = await FirebaseStorage.instance.ref().child('CollegeLogos').child(
        "${Url!.name}").putBlob(Url);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      Logo = downloadUrl;
    });
  }


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



  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    setData();
    // TODO: implement initState
    super.initState();
  }

  bool Colleagename=false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(

      backgroundColor: Constants().btnTextColor,
      appBar: AppBar(
        backgroundColor: Constants().primaryAppColor,
        title:KText(
                text: "SETTINGS",
                style: SafeGoogleFont (
                  'Nunito',
                  fontSize: width / 82.538,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff030229),
                ),),),
      body:  SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top:height/30.0769 ,left: width * 0.1),
          child: FadeInRight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //
                //     Padding(
                //       padding: EdgeInsets.symmetric(
                //           horizontal: width / 170.75, vertical: height / 81.375),
                //       child: KText(
                //         text: "SETTINGS",
                //         style: SafeGoogleFont (
                //           'Nunito',
                //           fontSize: width / 82.538,
                //           fontWeight: FontWeight.w700,
                //           color: Color(0xff030229),
                //         ),
                //       ),
                //     ),
                //
                //   ],
                // ),
                SizedBox(height: size.height * 0.03),
                Container(
                  height: size.height * 0.98 ,
                  width: size.width * 0.81,
                  // decoration: BoxDecoration(
                  //   color:Colors.white,
                  //   boxShadow: const [
                  //     BoxShadow(
                  //       color: Colors.black26,
                  //       offset: Offset(1, 2),
                  //       blurRadius: 3,
                  //     ),
                  //   ],
                  //   // borderRadius: BorderRadius.circular(10),
                  // ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                )),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.15,
                                  child: Column(
                                    children: [
                                      SizedBox(height: size.height * 0.1),
                                      Uploaddocument==null? Logo != ""
                                          ? Image.network(
                                        Logo,
                                        height: height/10.26388,
                                        width: width/21.3333,
                                      )
                                          :  Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.black,
                                        size: width/29.538,
                                      ) : Image.memory(
                                          height: height/10.26388,
                                          width: width/21.3333,
                                          Uint8List.fromList(
                                        base64Decode(
                                          Uploaddocument!.split(',').last,
                                        ),)),

                                      SizedBox(height: height/73.9),
                                      InkWell(
                                        onTap: (){
                                          addImage();
                                        },
                                        child: Container(
                                          height: height / 18.6,
                                          width: size.width * 0.1,
                                          decoration: BoxDecoration(
                                            color: Constants().primaryAppColor,
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.add_a_photo, color: Colors.white),
                                              SizedBox(width: width / 136.6),
                                              KText(
                                                text: 'Change Logo',
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xffFFFFFF),
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
                                  width: size.width * 0.65,
                                  padding: EdgeInsets.symmetric(
                                      vertical: height/32.55,
                                      horizontal: width/68.3
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "College Name",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp("[a-z,A-Z ]")),
                                                  ],
                                                  controller:
                                                  nameController,
                                                  decoration:
                                                  InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(top:height/108.5,bottom: height/108.5),
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if(value!.isEmpty){
                                                      return "Field is Required";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: width/27.32),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "College Phone Number",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                                  ],
                                                  controller:
                                                  phoneController,
                                                  decoration:
                                                  InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(top:height/108.5,bottom: height/108.5),
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if(value!.isNotEmpty){
                                                      if(value.length!=10){
                                                        return "Please Fill Phone Number Correctly";
                                                      }
                                                    }
                                                    if(value!.isEmpty){
                                                      return "Field is Required";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: width/27.32),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "College Email",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  emailController,
                                                  decoration:
                                                  InputDecoration(
                                                    contentPadding: EdgeInsets.only(top:height/108.5,bottom: height/108.5),
                                                    border: InputBorder.none,
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),
                                                  ),
                                                  validator: validateEmail,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height/21.7),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "Building No",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  buildingnoController,
                                                  decoration:
                                                  InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(top:height/108.5,bottom: height/108.5),
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if(value!.isEmpty){
                                                      return "Field is Required";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: width/27.32),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "Street Name",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  streetController,
                                                  onTap: () {},
                                                  decoration:
                                                  InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(top:height/108.5,bottom: height/108.5),
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if(value!.isEmpty){
                                                      return "Field is Required";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: width/27.32),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "Area",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  areaController,
                                                  onTap: () {},
                                                  decoration:
                                                  InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(top:height/108.5,bottom: height/108.5),
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if(value!.isEmpty){
                                                      return "Field is Required";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height/21.7),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "City / District",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  cityController,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp("[a-z,A-Z ]")),
                                                  ],
                                                  decoration:
                                                  InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(top:height/108.5,bottom: height/108.5),
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if(value!.isEmpty){
                                                      return "Field is Required";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: width/27.32),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "State",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  stateController,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp("[a-z,A-Z ]")),
                                                  ],
                                                  decoration:
                                                  InputDecoration(
                                                    contentPadding: EdgeInsets.only(top:height/108.5,bottom: height/108.5),
                                                    border: InputBorder.none,
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if(value!.isEmpty){
                                                      return "Field is Required";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: width/27.32),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "Pin code",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                                  ],
                                                  controller:
                                                  pincodeController,
                                                  onTap: () {},
                                                  decoration:
                                                  InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(top:height/108.5,bottom: height/108.5),
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if(value!.isEmpty){
                                                      return "Field is Required";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),


                                        ],
                                      ),
                                      SizedBox(height: height/21.7),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "Website",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  websiteController,
                                                  onTap: () {},
                                                  decoration:
                                                  InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(top:height/108.5,bottom: height/108.5),
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: width/27.32),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "Alternate Phone",
                                                style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000)
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                                  ],
                                                  validator: (value) {
                                                    if(value!.isNotEmpty){
                                                      if(value.length!=10){
                                                        return "Please Fill Phone Number Correctly";
                                                      }
                                                    }
                                                    if(value!.isEmpty){
                                                      return "Field is Required";
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                  altPhoneController,
                                                  maxLength: 10,
                                                  onTap: () {},
                                                  decoration:
                                                  InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(top:height/108.5,bottom: height/108.5),
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),

                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: width/27.32),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "UserID",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height: height/108.5),
                                              Container(
                                                height: height/14.1,
                                                width: width/5.553,
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)),
                                                padding: EdgeInsets.only(left:width/307.2,right:width/307.2),
                                                child: TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller:
                                                  memberIDPrefixController,
                                                  onTap: () {},
                                                  decoration:
                                                  InputDecoration(
                                                    border: InputBorder.none,
                                                    hintStyle:
                                                    GoogleFonts
                                                        .openSans(
                                                      fontSize: width/97.571,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),


                                        ],
                                      ),
                                      SizedBox(height: height/11.7),

                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [

                                          GestureDetector(
                                            onTap:(){
                                              if(_formkey.currentState!.validate()){
                                                Updatedatafunc();
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
                                                    text: 'Update',
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
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
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

  Updatedatafunc() async {
    Size size = MediaQuery.of(context).size;


    var details1=await FirebaseFirestore.instance.collection("AlumniDetails").get();
    FirebaseFirestore.instance.collection("AlumniDetails").doc(details1.docs[0].id).update({
      'logo':Logo,
      'name':  nameController.text,
      'phone':phoneController.text,
      'email':emailController.text,
      'alterphoneNO':altPhoneController.text,
      'buildingNo': buildingnoController.text,
      'street':streetController.text,
      'area': areaController.text,
      'city':cityController.text,
      'state':stateController.text,
      'pin code':pincodeController.text,
      'wedsite': websiteController.text,
      'memberID':memberIDPrefixController.text,
      'familyID':familyIDPrefixController.text,
    });



    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Updated successfully!",
        width: size.width * 0.4,
        backgroundColor: Constants().primaryAppColor.withOpacity(0.8));


  }



}

