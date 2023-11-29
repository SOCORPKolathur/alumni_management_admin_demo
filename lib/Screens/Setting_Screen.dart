import 'dart:html';
import 'package:alumni_management_admin/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
    var details=await FirebaseFirestore.instance.collection("AlumniDetails").doc(Constants().docid.toString()).get();
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

  File? profileImage;
  var uploadedImage;
  String? selectedImg;

  selectImage() async {
    InputElement input = FileUploadInputElement() as InputElement
      ..accept = 'image/*';
    input.click();
    input.onChange.listen((event) async {
      final file = input.files!.first;
      FileReader reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          profileImage = file;
        });
        setState(() {
          uploadedImage = reader.result;
          selectedImg = null;
        });
        setState(() {

        });
      });
    });

    print("Selcetd Image");
    String downloadUrl =  await uploadImageToStorage(profileImage);

    print(downloadUrl);
    var doc = await FirebaseFirestore.instance.collection('AlumniDetails').get();

    FirebaseFirestore.instance.collection('AlumniDetails').doc(doc.docs.first.id).update({
      "logo" : downloadUrl,
    });

  }

  @override
  void initState() {
    setData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 170.75, vertical: height / 81.375),
                child: KText(
                  text: "SETTINGS",
                  style: SafeGoogleFont (
                    'Nunito',
                    fontSize: 28*ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.3625*ffem/fem,
                    color: Color(0xff000000),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            height: size.height * 0.98 ,
            width: size.width * 0.81,
            decoration: BoxDecoration(
              color: Constants().primaryAppColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1, 2),
                  blurRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(height: size.height * 0.09),
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
                              Logo != ""
                                  ? Image.network(
                                Logo,
                                height: 72,
                                width: 72,
                              )
                                  : const Icon(
                                Icons.church,
                                color: Colors.white,
                                size: 52,
                              ),
                              // Icon(
                              //   Icons.church,
                              //   size: width/7.588,
                              // ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: selectImage,
                                child: Container(
                                  height: height / 18.6,
                                  width: size.width * 0.1,
                                  decoration: BoxDecoration(
                                    color: Constants().primaryAppColor,
                                    borderRadius: BorderRadius.circular(10),
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
                                          color: Color(0xff000000),
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
                                        text: "Alumni Name",
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      SizedBox(height: height/108.5),
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          nameController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                        text: "Alumni Phone Number",
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      SizedBox(height: height/108.5),
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          phoneController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                        text: "Alumni Email",
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      SizedBox(height: height/108.5),
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          emailController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          buildingnoController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          streetController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          areaController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          cityController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          stateController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                        text: "Pincode",
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      SizedBox(height: height/108.5),
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          pincodeController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          websiteController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      SizedBox(height: height/108.5),
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          altPhoneController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                        text: "MemberID prefix",
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      SizedBox(height: height/108.5),
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          memberIDPrefixController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                              SizedBox(height: height/21.7),
                              Row(

                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: "FamilyID Prefix",
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      SizedBox(height: height/108.5),
                                      SizedBox(
                                        height: height/16.275,
                                        width: width/5.553,
                                        child: TextFormField(
                                          controller:
                                          familyIDPrefixController,
                                          onTap: () {},
                                          decoration:
                                          InputDecoration(
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
                                  InkWell(
                                    onTap:(){

                                      Updatedatafunc();

                                    },
                                    child: Container(
                                      height:height/18.6,
                                      decoration: BoxDecoration(
                                        color: Constants()
                                            .primaryAppColor,
                                        borderRadius:
                                        BorderRadius.circular(
                                            8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(1, 2),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding:
                                        EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: Center(
                                          child: KText(
                                            text: "Update",
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 20*ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xff000000),
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.03),
        ],
      ),
    );
  }

  Updatedatafunc(){
    Size size = MediaQuery.of(context).size;
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Updated successfully!",
        width: size.width * 0.4,
        backgroundColor: Constants().primaryAppColor.withOpacity(0.8));
    FirebaseFirestore.instance.collection("AlumniDetails").doc(Constants().docid.toString()).update({
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






  }


  static Future<String> uploadImageToStorage(file) async {
    print("File Selected");
    var snapshot = await FirebaseStorage.instance.ref().child('dailyupdates').child("${file.name}").putBlob(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

