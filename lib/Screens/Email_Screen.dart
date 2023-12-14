
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../Constant_.dart';
import '../Models/Language_Model.dart';
import '../Models/Response_Model.dart';
import '../utils.dart';
class Email_Screen extends StatefulWidget {
  const Email_Screen({super.key});

  @override
  State<Email_Screen> createState() => _Email_ScreenState();
}

class _Email_ScreenState extends State<Email_Screen> {
  TextfieldTagsController controller = TextfieldTagsController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  static List<String> _pickLanguage = <String>[];
  String currentTab = 'ADD';



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height/81.375, horizontal: width/170.75),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: height/81.375, horizontal: width/170.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KText(
                    text: "EMAIL COMMUNICATION",
                    style: SafeGoogleFont (
                        'Nunito',
                        fontSize: width/98.538,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                  SizedBox(width:width/1.80705),
                  InkWell(
                      onTap:(){
                        if(currentTab.toUpperCase() == "VIEW") {
                          setState(() {
                            currentTab = "Add";
                          });
                        }else{
                          setState(() {
                            currentTab = 'View';
                          });
                        }

                      },
                      child: Container(
                        height:height/18.6,
                        decoration: BoxDecoration(
                          color: Constants().primaryAppColor,
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1, 2),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal:width/227.66),
                          child: Center(
                            child: KText(
                              text: currentTab.toUpperCase() == "VIEW" ? "Send Email" : "View Emails",
                              style: SafeGoogleFont (
                                'Nunito',
                                fontSize:width/105.07,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
            currentTab.toUpperCase() == "ADD"
                ? Container(
              height: size.height * 0.84,
              width: width/1.38378,
              margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
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
                          horizontal: width/68.3, vertical: height/81.375),
                      child: Row(
                        children: [
                          Icon(Icons.message),
                          SizedBox(width: width/136.6),
                          KText(
                            text: "EMAIL",
                            style: SafeGoogleFont (
                              'Nunito',
                              fontSize: width/68.3,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      padding: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KText(
                                  text:
                                  "Single/Mulitiple Email (Seperate By Comma) *",
                                  style:SafeGoogleFont (
                                    'Nunito',
                                    color: Colors.black,
                                    fontSize: width/105.076,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height:height/73.9),
                                Container(
                                  decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Autocomplete<String>(
                                    optionsViewBuilder: (context, onSelected, options) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal:width/136.6, vertical: height/162.75),
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Material(
                                            elevation: 4.0,
                                            child: ConstrainedBox(
                                              constraints:  const BoxConstraints(maxHeight: 20),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: options.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  final dynamic option = options.elementAt(index);
                                                  return TextButton(
                                                    onPressed: () {
                                                      onSelected(option);
                                                    },
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: height/43.4),
                                                        child: Text(
                                                          '#$option',
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            color: Color.fromARGB(255, 74, 137, 92),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    optionsBuilder: (TextEditingValue textEditingValue) {
                                      if (textEditingValue.text == '') {
                                        return Iterable<String>.empty();
                                      }
                                      return _pickLanguage.where((String option) {
                                        return option.contains(textEditingValue.text.toLowerCase());
                                      });
                                    },
                                    onSelected: (String selectedTag) {
                                      controller.addTag = selectedTag;
                                    },
                                    fieldViewBuilder: (context, ttec, tfn, onFieldSubmitted) {
                                      return TextFieldTags(
                                        textEditingController: ttec,
                                        focusNode: tfn,
                                        textfieldTagsController: controller,
                                        initialTags: [],
                                        textSeparators: [' ', ','],
                                        letterCase: LetterCase.normal,
                                        validator: (String tag) {
                                          if (tag == 'php') {
                                            return 'No, please just no';
                                          } else if (controller.getTags!.contains(tag)) {
                                            return 'you already entered that';
                                          }
                                          return null;
                                        },
                                        inputfieldBuilder:
                                            (context, tec, fn, error, onChanged, onSubmitted) {
                                          return ((context, sc, tags, onTagDelete) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(horizontal:width/136.6),
                                              child: TextField(
                                                controller: tec,
                                                focusNode: fn,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,

                                                  helperStyle: TextStyle(
                                                    color: Constants().primaryAppColor,
                                                  ),
                                                  errorText: error,
                                                  prefixIconConstraints: BoxConstraints(
                                                      maxWidth: size.width * 0.74),
                                                  prefixIcon: tags.isNotEmpty
                                                      ? SingleChildScrollView(
                                                    controller: sc,
                                                    scrollDirection: Axis.horizontal,
                                                    child: Row(
                                                        children: tags.map((String tag) {
                                                          return Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(
                                                                Radius.circular(20.0),
                                                              ),
                                                              color: Constants().primaryAppColor,
                                                            ),
                                                            margin:
                                                            EdgeInsets.only(right: width/136.6),
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: width/136.6, vertical: height/162.75),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                InkWell(
                                                                  child: Text(
                                                                    tag,
                                                                    style: TextStyle(
                                                                        color: Colors.white),
                                                                  ),
                                                                ),
                                                                SizedBox(width: width/341.5),
                                                                InkWell(
                                                                  child: Icon(
                                                                      Icons.cancel,
                                                                      size:width/97.571,
                                                                      color: Colors.black
                                                                  ),
                                                                  onTap: () {
                                                                    onTagDelete(tag);
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        }).toList()),
                                                  )
                                                      : null,
                                                ),
                                                onChanged: onChanged,
                                                onSubmitted: onSubmitted,
                                              ),
                                            );
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height /21.7),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KText(
                                  text: "Subject *",
                                  style: SafeGoogleFont (
                                    'Nunito',
                                    color: Colors.black,
                                    fontSize: width/105.076,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height:height/73.9),
                                Container(
                                  decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none
                                    ),
                                    style: TextStyle(fontSize: width /113.83),
                                    controller: subjectController,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: height /21.7),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: "Description",
                                style: SafeGoogleFont (
                                  'Nunito',
                                  color: Colors.black,
                                  fontSize: width/105.076,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height:height/73.9),
                              Container(
                                height:size.height*0.15,
                                  width: double.infinity,
                                  decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: TextFormField(
                                    style:
                                    TextStyle(fontSize: width /113.83),
                                    controller: descriptionController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width/91.06,
                                            top: height/162.75,
                                            bottom: height/162.75)),
                                    maxLines: null,
                                  )),
                            ],
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top:height/10.9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    List<String>? tagss = await controller.getTags;
                                    if(tagss!.isNotEmpty) {
                                      Response response = await sendEmail(
                                          tagss, subjectController.text,
                                          descriptionController.text);
                                      if (response.code == 200) {
                                        CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.success,
                                            text: "Mail Sended successfully!",
                                            width: size.width * 0.4,
                                            backgroundColor: Constants()
                                                .primaryAppColor
                                                .withOpacity(0.8));
                                        setState(() {
                                          controller.clearTags();
                                          subjectController.text = "";
                                          descriptionController.text = "";
                                          currentTab = 'View';
                                        });
                                      } else {
                                        CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Failed to Send",
                                            width: size.width * 0.4,
                                            backgroundColor: Constants()
                                                .primaryAppColor
                                                .withOpacity(0.8));
                                        setState(() {
                                          controller.clearTags();
                                          subjectController.text = "";
                                          descriptionController.text = "";
                                        });
                                      }
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.send,
                                                color: Colors.white),
                                            SizedBox(width: width /273.2),
                                            KText(
                                              text: "SEND",
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                color: Colors.white,
                                                fontSize: width /136.6,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
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
            )
                : currentTab.toUpperCase() == "VIEW" ? SizedBox()
                : Container()
          ],
        ),
      ),
    );
  }

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Constants().primaryAppColor, width: 3),
          boxShadow: [
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
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Please fill required fields !!',
                  style: TextStyle(color: Colors.black)),
            ),
            Spacer(),
            TextButton(
                onPressed: () => debugPrint("Undid"), child: Text("Undo"))
          ],
        )),
  );

  Future<Response> sendEmail(receiverMail, String subject, String description) async {
    Response response = Response();
    DocumentReference documentReferencer = FirebaseFirestore.instance.collection('mail').doc();
    var json = {
      "to": receiverMail,
      "message": {
        "subject": subject,
        "text": description,
      },
    };
    var result = await documentReferencer.set(json).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }
}
