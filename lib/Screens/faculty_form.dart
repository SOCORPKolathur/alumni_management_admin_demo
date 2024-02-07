/*
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constant_.dart';
import '../Models/Language_Model.dart';
import '../utils.dart';

class FacultyForm extends StatefulWidget {
  const FacultyForm({Key? key}) : super(key: key);

  @override
  State<FacultyForm> createState() => _FacultyFormState();
}

class _FacultyFormState extends State<FacultyForm> {
  final _formkey = GlobalKey<FormState>();
  File? Url;
  var Uploaddocument;
  String imgUrl = "";
  String userUpdateDocumentID = "";
  TextEditingController firstNamecon = TextEditingController();
  TextEditingController middleNamecon = TextEditingController();
  TextEditingController lastNamecon = TextEditingController();
  TextEditingController Prefixcon = TextEditingController();
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
  TextEditingController subjectStremdcon = TextEditingController(text: "Select Department");
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
  TextEditingController FilterController = TextEditingController();

  ///Text Controller validator boolean Value
  bool firstNameValidator = false;
  bool lastNameValidator = false;
  bool dobValidator = false;
  bool yearPassedValidator = false;
  bool classValidator = false;
  bool myStatusValidator = false;
  bool pincodeValidator = false;
  bool prefixValidator = true;


  addImage(Size size) {
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
          imgUrl = "";
        });
      });
    });
  }

  imageupload() async {
    var snapshot = await FirebaseStorage.instance.ref().child('Images').child(
        "${Url!.name}").putBlob(Url);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imgUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return SingleChildScrollView(
      child: Column(
        children: [
          FadeInRight(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 1574 * fem,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 170.75,
                        vertical: height / 81.375,
                      ),
                      child: Form(
                        key: _formkey,
                        child: SizedBox(
                          width: 1550 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height / 26.04),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width / 307.2),
                                      KText(
                                        text: 'Add Faculty Details',
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width / 3.7463,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: height / 7.39,
                                              width: width / 15.36,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: const Color(0xffDDDEEE),
                                                image: Uploaddocument != null
                                                    ? DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: MemoryImage(
                                                    Uint8List.fromList(
                                                      base64Decode(
                                                        Uploaddocument!.split(',').last,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                    : DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(Constants().avator),
                                                ), // Fix the comma here
                                              ),
                                            ),
                                            SizedBox(width: width / 102.4),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: "Upload Student Photo (150px X 150px)",
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: 17 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.3625 * ffem / fem,
                                                    color: const Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height: height / 147.8),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        addImage(size); // Call the method here
                                                      },
                                                      child: Container(
                                                        height: height / 24.633,
                                                        width: width / 19.2,
                                                        decoration: BoxDecoration(
                                                          color: const Color(0xffDDDEEE),
                                                          border: Border.all(color: const Color(0xff000000)),
                                                        ),
                                                        child: Center(
                                                          child: KText(
                                                            text: "Choose File",
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: 17 * ffem,
                                                              fontWeight: FontWeight.w600,
                                                              height: 1.3625 * ffem / fem,
                                                              color: const Color(0xff000000),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: width / 307.2),
                                                    KText(
                                                      text: Uploaddocument == null ? "No file chosen" : "File is Selected",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize: 17 * ffem,
                                                        fontWeight: FontWeight.w600,
                                                        height: 1.3625 * ffem / fem,
                                                        color: const Color(0xff000000),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                      SizedBox(
                                        width: width / 2.2588,
                                        height: height / 2.75,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                SizedBox(
                                                  height: height / 9.369,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      KText(
                                                        text:
                                                        'Prefix *',
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
                                                          height: height /
                                                              123.1666),
                                                      Container(
                                                        height: height / 15.114,
                                                        width: width / 8.0842,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xffDDDEEE),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                3)),
                                                        child:
                                                        TextFormField(
                                                            autovalidateMode: AutovalidateMode
                                                                .onUserInteraction,
                                                            controller: Prefixcon,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .allow(
                                                                  RegExp(
                                                                      "[a-zA-Z ]")),
                                                            ],
                                                            maxLength: 25,
                                                            decoration: const InputDecoration(
                                                              border: InputBorder
                                                                  .none,
                                                              contentPadding: EdgeInsets
                                                                  .only(
                                                                  bottom:
                                                                  10,
                                                                  top:
                                                                  2,
                                                                  left:
                                                                  10),
                                                              counterText:
                                                              "",
                                                            ),
                                                            validator: (
                                                                value) =>
                                                            value!
                                                                .isEmpty
                                                                ? 'Field is required'
                                                                : null,

                                                            onChanged: (value) {
                                                              setState(() {
                                                                prefixValidator =
                                                                false;
                                                              });
                                                            }
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                





                                                SizedBox(
                                                  width: width / 2.2588,
                                                  height: height / 2.75,
                                                  child: Column(
                                                    children: [

                                                      ///first name and last name
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          SizedBox(
                                                            height: height / 9.369,
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
                                                                    height: height /
                                                                        123.1666),
                                                                Container(
                                                                  height: height / 15.114,
                                                                  width: width / 8.0842,
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          0xffDDDEEE),
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          3)),
                                                                  child:
                                                                  TextFormField(
                                                                      autovalidateMode: AutovalidateMode
                                                                          .onUserInteraction,
                                                                      controller: firstNamecon,
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter
                                                                            .allow(
                                                                            RegExp(
                                                                                "[a-zA-Z ]")),
                                                                      ],
                                                                      maxLength: 25,
                                                                      decoration: const InputDecoration(
                                                                        border: InputBorder
                                                                            .none,
                                                                        contentPadding: EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                            10,
                                                                            top:
                                                                            2,
                                                                            left:
                                                                            10),
                                                                        counterText:
                                                                        "",
                                                                      ),
                                                                      validator: (
                                                                          value) =>
                                                                      value!
                                                                          .isEmpty
                                                                          ? 'Field is required'
                                                                          : null,

                                                                      onChanged: (value) {
                                                                        setState(() {
                                                                          firstNameValidator =
                                                                          false;
                                                                        });
                                                                      }
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                    ],
                                  ),
                                ],
                              ),
                              // Add more widgets here if needed
                                      )],
                          ),
                       ] ),
                                      )]),
                   ] ),
                 ] ),
                    )
                      ))) ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
