
import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'package:alumni_management_admin/Screens/faculty.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../StateModel.dart' as StatusModel;
import '../Constant_.dart';
import '../Models/Language_Model.dart';
import '../utils.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  final Function(bool) updateDisplay;
  final bool displayFirstWidget;
  UserForm({required this.displayFirstWidget,required this.updateDisplay});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formkey = GlobalKey<FormState>();
  final RegExp _inputPattern = RegExp(r'^\d{4}\s\d{4}\s\d{4}$');
   List<String> OnCampus = ['On Campus', 'Yes', 'No'];
   List<String> OFFCampus = [ 'Select Option','OFF Campus', 'On Campus', "NO"];
   List<String> prefixlist = [ 'Select','Mr.', "Ms.",'Mrs.'];






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
  bool isEmail(String input) => EmailValidator.validate(input);
  File? Url;
  var Uploaddocument;
  String imgUrl = "";
  String userUpdateDocumentID = "";


  DateTime _selectedYear = DateTime.now();
  String showYear = 'Select Year';
  GlobalKey filterDataKey = GlobalKey();

  List<String> departmentDataList = [];
  List<String> YearDataList = [];
  List<String> FilterDataList = [];

  TextEditingController prefixcon = TextEditingController(text: "Select");
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
  TextEditingController companycon = TextEditingController();
  TextEditingController Shiftcon = TextEditingController();
  TextEditingController appointmentcon = TextEditingController();
  TextEditingController organizationcon = TextEditingController();
  TextEditingController industrycon = TextEditingController();
  TextEditingController fieldcon = TextEditingController();
  TextEditingController packagecon = TextEditingController();
  TextEditingController RegisterNumbercon = TextEditingController();
  TextEditingController  DissertationTopiccon = TextEditingController();
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
  TextEditingController competitveexampassedcon = TextEditingController();
  TextEditingController currentacademiccon = TextEditingController();
  TextEditingController otherdegreecon = TextEditingController();
  TextEditingController educationquvalificationcon = TextEditingController();
  TextEditingController additionalquvalificationcon = TextEditingController();
  TextEditingController occupationcon = TextEditingController();
  TextEditingController designationcon = TextEditingController();
  TextEditingController company_concerncon = TextEditingController();
  TextEditingController maritalStatuscon = TextEditingController(text: "Select Option");
  TextEditingController spouseNamecon = TextEditingController();
  TextEditingController anniversaryDatecon = TextEditingController();
  TextEditingController no_of_childreancon = TextEditingController();
  TextEditingController ownBussinesscon = TextEditingController();
  TextEditingController alumniEmployedController = TextEditingController(text: "No");
  TextEditingController alumniEmploymentController = TextEditingController(text: "On Campus");
  TextEditingController alumniEmploymentsController = TextEditingController(text: "Select Option");
  TextEditingController FilterController = TextEditingController();


  TextEditingController shift = TextEditingController();
  TextEditingController clregno  = TextEditingController();
  TextEditingController thesistopic = TextEditingController();
  TextEditingController exampassed = TextEditingController();
  TextEditingController currentstatus = TextEditingController();
  TextEditingController otherDegree = TextEditingController();
  TextEditingController placedcompany = TextEditingController();
  TextEditingController industry = TextEditingController();
  TextEditingController package = TextEditingController();

  bool Useradd = false;

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
  int billcount = 0;
  userCounta() async {
    var user = await FirebaseFirestore.instance.collection("Users").get();
    setState(() {
      billcount = user.docs.length + 1;
    });
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
  }


 userdatecreatefunc() async {

    String userid = generateRandomString(16);

    if (Uploaddocument != null) {
      var snapshot = await FirebaseStorage.instance.ref().child('Images').child(
          "${Url!.name}").putBlob(Url);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imgUrl = downloadUrl;
      });
      print("Img Url Validate_+++++++++++++++++++++++++++++++++++++++++++++");
      await FirebaseFirestore.instance.collection("Users").doc(userid).set({

        "prefix": prefixcon.text,
        "UserImg": imgUrl,
        "Name": firstNamecon.text,
        "middleName": middleNamecon.text,
        "lastName": lastNamecon.text,
        "dob": dateofBirthcon.text,
        "Gender": gendercon.text,
        "aadhaarNo": aadhaarNumbercon.text,

        //Contact


        "Phone": phoneNumbercon.text,
        "mobileNo": mobileNumbercon.text,
        "email": emailIDcon.text,
        "alteremail": alterEmailIdcon.text, "city": citycon.text,
        "pinCode": pinCodecon.text,
        "state": statecon.text,
        "country": countrycon.text,
        "Address": adreesscon.text,

        //user details

        "yearofpassed": yearPassedcon.text,
        "subjectStream": subjectStremdcon.text,//dep
        "class": classcon.text,
        "rollNo": rollnocon.text,
        "house": housecon.text,
        "lastvisit": lastvisitcon.text,
        "statusmessage": statusmessagecon.text,
        "shift":"",
        "clregno":"",
        "thesistopic":"",
        "exampassed":"",
        "currentstatus":"",
        "other Degree":"",


        //User Qua

        "educationquvalification": educationquvalificationcon.text,
        "additionalquvalification": additionalquvalificationcon.text,



        //professional

        "Occupation": occupationcon.text,
        "designation": designationcon.text,
        "company_concern": company_concerncon.text,


        //Carrier Details

        "placetype":"",
        "placedcompany":"",
        "industry":"",
        "package":"",



        //Material Status
        "maritalStatus": maritalStatuscon.text,
        "spouseName": spouseNamecon.text,
        "anniversaryDate": anniversaryDatecon.text,
        "childreancount": no_of_childreancon.text,


        //For Datebase

        "lastchat": "",
        "verifyed": false,
        "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "userDocId": userid,
        "Active": false,
        "Editted":false,
        "Token": "",
        "longtitude": 0,
        "latitude": 0,
        "regno": "Al${(billcount).toString().padLeft(2, "0")}",

      });
      setState(() {
        Useradd = false;
      });
    }

    else {
      print("Else Fucntion_+++++++++++++++++++++++++++++++++++++++++++++");
      await FirebaseFirestore.instance.collection("Users").doc(userid).set({

        "prefix": prefixcon.text,
        "UserImg": imgUrl,
        "Name": firstNamecon.text,
        "middleName": middleNamecon.text,
        "lastName": lastNamecon.text,
        "dob": dateofBirthcon.text,
        "Gender": gendercon.text,
        "aadhaarNo": aadhaarNumbercon.text,

        //Contact


        "Phone": phoneNumbercon.text,
        "mobileNo": mobileNumbercon.text,
        "email": emailIDcon.text,
        "alteremail": alterEmailIdcon.text, "city": citycon.text,
        "pinCode": pinCodecon.text,
        "state": statecon.text,
        "country": countrycon.text,
        "Address": adreesscon.text,

        //user details

        "yearofpassed": yearPassedcon.text,
        "subjectStream": subjectStremdcon.text,//dep
        "class": classcon.text,
        "rollNo": rollnocon.text,
        "house": housecon.text,
        "lastvisit": lastvisitcon.text,
        "statusmessage": statusmessagecon.text,
        "shift":"",
        "clregno":"",
        "thesistopic":"",
        "exampassed":"",
        "currentstatus":"",
        "other Degree":"",


        //User Qua

        "educationquvalification": educationquvalificationcon.text,
        "additionalquvalification": additionalquvalificationcon.text,



        //professional

        "Occupation": occupationcon.text,
        "designation": designationcon.text,
        "company_concern": company_concerncon.text,


        //Carrier Details

        "placetype":"",
        "placedcompany":"",
        "industry":"",
        "package":"",



        //Material Status
        "maritalStatus": maritalStatuscon.text,
        "spouseName": spouseNamecon.text,
        "anniversaryDate": anniversaryDatecon.text,
        "childreancount": no_of_childreancon.text,


        //For Datebase

        "lastchat": "",
        "verifyed": false,
        "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "userDocId": userid,
        "Active": false,
        "Editted":false,
        "Token": "",
        "longtitude": 0,
        "latitude": 0,
        "regno": "Al${(billcount).toString().padLeft(2, "0")}",

      });
      setState(() {
        Useradd = false;
      });
    }
    userCreateSuccessPopup();

    widget.updateDisplay(!widget.displayFirstWidget);
    setState(() {
      Useradd = true; // Set Useradd to true to indicate that a user has been added
    });
  }


  userCreateSuccessPopup() {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    showDialog(
      barrierColor: Colors.transparent,
      context: context, builder: (context) {
      return ZoomIn(
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 160.0, bottom: 160, left: 400, right: 400),
          child: Material(
            color: Colors.white,
            shadowColor: const Color(0xff245BCA),
            borderRadius: BorderRadius.circular(8),
            elevation: 10,
            child: Container(

              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Scaffold(
                backgroundColor: const Color(0xffFFFFFF),
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height / 24.6333),
                      KText(text: " Alumni Added SuccessFully....",
                          style: SafeGoogleFont(
                              'Nunito',
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 18

                          )),

                      SizedBox(height: height / 36.95),

                      SizedBox(
                        height: height / 4.10555,
                        width: width / 8.53333,
                        child: SvgPicture.asset(Constants().userSuccessSvg),
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
                              width: width / 8.53333,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: KText(text: "Cancel", style:
                                SafeGoogleFont(
                                    'Nunito',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 16

                                )),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: height / 18.475,
                              width: width / 8.53333,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color:  Constants().primaryAppColor
                              ),
                              child: Center(
                                child: KText(text: "Okay",
                                  style:
                                  SafeGoogleFont(
                                      'Nunito',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16

                                  ),),
                              ),
                            ),
                          ),
                        ],
                      )

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


  bool Loading = false;
  ///dropdown validator values
  bool dropdownValidator = false;
  bool dropdownValidator2 = false;
  bool dropdownValidator3 = false;
  bool dropdownDepartmentValidator = false;
  bool genderValidator = false;


  ///clear controller functions--------------------------------

  controllersclearfunc() {
    setState(() {
      Loading = false; // Assuming Loading is a boolean variable
      firstNamecon.clear();
      middleNamecon.clear();
      // Clear other controllers here...
      housecon.clear();
      statusmessagecon.clear();
      // Clear other controllers here...
      maritalStatuscon.text = "Marital Status"; // Assuming maritalStatuscon is a TextEditingController
      alumniEmployedController.text = "No"; // Assuming alumniEmployedController is a TextEditingController
      // Clear other controllers here...
    });
  }


  ///Text Controller validator boolean Value
  bool firstNameValidator = false;
  bool lastNameValidator = false;
  bool dobValidator = false;
  bool competitiveexamValidator=false;
  bool yearPassedValidator = false;
  bool shiftValidator= false;
  bool classValidator = false;
  bool myStatusValidator = false;
  bool pincodeValidator = false;
  bool prefixValidator = true;
  int BatchYearValid = 0;

  late DateTime lastVisitDate;

  void LastVisitselectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != lastVisitDate) {
      setState(() {
        lastVisitDate = picked;
        lastvisitcon.text = DateFormat('yyyy-MM-dd').format(lastVisitDate);
      });
    }
  }
  ///Department Fetch Function
  departmentdataFetchFunc() async {
    print("Department Data List+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    setState(() {
      departmentDataList.clear();
      YearDataList.clear();
    });
    setState(() {
      departmentDataList.add('Select Department');
      YearDataList.add('Select Year');
    });
    var departmentdata = await FirebaseFirestore.instance.collection("Department").orderBy("name").get();
    for (int x = 0; x < departmentdata.docs.length; x++) {
      setState(() {
        departmentDataList.add(departmentdata.docs[x]['name'].toString());
      });
    }
    var acdamicYeardata = await FirebaseFirestore.instance.collection("AcademicYear").orderBy("name").get();
    for (int x = 0; x < acdamicYeardata.docs.length; x++) {
      setState(() {
        YearDataList.add(acdamicYeardata.docs[x]['name'].toString());
      });
    }
    print("department Data List $departmentDataList");
    print("Year Data List $YearDataList");
  }

  ///select the city functions---------
  List<String> _cities = ["Select City"];

  Future getResponse() async {
    var res = await rootBundle.loadString(
        'packages/country_state_city_picker/lib/assets/country.json');
    return jsonDecode(res);
  }

  Future getCity(state) async {
    setState(() {
      _cities.clear();
    });
    setState(() {
      _cities.add("Select City");
    });
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == "🇮🇳    India")
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == state);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {
            _cities.add(citynames.toString());
          }
        });
      });
    });
    print("Get cityssss");
    print(_cities);
    return _cities;
  }

  void userNotValidAgePopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Invalid Age"),
          content: Text("You must be at least 17 years old to proceed."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  late DateTime _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
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
  // Popupmenu(BuildContext context, _userid, key) async {
  //   print(
  //       "Popupmenu open-----------------------------------------------------------");
  //   double width = MediaQuery
  //       .of(context)
  //       .size
  //       .width;
  //   double height = MediaQuery
  //       .of(context)
  //       .size
  //       .height;
  //   final render = key.currentContext!.findRenderObject() as RenderBox;
  //   await showMenu(
  //     color: const Color(0xffFFFFFF),
  //     elevation: 0,
  //     context: context,
  //     position: RelativeRect.fromLTRB(
  //         render
  //             .localToGlobal(Offset.zero)
  //             .dx,
  //         render
  //             .localToGlobal(Offset.zero)
  //             .dy + 50,
  //         double.infinity,
  //         double.infinity),
  // items: usereditlist
  //     .map((item) =>
  //     PopupMenuItem<String>(
  //       enabled: true,
  //       onTap: () async {
  //         setState(() {
  //           userUpdateDocumentID = _userid;
  //         });
  //         if (item == "Edit") {
  //           setState(() {
  //             UserEdit = !UserEdit;
  //           });
  //           fetchdate(_userid);
  //         } else if (item == "Delete") {
  //           userDetelePopup();
  //         }else if (item == "View") {
  //           viewPopup(userUpdateDocumentID);
  //         }
  //       },
  //         value: item,
  //         child: Container(
  //           height: height / 18.475,
  //           decoration: BoxDecoration(
  //               color: item == "Edit"
  //                   ? const Color(0xff5B93FF).withOpacity(0.6): item == "View"
  //                   ? Colors.green.withOpacity(0.6)
  //                   : const Color(0xffE71D36).withOpacity(0.6),
  //               borderRadius: BorderRadius.circular(5)),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               item == "Edit"
  //                   ? const Icon(
  //                 Icons.edit,
  //                 color: Colors.white,
  //                 size: 18,
  //               ): item == "View"
  //                   ? Icon(
  //                 Icons.remove_red_eye_outlined,
  //                 color: Colors.white,
  //                 size: 18,
  //               )
  //                   : const Icon(
  //                 Icons.delete,
  //                 color: Colors.white,
  //                 size: 18,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 5),
  //                 child: Text(
  //                   item,
  //                   style: const TextStyle(
  //                     fontSize: 13,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ))
  //       .toList(),
  // );
  // }
  // viewPopup(String userUpdateDocumentID) async {
  //   Size size = MediaQuery.of(context).size;
  //   double height = size.height;
  //   double width = size.width;
  //
  //   DocumentSnapshot<Map<String, dynamic>> userSnapshot =
  //   await FirebaseFirestore.instance.collection("Users").doc(userUpdateDocumentID).get();
  //
  //   Map<String, dynamic>? userData = userSnapshot.data();
  //
  //   return showDialog(
  //     context: context,
  //     builder: (ctx) {
  //       if (userData == null) {
  //         // Handle the case where user data is not found
  //         return AlertDialog(
  //           // Your error handling UI or message can go here
  //           // ...
  //         );
  //       }
  //
  //       return AlertDialog(
  //         backgroundColor: Colors.transparent,
  //         content: Container(
  //           width: size.width * 0.5,
  //           margin: EdgeInsets.symmetric(horizontal: width / 68.3, vertical: height / 32.55),
  //           decoration: BoxDecoration(
  //             color: Constants().primaryAppColor,
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.black26,
  //                 offset: Offset(1, 2),
  //                 blurRadius: 3,
  //               ),
  //             ],
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: size.height * 0.1,
  //                 width: double.infinity,
  //                 child: Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: width / 68.3, vertical: height / 81.375),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         "User details",
  //                         style: SafeGoogleFont('Poppins',
  //                             fontSize: width / 78.3,
  //                             fontWeight: FontWeight.w700,
  //                             color: Colors.white),
  //                       ),
  //                       InkWell(
  //                         onTap: () {
  //                           Navigator.pop(context);
  //                         },
  //                         child: Container(
  //                           height: height / 16.275,
  //                           decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(8),
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.black26,
  //                                 offset: Offset(1, 2),
  //                                 blurRadius: 3,
  //                               ),
  //                             ],
  //                           ),
  //                           child: Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: width / 227.66),
  //                             child: Center(
  //                               child: KText(
  //                                 text: "CLOSE",
  //                                 style: SafeGoogleFont(
  //                                   'Poppins',
  //                                   fontSize: width / 105.375,
  //                                   fontWeight: FontWeight.w700,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Container(
  //                   width: double.infinity,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.only(
  //                       bottomRight: Radius.circular(10),
  //                       bottomLeft: Radius.circular(10),
  //                     ),
  //                   ),
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           width: size.width * 0.5,
  //                           height: size.height * 0.5,
  //                           decoration: BoxDecoration(
  //                             image: DecorationImage(
  //                               filterQuality: FilterQuality.high,
  //                               fit: BoxFit.fill,
  //                               image: NetworkImage(userData['UserImg']),
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: double.infinity,
  //                           child: Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: width / 136.6, vertical: height / 65.1),
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                               children: [
  //                                 SizedBox(height: height / 32.55),
  //                                 Row(
  //                                   children: [
  //                                     SizedBox(
  //                                       width: size.width * 0.15,
  //                                       child: KText(
  //                                         text: "Name",
  //                                         style: SafeGoogleFont('Poppins',
  //                                             fontWeight: FontWeight.w600, fontSize: width / 95.375),
  //                                       ),
  //                                     ),
  //                                     Text(":"),
  //                                     SizedBox(width: width / 68.3),
  //                                     KText(
  //                                       text: userData['Name'],
  //                                       style: SafeGoogleFont('Poppins', fontSize: width / 105.571),
  //                                     )
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: height / 32.55),
  //                                 // Continue displaying other user details in a similar manner
  //                                 // ...
  //
  //                                 SizedBox(height: height / 32.55),
  //                                 InkWell(
  //                                   onTap: () {
  //                                     // Your logic goes here
  //                                     Navigator.pop(context);
  //                                   },
  //                                   child: Container(
  //                                     height: height / 16.275,
  //                                     width: 200,
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.green,
  //                                       borderRadius: BorderRadius.circular(8),
  //                                       boxShadow: [
  //                                         BoxShadow(
  //                                           color: Colors.black26,
  //                                           offset: Offset(1, 2),
  //                                           blurRadius: 3,
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     child: Padding(
  //                                       padding: EdgeInsets.symmetric(horizontal: width / 227.66),
  //                                       child: Center(
  //                                         child: KText(
  //                                           text: "Close",
  //                                           style: SafeGoogleFont(
  //                                             'Poppins',
  //                                             fontSize: width / 105.375,
  //                                             fontWeight: FontWeight.w700,
  //                                             color: Colors.white,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 SizedBox(height: height / 32.55),
  //                               ],
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  @override
  void initState() {
    userCounta();
    departmentdataFetchFunc();
    // TODO: implement initState
    super.initState();
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
                                          Text(
                                            'Add User Details',
                                            style: TextStyle(
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
                                            width: width / 2.7463,
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
                                                      image: AssetImage('assets/avator.png'),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: width / 102.4),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Upload Student Photo (150px X 150px)",
                                                      style: TextStyle(
                                                        fontSize: 17 * ffem,
                                                        fontWeight: FontWeight.w600,
                                                        height: 1.3625 * ffem / fem,
                                                        color: const Color(0xff000000),
                                                      ),
                                                    ),
                                                    SizedBox(height: height / 100.8),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            addImage(size);
                                                          },
                                                          child: Container(
                                                            height: height / 24.633,
                                                            width: width / 19.2,
                                                            decoration: BoxDecoration(
                                                              color: const Color(0xffDDDEEE),
                                                              border: Border.all(color: const Color(0xff000000)),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "Choose File",
                                                                style: TextStyle(
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
                                                        Text(
                                                          Uploaddocument == null ? "No file chosen" : "File is Selected",
                                                          style: TextStyle(
                                                            fontSize: 17 * ffem,
                                                            fontWeight: FontWeight.w600,
                                                            height: 1.3625 * ffem / fem,
                                                            color: const Color(0xff000000),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height:7
                                      ),

                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:35.0),
                                    child: SizedBox(
                                      width: width / 2.2588,
                                      height: height / 2.75,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:16.0),
                                            child: SizedBox(
                                            
                                              height: height / 9.369,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: height / 9.369,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'Prefix *',
                                                              style: TextStyle(
                                                                fontSize: 20 * ffem,
                                                                fontWeight: FontWeight.w700,
                                                                height: 1.3625 * ffem / fem,
                                                                color: const Color(0xff000000),
                                                              ),
                                                            ),
                                                            SizedBox(height: height / 123.1666),
                                                            Container(
                                                              height: height / 15.114,
                                                              width: width / 8.0842,
                                                              decoration: BoxDecoration(
                                                                color: const Color(0xffDDDEEE),
                                                                borderRadius: BorderRadius.circular(3),
                                                              ),
                                                              child: DropdownButtonHideUnderline(
                                                                child: DropdownButtonFormField2<
                                                                    String>(
                                                                  isExpanded: true,
                                                                  autovalidateMode: AutovalidateMode
                                                                      .onUserInteraction,
                                                                  hint: Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left: 8.0),
                                                                    child: Text(
                                                                      'Select',
                                                                      style:
                                                                      SafeGoogleFont(
                                                                        'Nunito',
                                                                        fontSize:
                                                                        20 * ffem,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  items: prefixlist
                                                                      .map((String
                                                                  item) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                        item,
                                                                        child:
                                                                        Text(
                                                                          item,
                                                                          style:
                                                                          SafeGoogleFont(
                                                                            'Nunito',
                                                                            fontSize:
                                                                            20 * ffem,
                                                                          ),
                                                                        ),
                                                                      )).toList(),
                                                                  value: prefixcon.text,
                                                                  onChanged: (String?value) {
                                                                    setState(() {
                                                                     prefixcon.text = value!;

                                                                    });
                                                                  },

                                                                  buttonStyleData:
                                                                  ButtonStyleData(
                                                                    height: 20,
                                                                    width:
                                                                    width / 2.571,
                                                                  ),
                                                                  menuItemStyleData: const MenuItemStyleData(),
                                                                  decoration:
                                                                  const InputDecoration(
                                                                      contentPadding: EdgeInsets
                                                                          .only(
                                                                          left: 5,
                                                                          right: 5),
                                                                      border:
                                                                      InputBorder
                                                                          .none),
                                                                ),
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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
                                              SizedBox(
                                                height: height / 9.369,
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
                                                        height: height /
                                                            123.1666),
                                                    Container(
                                                        height: height /
                                                            15.114,
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
                                                          maxLength: 25,
                                                          controller:
                                                          middleNamecon,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(
                                                                RegExp(
                                                                    "[a-zA-Z ]")),
                                                          ],
                                                          decoration:
                                                          const InputDecoration(
                                                            counterText: "",
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
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: height / 9.369,
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
                                                        height: height /
                                                            123.1666),
                                                    Container(
                                                        height: height /
                                                            15.114,
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
                                                          controller:
                                                          lastNamecon,

                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(
                                                                RegExp(
                                                                    "[a-zA-Z ]")),
                                                          ],
                                                          maxLength:
                                                          25,
                                                          decoration:
                                                          const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            counterText:
                                                            "",
                                                            contentPadding: EdgeInsets
                                                                .only(
                                                                bottom:
                                                                10,
                                                                top:
                                                                2,
                                                                left:
                                                                10),
                                                          ),
                                                          validator: (
                                                              value) =>
                                                          value!
                                                              .isEmpty
                                                              ? 'Field is required'
                                                              : null,
                                                        ))

                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                                  mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children:[
                                                SizedBox(
                                                  height: height / 7.6,
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
                                                          controller:
                                                          dateofBirthcon,

                                                          decoration:
                                                          const InputDecoration(
                                                            border:
                                                            InputBorder
                                                                .none,
                                                            contentPadding: EdgeInsets
                                                                .only(
                                                                bottom:
                                                                10,
                                                                top: 2,
                                                                left:
                                                                10),

                                                          ),
                                                          validator: (value) =>
                                                          value!.isEmpty
                                                              ? 'Field is required'
                                                              : null,
                                                          readOnly:
                                                          true,
                                                          onTap:
                                                              () async {
                                                            DateTime? pickedDate = await showDatePicker(
                                                                context: context,
                                                                initialDate: DateTime
                                                                    .now(),
                                                                firstDate: DateTime(
                                                                    1950),
                                                                //DateTime.now() - not to allow to choose before today.
                                                                lastDate: DateTime(
                                                                    2100));

                                                            if (pickedDate != null) {
                                                              BatchYearValid= pickedDate.year;
                                                              //pickedDate output format => 2021-03-10 00:00:00.000
                                                              String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                                                              //formatted date output using intl package =>  2021-03-16

                                                              // Calculate age difference
                                                              DateTime currentDate = DateTime.now();
                                                              Duration difference = currentDate.difference(pickedDate);
                                                              int age = (difference.inDays / 365).floor();
                                                              print('Age: $age years');
                                                              if (age >=17) {
                                                                setState(() {
                                                                  dateofBirthcon.text = formattedDate; //set output date to TextField value.
                                                                });
                                                              }
                                                              else {
                                                                userNotValidAgePopup();
                                                                print("Age Is Lowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
                                                              }
                                                            } else {}
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: height / 7.6,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      KText(
                                                        text: 'Gender *',
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
                                                        DropdownButtonHideUnderline(
                                                          child: DropdownButtonFormField2<
                                                              String>(
                                                            isExpanded: true,
                                                            autovalidateMode: AutovalidateMode
                                                                .onUserInteraction,
                                                            hint: Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: 8.0),
                                                              child: Text(
                                                                'Select',
                                                                style:
                                                                SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize:
                                                                  20 * ffem,
                                                                ),
                                                              ),
                                                            ),
                                                            items: GenderList
                                                                .map((String
                                                            item) =>
                                                                DropdownMenuItem<
                                                                    String>(

                                                                  value:
                                                                  item,
                                                                  child:
                                                                  Text(
                                                                    item,
                                                                    style:
                                                                    SafeGoogleFont(
                                                                      'Nunito',
                                                                      fontSize:
                                                                      20 * ffem,
                                                                    ),
                                                                  ),
                                                                )).toList(),
                                                            value: gendercon
                                                                .text,

                                                            onChanged: (String?value) {
                                                              if (value == 'Select') {
                                                                setState(() {
                                                                  genderValidator = true;
                                                                  print('male');
                                                                });
                                                              }
                                                              else {
                                                                setState(() {
                                                                  gendercon.text =
                                                                  value!;
                                                                  genderValidator =
                                                                  false;
                                                                });
                                                              }
                                                            },
                                                            validator: (value) {
                                                              if (value == 'Select') {
                                                                setState(() {
                                                                  genderValidator = true;
                                                                });
                                                              }
                                                              return null;
                                                            },
                                                            buttonStyleData:
                                                            ButtonStyleData(
                                                              height: 20,
                                                              width:
                                                              width / 2.571,
                                                            ),
                                                            menuItemStyleData: const MenuItemStyleData(),
                                                            decoration:
                                                            const InputDecoration(
                                                                contentPadding: EdgeInsets
                                                                    .only(
                                                                    left: 5,
                                                                    right: 5),
                                                                border:
                                                                InputBorder
                                                                    .none),
                                                          ),
                                                        ),
                                                      ),
                                                      genderValidator == true && gendercon.text ==
                                                          "Select"
                                                          ? const Text("Field is required",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 13))
                                                          : const SizedBox()

                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height / 7.6,
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
                                                            controller:
                                                            aadhaarNumbercon,
                                                            maxLength:
                                                            14,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly,
                                                              TextInputFormatter
                                                                  .withFunction(
                                                                      (
                                                                      oldValue,
                                                                      newValue) {
                                                                    final newString =
                                                                        newValue
                                                                            .text;

                                                                    if (_inputPattern
                                                                        .hasMatch(
                                                                        newString)) {
                                                                      return oldValue;
                                                                    }

                                                                    var formattedValue = newString
                                                                        .replaceAllMapped(
                                                                        RegExp(
                                                                            r'\d{4}'),
                                                                            (
                                                                            match) {
                                                                          return '${match
                                                                              .group(
                                                                              0)} ';
                                                                        });

                                                                    // Remove any trailing space
                                                                    if (formattedValue
                                                                        .endsWith(
                                                                        ' ')) {
                                                                      formattedValue =
                                                                          formattedValue
                                                                              .substring(
                                                                              0,
                                                                              formattedValue
                                                                                  .length -
                                                                                  1);
                                                                    }

                                                                    return TextEditingValue(
                                                                      text:
                                                                      formattedValue,
                                                                      selection:
                                                                      TextSelection
                                                                          .collapsed(
                                                                          offset: formattedValue
                                                                              .length),
                                                                    );
                                                                  }),
                                                            ],
                                                            decoration:
                                                            const InputDecoration(
                                                              border: InputBorder
                                                                  .none,
                                                              counterText:
                                                              "",
                                                              contentPadding: EdgeInsets
                                                                  .only(
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
                                              ]
                                          ),
                                          ///adhaaar card and emailid

                                        ],
                                      ),
                                    ),
                                  ),
                                ] ),
                          ),
                        ),
                      )),
                  ///contact info
                  Row(
                    children: [
                      SizedBox(width: width / 307.2),
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
                      width: width / 1.4422,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(height: height / 36.95),
                  Row(
                    children: [
                      SizedBox(
                          width: width / 2.4,
                          height: height / 2.8,
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
                                  height: height / 9.369,
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
                                          height: height /
                                              123.1666),
                                      Container(
                                          height: height /
                                              15.114,
                                          width: width / 3.84,
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
                                            controller:
                                            phoneNumbercon,
                                            maxLength:
                                            10,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .allow(
                                                  RegExp(
                                                      "[0-9]")),
                                            ],
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
                                                ""),
                                            validator:
                                                (value) {
                                              if(value!.isEmpty){
                                                return 'Field is required';
                                              }
                                              else if (value!.isNotEmpty) {
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
                                  height: height / 9.369,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      KText(
                                        text:
                                        ' Alternate Mobile Number',
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
                                          height: height /
                                              15.114,
                                          width: width / 3.84,
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
                                            controller:
                                            mobileNumbercon,
                                            maxLength:
                                            10,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .allow(
                                                  RegExp(
                                                      "[0-9]")),
                                            ],
                                            decoration:
                                            const InputDecoration(
                                              border: InputBorder
                                                  .none,
                                              counterText: "",
                                              contentPadding: EdgeInsets
                                                  .only(
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
                                                if (value
                                                    .length !=
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
                                  height: height / 9.369,
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
                                          height: height /
                                              123.1666),
                                      Container(
                                          height: height /
                                              15.114,
                                          width: width / 3.84,
                                          decoration: BoxDecoration(
                                              color: const Color(
                                                  0xffDDDEEE),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  3)),
                                          child:
                                          TextFormField(
                                              controller:
                                              emailIDcon,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(
                                                    RegExp(
                                                        "[a-z@0-9.]")),
                                              ],
                                              decoration:
                                              const InputDecoration(
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
                                              ),
                                              validator:validateEmail
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        width: width / 3.49090,
                        height: height / 2.8,
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
                              SizedBox(
                                  height: height / 123.1666),
                              Container(
                                  height: height / 3.3,
                                  width: width / 3.57209,
                                  decoration: BoxDecoration(
                                      color: const Color(
                                          0xffDDDEEE),
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          3)),
                                  child: TextFormField(
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
                  ),Padding(
                    padding:  EdgeInsets.only(left: width/273.2),
                    child: Row(
                      children: [

                        ///State Dropdown
                        SizedBox(
                          height: height / 7.5,
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
                              SizedBox(
                                  height: height / 123.1666),
                              Container(
                                height: height / 15.114,
                                width: width / 6.4,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                padding:  EdgeInsets.only(
                                    left: width/273.2),
                                child:
                                DropdownSearch <String>(
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  selectedItem: statecon.text,
                                  popupProps: const PopupProps.menu(
                                    showSearchBox: true,
                                  ),
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    baseStyle:SafeGoogleFont( 'Nunito', fontSize:  20 * ffem,),
                                    textAlignVertical: TextAlignVertical.center,
                                    dropdownSearchDecoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                  items: StateList,
                                  validator: (value) {
                                    if (value=='Select State') {
                                      setState((){
                                        dropdownValidator=true;
                                      });
                                    }
                                    return null;
                                  },
                                  onChanged: (String? value) {
                                    getCity(value.toString());
                                    if (value=='Select State') {
                                      setState((){
                                        dropdownValidator=true;
                                      });
                                    }else{

                                      setState(() {
                                        statecon.text =
                                        value!;
                                        dropdownValidator=false;
                                      });
                                    }
                                  },
                                ),  ),
                              dropdownValidator == true &&
                                  statecon.text ==
                                      "Select State"
                                  ? const Text("Field is required",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13))
                                  : const SizedBox()
                            ],
                          ),
                        ),
                        SizedBox(width: width / 46.5454),
                        ///city
                        SizedBox(
                          height: height / 7.5,
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
                              SizedBox(
                                  height: height / 123.1666),
                              Container(
                                height: height / 15.114,
                                width: width / 6.4,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                padding:  EdgeInsets.only(
                                    left: width/273.2),
                                child:
                                DropdownSearch <String>(
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  selectedItem: citycon.text,
                                  popupProps: const PopupProps.menu(
                                    showSearchBox: true,
                                  ),

                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    baseStyle:SafeGoogleFont( 'Nunito', fontSize:  20 * ffem,),
                                    textAlignVertical: TextAlignVertical.center,
                                    dropdownSearchDecoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                  items: _cities,
                                  validator: (value) {
                                    if (value ==
                                        'Select City') {
                                      setState(() {
                                        dropdownValidator2 =
                                        true;
                                      });
                                    }
                                    return null;
                                  },
                                  onChanged: (String?
                                  value) {
                                    if (value ==
                                        'Select City') {
                                      setState(() {
                                        dropdownValidator2 =
                                        true;
                                      });
                                    }
                                    else {
                                      setState(() {
                                        citycon.text =
                                        value!;
                                        dropdownValidator2 =
                                        false;
                                      });
                                    }
                                  },
                                ),

                              ),
                              dropdownValidator2 == true &&
                                  citycon.text == "Select City"
                                  ? const Text("Field is required",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13))
                                  : const SizedBox()
                            ],
                          ),
                        ),
                        SizedBox(width: width / 43.8857),
                        ///Pin Code
                        SizedBox(
                          height: height / 7.5,
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
                              SizedBox(
                                  height: height / 123.1666),
                              Container(
                                  height: height / 15.114,
                                  width: width / 6.4,
                                  decoration: BoxDecoration(
                                      color: const Color(
                                          0xffDDDEEE),
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          3)),
                                  child: TextFormField(
                                    controller:
                                    pinCodecon,
                                    maxLength: 6,
                                    autovalidateMode: AutovalidateMode
                                        .onUserInteraction,
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
                        SizedBox(width: width / 43.8857),
                        ///Country Dropdown
                        SizedBox(
                          height: height / 7.5,
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
                              SizedBox(
                                  height: height / 123.1666),
                              Container(
                                height: height / 15.114,
                                width: width / 6.4,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                padding:  EdgeInsets.only(
                                    left: width/273.2),
                                child:
                                DropdownSearch <String>(
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  selectedItem: countrycon.text,
                                  popupProps: const PopupProps.menu(
                                    showSearchBox: true,
                                  ),
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    baseStyle:SafeGoogleFont( 'Nunito', fontSize:  20 * ffem,),
                                    textAlignVertical: TextAlignVertical.center,
                                    dropdownSearchDecoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                  items: coutryList,
                                  validator: (value) {
                                    if (value ==
                                        "Select Country") {
                                      setState(() {
                                        dropdownValidator3 =
                                        true;
                                      });
                                    }
                                    return null;
                                  },
                                  onChanged: (String?
                                  value) {
                                    if (value ==
                                        'Select Country') {
                                      setState(() {
                                        dropdownValidator3 =
                                        true;
                                      });
                                    }
                                    else {
                                      setState(() {
                                        countrycon
                                            .text =
                                        value!;
                                        dropdownValidator3 =
                                        false;
                                      });
                                    }
                                  },
                                ), ),
                              dropdownValidator3 == true &&
                                  countrycon.text ==
                                      "Select Country"
                                  ? const Text("Field is required",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13))
                                  : const SizedBox()

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ///Faculty details
                  SizedBox(height: height / 36.95),
                  Row(
                    children: [
                      SizedBox(width: width / 307.2),
                      KText(
                        text: 'User Details',
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
                      width: width / 1.4422,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(height: height / 36.95),

                  Row(
                    children: [
                      SizedBox(
                        height: height / 2.8 + 12,
                        width: width / 2.19428,
                        child: Column(

                          children: [

                            ///subject stream and containers
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                SizedBox(
                                  height: height / 7.5,
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
                                          height: height /
                                              123.1666),
                                      Container(
                                          height: height /
                                              15.114,
                                          width: width / 4.6545,
                                          decoration: BoxDecoration(
                                              color: const Color(
                                                  0xffDDDEEE),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  3)),
                                          child:
                                          TextFormField(
                                            readOnly: true,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            controller: yearPassedcon,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .allow(
                                                  RegExp(
                                                      "[0-9]")),
                                            ],
                                            onTap: () async {
                                              selectYear(context);
                                            },
                                            decoration:
                                            const InputDecoration(
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
                                            ),
                                            validator: (
                                                value) =>
                                            value!
                                                .isEmpty
                                                ? 'Field is required'
                                                : null,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height / 7.5,
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
                                          height: height /
                                              123.1666),
                                      Container(
                                        height: height / 15.114,
                                        width: width / 4.6545,
                                        decoration: BoxDecoration(
                                            color: const Color(
                                                0xffDDDEEE),
                                            borderRadius:
                                            BorderRadius.circular(
                                                3)),
                                        child:
                                        DropdownButtonHideUnderline(
                                          child:
                                          DropdownButtonFormField2<
                                              String>(
                                            isExpanded: true,
                                            hint: Text(
                                              'Select Department',
                                              style:
                                              SafeGoogleFont(
                                                'Nunito',
                                                fontSize:
                                                20 * ffem,
                                              ),
                                            ),
                                            items: departmentDataList
                                                .map((String
                                            item) =>
                                                DropdownMenuItem<
                                                    String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style:
                                                    SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize:
                                                      20 *
                                                          ffem,
                                                    ),
                                                  ),
                                                )).toList(),
                                            value:
                                            subjectStremdcon.text,
                                            validator: (value) {
                                              if (value == 'Select Department') {
                                                setState(() {
                                                  dropdownDepartmentValidator = true;
                                                });
                                              }
                                              return null;
                                            },
                                            onChanged: (String?
                                            value) {
                                              if (value ==
                                                  'Select Department') {
                                                setState(() {
                                                  dropdownDepartmentValidator =
                                                  true;
                                                });
                                              }
                                              else {
                                                setState(() {
                                                  subjectStremdcon.text =
                                                  value!;
                                                  dropdownDepartmentValidator =
                                                  false;
                                                });
                                              }
                                            },

                                            buttonStyleData:
                                            const ButtonStyleData(


                                            ),
                                            menuItemStyleData:
                                            const MenuItemStyleData(

                                            ),
                                            decoration:
                                            const InputDecoration(
                                                border:
                                                InputBorder
                                                    .none),
                                          ),
                                        ),

                                      ),
                                      dropdownDepartmentValidator == true && subjectStremdcon.text ==
                                          "Select Department"
                                          ? const Text("Field is required",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13))
                                          : const SizedBox()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ///class anb roll no container
                           // SizedBox(height: height / 116.95),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                SizedBox(
                                  height: height / 7.5,
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
                                          height: height /
                                              123.1666),
                                      Container(
                                          height: height /
                                              15.114,
                                          width: width / 4.6545,
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
                                            controller:
                                            classcon,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .allow(
                                                  RegExp(
                                                      "[a-zA-Z ]")),
                                            ],
                                            decoration:
                                            const InputDecoration(
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
                                            ),
                                            validator: (
                                                value) =>
                                            value!
                                                .isEmpty
                                                ? 'Field is required'
                                                : null,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height / 7.5,
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
                                          height: height /
                                              123.1666),
                                      Container(
                                          height: height /
                                              15.114,
                                          width: width / 4.6545,
                                          decoration: BoxDecoration(
                                              color: const Color(
                                                  0xffDDDEEE),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  3)),
                                          child:
                                          TextFormField(
                                            controller:
                                            rollnocon,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .allow(
                                                  RegExp(
                                                      "[a-zA-Z0-9 ]")),
                                            ],
                                            decoration:
                                            const InputDecoration(
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
                                  height: height / 9.369,
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
                                          height: height /
                                              123.1666),
                                      Container(
                                          height: height /
                                              15.114,
                                          width: width / 4.6545,
                                          decoration: BoxDecoration(
                                              color: const Color(
                                                  0xffDDDEEE),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  3)),
                                          child:
                                          TextFormField(
                                            controller:
                                            housecon,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .allow(
                                                  RegExp(
                                                      "[a-zA-Z0-9 ]")),
                                            ],
                                            decoration:
                                            const InputDecoration(
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
                                            ),
                                            //  validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height / 9.369,
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
                                          height: height /
                                              123.1666),
                                      Container(
                                          height: height /
                                              15.114,
                                          width: width / 4.6545,
                                          decoration: BoxDecoration(
                                              color: const Color(
                                                  0xffDDDEEE),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  3)),
                                          child:
                                          TextFormField(
                                            controller:
                                            lastvisitcon,
                                            readOnly:true,
                                            onTap:(){
                                              LastVisitselectYear(context);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .allow(
                                                  RegExp(
                                                      "[a-zA-Z0-9 ]")),
                                            ],
                                            decoration:
                                            const InputDecoration(
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
                          height: height / 2.8,
                          width: width / 4.1513,
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
                              SizedBox(
                                  height: height / 123.1666),
                              Container(
                                  height: height / 3.15,
                                  width: width / 4.45217,
                                  decoration: BoxDecoration(
                                      color: const Color(
                                          0xffDDDEEE),
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          3)),
                                  child: TextFormField(
                                    controller:
                                    statusmessagecon,
                                    autovalidateMode: AutovalidateMode
                                        .onUserInteraction,
                                    maxLines: null,
                                    expands: true,
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
                  SizedBox(height: height / 36.95),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      SizedBox(
                        height: height / 9.369,
                        width: width / 4.6545,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            KText(
                              text:
                              'Shift *',
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
                              width: width / 3.0842,
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
                                  controller: Shiftcon,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .allow(
                                        RegExp(
                                            "[a-zA-Z0-9 ]")),
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
                                      shiftValidator =
                                      false;
                                    });
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                       SizedBox(width: width / 38.4),
                      SizedBox(
                        height: height / 9.369,
                        width: width / 4.6545,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            KText(
                              text:
                              'Register Number* ',
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
                                height: height /
                                    15.114,
                                width: width / 3.0842,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child:
                                TextFormField(
                                  maxLength: 25,
                                  controller:
                                  RegisterNumbercon,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .allow(
                                        RegExp(
                                            "[a-zA-Z0-9 ]")),
                                  ],
                                  decoration:
                                  const InputDecoration(
                                    counterText: "",
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
                                  ),
                                ))
                          ],
                        ),
                      ),
                       SizedBox(width: width / 38.4),
                      SizedBox(
                        height: height / 9.369,
                        width: width / 4.6545,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            KText(
                              text:
                              'Thesis/Dissertation Topic',
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
                                height: height /
                                    15.114,
                                width: width / 3.0842,
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
                                  controller:
                                  DissertationTopiccon,

                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .allow(
                                        RegExp(
                                            "[a-zA-Z ]")),
                                  ],
                                  maxLength:
                                  25,
                                  decoration:
                                  const InputDecoration(
                                    border: InputBorder
                                        .none,
                                    counterText:
                                    "",
                                    contentPadding: EdgeInsets
                                        .only(
                                        bottom:
                                        10,
                                        top:
                                        2,
                                        left:
                                        10),
                                  ),
                                  validator: (
                                      value) =>
                                  value!
                                      .isEmpty
                                      ? 'Field is required'
                                      : null,
                                ))

                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 36.95),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      SizedBox(
                        height: height / 9.369,
                        width: width / 4.6545,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            KText(
                              text:
                              'Competitive Exam Passed*',
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
                              width: width / 4.6545,
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
                                  controller: competitveexampassedcon,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .allow(
                                        RegExp(
                                            "[a-zA-Z0-9 ]")),
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
                                      competitiveexamValidator =
                                      false;
                                    });
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: width / 38.4),
                      SizedBox(
                        height: height / 9.369,
                        width: width / 4.6545,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            KText(
                              text:
                              'Current Academic Status* ',
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
                                height: height /
                                    15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child:
                                TextFormField(
                                  maxLength: 25,
                                  controller:
                                  currentacademiccon,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .allow(
                                        RegExp(
                                            "[a-zA-Z0-9 ]")),
                                  ],
                                  decoration:
                                  const InputDecoration(
                                    counterText: "",
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
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(width: width / 38.4),
                      SizedBox(
                        height: height / 9.369,
                        width: width / 4.6545,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            KText(
                              text:
                              'Other Degree Earned',
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
                                height: height /
                                    15.114,
                                width: width / 4.6545,
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
                                  controller:
                                  otherdegreecon,

                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .allow(
                                        RegExp(
                                            "[a-zA-Z ]")),
                                  ],
                                  maxLength:
                                  25,
                                  decoration:
                                  const InputDecoration(
                                    border: InputBorder
                                        .none,
                                    counterText:
                                    "",
                                    contentPadding: EdgeInsets
                                        .only(
                                        bottom:
                                        10,
                                        top:
                                        2,
                                        left:
                                        10),
                                  ),
                                  validator: (
                                      value) =>
                                  value!
                                      .isEmpty
                                      ? 'Field is required'
                                      : null,
                                ))

                          ],
                        ),
                      ),
                    ],
                  ),
                  ///User education Qualifications
                  SizedBox(height: height / 36.95),
                  Row(
                    children: [
                      SizedBox(width: width / 307.2),
                      KText(
                        text: 'User Qualifications',
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
                      width: width / 1.4422,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(height: height / 36.95),

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
                          SizedBox(height: height / 123.1666),
                          Container(
                              height: height / 10.5571,
                              width: width / 3.01176,
                              decoration: BoxDecoration(
                                  color: const Color(
                                      0xffDDDEEE),
                                  borderRadius:
                                  BorderRadius
                                      .circular(3)),
                              child: TextFormField(
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
                      SizedBox(width: width / 30.72),
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
                          SizedBox(height: height / 123.1666),
                          Container(
                              height: height / 10.5571,
                              width: width / 3.01176,
                              decoration: BoxDecoration(
                                  color: const Color(
                                      0xffDDDEEE),
                                  borderRadius:
                                  BorderRadius
                                      .circular(3)),
                              child: TextFormField(
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

                  SizedBox(height: height / 36.95),
                  Row(
                    children: [
                      SizedBox(width: width / 307.2),
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
                      width: width / 1.4422,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(height: height / 36.95),

                  Row(
                    children: [
                      SizedBox(
                        height: height / 9.369,
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
                            SizedBox(height: height / 123.1666),
                            Container(
                              height: height / 15.114,
                              width: width / 6.6782,
                              decoration: BoxDecoration(
                                  color: const Color(
                                      0xffDDDEEE),
                                  borderRadius:
                                  BorderRadius
                                      .circular(3)),
                              child:
                              DropdownButtonHideUnderline(
                                child:
                                DropdownButtonFormField2<
                                    String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Working',
                                    style:
                                    SafeGoogleFont(
                                      'Nunito',
                                      fontSize:
                                      20 * ffem,
                                    ),
                                  ),
                                  items: WorkingEmpList
                                      .map((String
                                  item) =>
                                      DropdownMenuItem<
                                          String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style:
                                          SafeGoogleFont(
                                            'Nunito',
                                            fontSize:
                                            20 *
                                                ffem,
                                          ),
                                        ),
                                      )).toList(),
                                  value:
                                  alumniEmployedController
                                      .text,
                                  onChanged:
                                      (String? value) {
                                    setState(() {
                                      alumniEmployedController
                                          .text =
                                      value!;
                                    });
                                  },
                                  buttonStyleData:
                                  const ButtonStyleData(


                                  ),
                                  menuItemStyleData:
                                  const MenuItemStyleData(

                                  ),
                                  decoration:
                                  const InputDecoration(
                                      border:
                                      InputBorder
                                          .none),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: height / 36.95),
                  alumniEmployedController.text == "Yes" ?
                  Row(
                    children: [
                      SizedBox(
                        height: height / 9.369,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Occupation',
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
                            SizedBox(height: height / 123.1666),
                            Container(
                                height: height / 15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child: TextFormField(
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
                      SizedBox(width: width / 38.4),
                      SizedBox(
                        height: height / 9.369,
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
                            SizedBox(height: height / 123.1666),
                            Container(
                                height: height / 15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child: TextFormField(
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
                      SizedBox(width: width / 38.4),
                      SizedBox(
                        height: height / 9.369,
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
                            SizedBox(height: height / 123.1666),
                            Container(
                                height: height / 15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child: TextFormField(
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
                  ) :
                  alumniEmployedController.text ==
                      "Own Business" ?
                  Row(
                    children: [


                      SizedBox(
                        height: height / 9.369,
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
                            SizedBox(height: height / 123.1666),
                            Container(
                                height: height / 15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child: TextFormField(
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
                      SizedBox(width: width / 38.4),
                      SizedBox(
                        height: height / 9.369,
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
                            SizedBox(height: height / 123.1666),
                            Container(
                                height: height / 15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child: TextFormField(
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
                  ) :
                  const SizedBox(),
                  SizedBox(height: height / 36.95),
                  Row(
                    children: [
                      SizedBox(width: width / 307.2),
                      KText(
                        text: 'Career Information',
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
                      width: width / 1.4422,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(height: height / 36.95),

                  Row(
                    children: [
                      SizedBox(
                        height: height / 9.369,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Are You Placed',
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
                            SizedBox(height: height / 123.1666),
                            Container(
                              height: height / 15.114,
                              width: width / 6.6782,
                              decoration: BoxDecoration(
                                  color: const Color(
                                      0xffDDDEEE),
                                  borderRadius:
                                  BorderRadius
                                      .circular(3)),
                              child:
                              DropdownButtonHideUnderline(
                                child:
                                DropdownButtonFormField2<
                                    String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Working',
                                    style:
                                    SafeGoogleFont(
                                      'Nunito',
                                      fontSize:
                                      20 * ffem,
                                    ),
                                  ),
                                  items: OFFCampus
                                      .map((String
                                  item) =>
                                      DropdownMenuItem<
                                          String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style:
                                          SafeGoogleFont(
                                            'Nunito',
                                            fontSize:
                                            20 *
                                                ffem,
                                          ),
                                        ),
                                      )).toList(),
                                  value:
                                  alumniEmploymentsController
                                      .text,
                                  onChanged:
                                      (String? value) {
                                    setState(() {
                                      alumniEmploymentsController
                                          .text =
                                      value!;
                                    });
                                  },
                                  buttonStyleData:
                                  const ButtonStyleData(


                                  ),
                                  menuItemStyleData:
                                  const MenuItemStyleData(

                                  ),
                                  decoration:
                                  const InputDecoration(
                                      border:
                                      InputBorder
                                          .none),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: height / 36.95),
                  alumniEmploymentsController.text == "On Campus" ?
                  Row(
                    children: [
                      SizedBox(
                        height: height / 9.369,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Company/Organization',
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
                            SizedBox(height: height / 123.1666),
                            Container(
                                height: height / 15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child: TextFormField(
                                  controller:
                                  organizationcon,
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
                      SizedBox(width: width / 38.4),
                      SizedBox(
                        height: height / 9.369,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Industry',
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
                            SizedBox(height: height / 123.1666),
                            Container(
                                height: height / 15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child: TextFormField(
                                  controller:
                                  industrycon,
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
                      SizedBox(width: width / 38.4),
                      SizedBox(
                        height: height / 9.369,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            KText(
                              text:
                              "Package at the time of placement",
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
                            SizedBox(height: height / 123.1666),
                            Container(
                                height: height / 15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child: TextFormField(
                                  controller:
                                  packagecon,
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
                  ) :
                  alumniEmploymentsController.text ==
                      "OFF Campus" ?
                  Row(
                    children: [


                      SizedBox(
                        height: height / 9.369,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Company/Organization',
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
                            SizedBox(height: height / 123.1666),
                            Container(
                                height: height / 15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child: TextFormField(
                                  controller:
                                  organizationcon,
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
                      SizedBox(width: width / 38.4),
                      SizedBox(
                        height: height / 9.369,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Industry',
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
                            SizedBox(height: height / 123.1666),
                            Container(
                                height: height / 15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child: TextFormField(
                                  controller:
                                  industrycon,
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
                      SizedBox(width: width / 38.4),
                      SizedBox(
                        height: height / 9.369,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            KText(
                              text:
                              "Package at the time of appointment",
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
                            SizedBox(height: height / 123.1666),
                            Container(
                                height: height / 15.114,
                                width: width / 4.6545,
                                decoration: BoxDecoration(
                                    color: const Color(
                                        0xffDDDEEE),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3)),
                                child: TextFormField(
                                  controller:
                                  packagecon,
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

               
                    ]
              ):

                  const SizedBox(),
                  SizedBox(height: height / 36.95),
                      Row(
                    children: [
                      SizedBox(width: width / 307.2),
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
                      width: width / 1.4422,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(height: height / 36.95),
                  Row(
                    children: [
                      SizedBox(
                        height: height / 9.369,
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
                            SizedBox(height: height / 123.1666),
                            Container(
                              height: height / 15.114,
                              width: width / 6.6782,
                              decoration: BoxDecoration(
                                  color: const Color(
                                      0xffDDDEEE),
                                  borderRadius:
                                  BorderRadius
                                      .circular(3)),
                              child:
                              DropdownButtonHideUnderline(

                                child:
                                DropdownButtonFormField2<
                                    String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Marital Status',
                                    style:
                                    SafeGoogleFont(
                                      'Nunito',
                                      fontSize:
                                      20 * ffem,
                                    ),
                                  ),
                                  items: MaritalStatusList
                                      .map((String
                                  item) =>
                                      DropdownMenuItem<
                                          String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style:
                                          SafeGoogleFont(
                                            'Nunito',
                                            fontSize:
                                            20 *
                                                ffem,
                                          ),
                                        ),
                                      )).toList(),
                                  value:
                                  maritalStatuscon
                                      .text,
                                  onChanged:
                                      (String? value) {
                                    setState(() {
                                      maritalStatuscon
                                          .text =
                                      value!;
                                    });
                                  },
                                  buttonStyleData:
                                  const ButtonStyleData(


                                  ),
                                  menuItemStyleData:
                                  const MenuItemStyleData(

                                  ),
                                  decoration:
                                  const InputDecoration(
                                      border:
                                      InputBorder
                                          .none),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: width / 38.4),
                      maritalStatuscon.text == "Yes"
                          ? SizedBox(
                          child: Row(children: [
                            SizedBox(
                              height: height / 9.369,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  KText(
                                    text:
                                    'Spouse Name *',
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
                                  SizedBox(height: height / 123.1666),
                                  Container(
                                      height: height / 15.114,
                                      width: width / 6.4,
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xffDDDEEE),
                                          borderRadius:
                                          BorderRadius.circular(
                                              3)),
                                      child:
                                      TextFormField(
                                        autovalidateMode: AutovalidateMode
                                            .onUserInteraction,
                                        controller:
                                        spouseNamecon,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .allow(RegExp(
                                              "[a-zA-Z ]")),
                                        ],
                                        decoration:
                                        const InputDecoration(
                                          border: InputBorder   .none,
                                          contentPadding: EdgeInsets
                                              .only(
                                              bottom:
                                              10,
                                              top: 2,
                                              left:
                                              10),
                                        ),
                                        validator: (value) {
                                          if(maritalStatuscon.text == "Yes"){
                                            if(value!.isEmpty) {
                                              return 'Field is required';
                                            }
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(width: width / 38.4),
                            SizedBox(
                              height: height / 9.369,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  KText(
                                    text:
                                    "Anniversary  Date ",
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
                                  SizedBox(height: height /
                                      123.1666),
                                  Container(
                                      height: height / 15.114,
                                      width: width / 6.4,
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
                                          contentPadding: EdgeInsets
                                              .only(
                                              bottom:
                                              10,
                                              top: 2,
                                              left:
                                              10),
                                        ),
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2100),
                                          );

                                          if (pickedDate != null && pickedDate.isBefore(DateTime.now())) {
                                            // Check if the picked date is not in the future
                                            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                                            setState(() {
                                              anniversaryDatecon.text = formattedDate;
                                            });
                                          } else {
                                            // Handle the case where the picked date is in the future
                                            // You can show a message, reset the date, etc.
                                            // For now, let's clear the text field
                                            setState(() {
                                              anniversaryDatecon.text = "";
                                            });
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Please select a date in the past or today.'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        },
                                        // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(width: width / 38.4),
                            SizedBox(
                              height: height / 9.369,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  KText(
                                    text:
                                    "No. Of Children",
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
                                  SizedBox(height: height /
                                      123.1666),
                                  Container(
                                      height: height / 15.114,
                                      width: width / 6.4,
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xffDDDEEE),
                                          borderRadius:
                                          BorderRadius.circular(
                                              3)),
                                      child:
                                      TextFormField(
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
                                          contentPadding: EdgeInsets
                                              .only(
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
                  SizedBox(height: height / 24.633),
                  ///buttons Save reset and back

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: width / 2.2925,
                      ),

                      ///save button
                      GestureDetector(
                        onTap: Loading == false ? () {
                          if (citycon.text == "Select City") {
                            setState(() {
                              dropdownValidator2 = true;
                            });
                          }

                          if (statecon.text == "Select State") {
                            setState(() {
                              dropdownValidator = true;
                            });
                          }

                          if (countrycon.text == "Select Country") {
                            setState(() {
                              dropdownValidator3 = true;
                            });
                          }
                          if (subjectStremdcon.text == "Select Department") {
                            setState(() {
                              dropdownDepartmentValidator = true;
                            });
                          }
                          if (gendercon.text == "Select") {
                            setState(() {
                              genderValidator = true;
                            });
                          }
                          if (_formkey.currentState!.validate()) {
                            if (citycon.text == "Select City") {
                              setState(() {
                                dropdownValidator2 = true;
                              });
                            }
                            if (statecon.text == "Select State") {
                              setState(() {
                                dropdownValidator = true;
                              });
                            }
                            if (countrycon.text == "Select Country") {
                              setState(() {
                                dropdownValidator3 = true;
                              });
                            }
                            if (subjectStremdcon.text == "Select Department") {
                              setState(() {
                                dropdownDepartmentValidator = true;
                              });
                            }
                            if (gendercon.text == "Select") {
                              setState(() {
                                genderValidator = true;
                              });
                            }
                            if (dropdownValidator == false &&
                                dropdownValidator2 == false &&
                                dropdownValidator3 == false&&
                                dropdownDepartmentValidator==false&&
                                genderValidator==false
                            ) {
                              print( "Finalaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                              userdatecreatefunc();
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please fill all the fields'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        } : () {},
                        child: Container(
                            height: height / 18.475,
                            width: width / 12.8,
                            decoration: BoxDecoration(
                              color: const Color(0xffD60A0B),
                              borderRadius:
                              BorderRadius.circular(
                                  4),
                            ),
                            child: Center(
                              child: KText(
                                text: 'Save',
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
                        width: width / 76.8,
                      ),

                      ///Reset Button
                      GestureDetector(
                        onTap: () {
                          widget.updateDisplay(!widget.displayFirstWidget);
                        },
                        child: Container(
                            height: height / 18.475,
                            width: width / 12.8,
                            decoration: BoxDecoration(
                              color: const Color(0xff00A0E3),
                              borderRadius:
                              BorderRadius.circular(
                                  4),
                            ),
                            child: Center(
                              child: KText(
                                text: 'Reset',
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
                        width: width / 76.8,
                      ),

                      ///back Button
                      GestureDetector(
                        onTap: () {
                          widget.updateDisplay(!widget.displayFirstWidget);
                        },
                        child: Container(
                            height: height / 18.475,
                            width: width / 12.8,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                              BorderRadius.circular(
                                  4),
                            ),
                            child: Center(
                              child: KText(
                                text: 'Back',
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
                  SizedBox(height: height / 24.633
                  ),
           ] ),
          ),
          )
        ],
      ),
    );
    //)]));
    /////////////])
    // ))]) );
  }

  selectYear(context) async {
    print("Calling date picker");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(1950, 1),
              // lastDate: DateTime.now(),
              lastDate:DateTime.now(),
              initialDate: DateTime(1950),
              selectedDate: _selectedYear,
              currentDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                print(dateTime.year);
                if(dateTime!.year<(BatchYearValid+17)){
                  print("Age Is Not Valiuddddddddddddddddddddddddddddddddddddddd");
                  Navigator.pop(context);
                  Get.to(userNotValidYearOfPassedPopup(context));
                }
                if (dateTime != null && dateTime != DateTime.now()) {
                  print('Selected year: ${dateTime.year}');
                  setState(() {
                    _selectedYear = dateTime;
                    yearPassedcon.text =dateTime.year.toString();
                    showYear = "${dateTime.year}";
                  });
                  Navigator.pop(context);

                }

              },
            ),
          ),
        );
      },
    );
  }

  userNotValidYearOfPassedPopup(context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    showDialog(
      barrierColor: Colors.transparent,
      context: context, builder: (context) {
      return ZoomIn(
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 160.0, bottom: 160, left: 400, right: 400),
          child: Material(
            color: Colors.white,
            shadowColor: const Color(0xff245BCA),
            borderRadius: BorderRadius.circular(8),
            elevation: 10,
            child: Container(

              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Scaffold(
                backgroundColor: const Color(0xffFFFFFF),
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height / 24.6333),
                      KText(text: "Please Select the Pass Year Correctly ", style:
                      SafeGoogleFont(
                          'Nunito',
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 18

                      )),

                      SizedBox(height: height / 36.95),

                      SizedBox(
                          height: height / 4.10555,
                          width: width / 8.53333,
                          child: Icon(Icons.error_outline, color: Colors.red,
                            size: width / 10.5076,)
                      ),

                      SizedBox(height: height / 36.95),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: height / 18.475,
                              width: width / 8.53333,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color:  Constants().primaryAppColor
                              ),
                              child: Center(
                                child: KText(text: "Okay",
                                  style:
                                  SafeGoogleFont(
                                      'Nunito',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16

                                  ),),
                              ),
                            ),
                          ),
                        ],
                      )

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
}
