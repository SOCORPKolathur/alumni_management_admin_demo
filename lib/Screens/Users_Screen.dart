import 'dart:convert';
import 'dart:math';
import 'package:alumni_management_admin/Screens/usereditform.dart';
import 'package:alumni_management_admin/Screens/userform.dart';
import 'package:alumni_management_admin/common_widgets/developer_card_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../Constant_.dart';
import '../Models/Language_Model.dart';
import '../StateModel.dart' as StatusModel;
import '../utils.dart';
import 'dart:html';
import 'package:number_paginator/number_paginator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Users_Screen extends StatefulWidget {
  bool?UserViewed;
  Users_Screen({this.UserViewed});

  @override
  State<Users_Screen> createState() => _Users_ScreenState();
}
const List<String> StateList = <String>[
  "Select State",
  "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chhattisgarh",
  "Goa",
  'Gujarat',
  "Haryana",
  "Himachal Pradesh",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttarakhand",
  " Uttar Pradesh",
  "West Bengal",
];
const List<String> GenderList = <String>[
  'Select',
  "Male",
  "Female",
  "Transgender"
];
const List<String> coutryList = <String>[
  'Select Country',
  "Afghanistan",
  "Albania",
  "Algeria",
  "Andorra",
  "Angola",
  "Antigua and Barbuda",
  "Argentina",
  "Armenia",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  'Belize',
  "Bhutan",
  'Bolivia',
  'Bosnia and Herzegovina',
  'Botswana',
  'Brazil',
  'Brunei',
  'Bulgaria',
  'Burkina Faso',
  'Burundi',
  "Côte d'Ivoire",
  'Cabo Verde	',
  'Cambodia',
  'Cameroon	',
  'Canada',
  'Central African Republic',
  'Chad',
  'Chile',
  'China',
  'Colombia',
  'Comoros',
  'Congo (Congo-Brazzaville)	',
  'Costa Rica	',
  'Croatia	',
  'Cuba	',
  'Cyprus	',
  'Czechia (Czech Republic)',
  'Democratic Republic of the Congo',
  'Denmark',
  'Djibouti',
  'Dominica',
  'Dominican Republic',
  'Ecuador',
  'Egypt',
  'El Salvador',
  'Equatorial Guinea',
  'Eritrea	',
  'Estonia	',
  'Eswatini (Swaziland)	',
  'Ethiopia	',
  'Fiji	',
  'Finland	',
  'France	',
  'Gabon	',
  'Gambia	',
  'Georgia',
  'Germany',
  'Ghana',
  'Greece',
  'Grenada',
  'Guatemala',
  'Guinea',
  'Guinea-Bissau',
  'Guyana',
  'Haiti',
  'Holy See	',
  'Honduras',
  'Hungary',
  'Iceland',
  'India',
  'Indonesia',
  'Iran',
  'Iraq',
  'Ireland',
  'Israel',
  'Italy',
  'Jamaica',
  'Japan',
  'Jordan',
  'Kazakhstan',
  'Kenya',
  'Kiribati',
  'Kuwait',
  'Kyrgyzstan',
  'Laos',
  'Latvia',
  'Lebanon',
  'Lesotho',
  'Liberia',
  'Libya',
  'Liechtenstein',
  'Lithuania',
  'Luxembourg',
  'Madagascar',
  'Malawi',
  'Malaysia',
  'Maldives',
  'Mali',
  'Malta',
  'Marshall Islands	',
  'Mauritania',
  'Mauritius',
  'Mexico',
  'Micronesia',
  'Moldova',
  'Monaco',
  'Mongolia',
  'Montenegro',
  'Morocco',
  'Mozambique',
  'Myanmar (formerly Burma)',
  'Namibia',
  'Nauru',
  'Nepal',
  'Netherlands',
  'New Zealand',
  'Nicaragua',
  'Niger',
  'Nigeria',
  'North Korea',
  'North Macedonia',
  'Norway',
  'Oman',
  'Pakistan',
  'Palau',
  'Palestine State',
  'Panama',
  'Papua New Guinea',
  'Paraguay',
  'Peru',
  'Philippines',
  'Poland',
  'Portugal',
  'Qatar',
  'Romania',
  'Russia',
  'Rwanda',
  'Saint Kitts and Nevis	',
  'Saint Lucia	',
  'Saint Vincent and the Grenadines	',
  'Samoa',
  'San Marino	',
  'Sao Tome and Principe	',
  'Saudi Arabia	',
  'Senegal',
  'Serbia',
  'Seychelles	',
  'Sierra Leone	',
  'Singapore',
  'Slovakia',
  'Slovenia',
  'Solomon Islands	',
  'Somalia',
  'South Africa',
  'South Korea',
  'South Sudan',
  'Spain',
  'Sri Lanka',
  'Sudan',
  'Suriname',
  'Sweden',
  'Switzerland',
  'Syria',
  'Tajikistan',
  'Tanzania',
  'Thailand',
  'Timor-Leste',
  'Togo',
  'Tonga',
  'Trinidad and Tobago',
  'Tunisia',
  'Turkey',
  'Turkmenistan',
  'Tuvalu',
  'Uganda',
  'Ukraine',
  'United Arab Emirates',
  'United Kingdom	',
  'United States of America	',
  'Uruguay	',
  'Uzbekistan	',
  'Vanuatu	',
  'Venezuela	',
  'Vietnam	',
  'Yemen',
  'Zambia',
  'Zimbabwe',
];
const List<String> MaritalStatusList = ['Marital Status', 'Yes', 'No'];
const List<String> WorkingEmpList = [ 'No', 'Yes', "Own Business"];

DateTime? dateRangeStart;
DateTime? dateRangeEnd;
List<String> mydate=[];
bool isFiltered=false;
final DateFormat formatter = DateFormat('d/M/yyyy');

class _Users_ScreenState extends State<Users_Screen> {
  bool viewUser_details = false;
  GlobalKey floatingKey = LabeledGlobalKey("Floating");
  bool isFloatingOpen = false;
  OverlayEntry? floating;
  String viewDocid = "";
  bool filtervalue = false;
  bool UserEdit = false;
  bool Useradd = false;

  String filterChageValue = "Name";


  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final RegExp _inputPattern = RegExp(r'^\d{4}\s\d{4}\s\d{4}$');
  File? Url;
  var Uploaddocument;
  String imgUrl = "";
  String userUpdateDocumentID = "";
  List filterDataList = [
    'Filter by Date',
    'Filter by Year',
    'Filter by Department',
  ];

  DateTime _selectedYear = DateTime.now();
  String showYear = 'Select Year';
  GlobalKey filterDataKey = GlobalKey();

  //static GlobalKey popMenukey = GlobalKey<PopupMenuButtonState>();
  //List<GlobalKey> popMenukey = List<GlobalKey>.generate(12, (index) => GlobalKey(debugLabel: 'key_$index'),growable: false);


  TextEditingController SerachController = TextEditingController();
  TextEditingController Date1Controller = TextEditingController();
  TextEditingController Date2Controller = TextEditingController();

  String SerachValue = "";
  bool materialStatusCheck=false;
  String FilterDataValue="";

  int BatchYearValid=0;
  List usereditlist = [
    "Edit",
    "Delete",
    "View"
  ];

  int pagecount = 0;
  int temp = 1;
  List list = new List<int>.generate(1000, (i) => i + 1);
  List <DocumentSnapshot>documentList = [];

  List<String> departmentDataList = [];
  List<String> YearDataList = [];
  List<String> FilterDataList = [];

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

  int documentlength =0 ;

  doclength() async {
    try {
      final QuerySnapshot result =
      await FirebaseFirestore.instance.collection('Users').get();
      final List<DocumentSnapshot> documents = result.docs;

      setState(() {
        documentlength = documents.length;
        pagecount = ((documentlength - 1) ~/ 10) + 1;
      });

      print(pagecount);
    } catch (error) {
      print("Error fetching data: $error");
      // Handle the error as needed
    }
  }


  @override
  void initState() {
    userCounta();
    doclength();
    _isMounted = true;
    departmentdataFetchFunc();
    // TODO: implement initState
    super.initState();
  }
  bool _isMounted = false;



  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  int billcount = 0;




  userCounta() async {
    var user = await FirebaseFirestore.instance.collection("Users").get();
    setState(() {
      billcount = user.docs.length + 1;
    });
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
  }

  bool Loading = false;
  String docid = "";


  void updateDisplay(bool newValue) {
    setState(() {
      Useradd = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery
        .of(context)
        .size
        .width;
    final double height = MediaQuery
        .of(context)
        .size
        .height;
    Size size = MediaQuery
        .of(context)
        .size;

    double baseWidth = 1920;
    double fem = MediaQuery
        .of(context)
        .size
        .width / baseWidth;
    double ffem = fem * 0.97;


    return Padding(
      padding:  EdgeInsets.only(top:height/26.04),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(

          children: [
            UserEdit == true
                ? UserEditForm(docid :docid, displayFirstWidget: Useradd, updateDisplay: updateDisplay,)
                : Useradd == true
                ? UserForm(displayFirstWidget: Useradd,updateDisplay: updateDisplay,)

                : FadeInRight(child: SizedBox(
                  width: 1610 * fem,
                  height: height / 1.08,
                  child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ///Alumni text
                              Padding(
                                padding: EdgeInsets.only(left: width / 190.2),
                                child: KText(
                                  text: 'Alumni List',
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: 24 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3625 * ffem / fem,
                                    color: const Color(0xff030229),
                                  ),
                                ),
                              ),

                              Row(
                                children: [
                                  Container(
                                    width: 1590 * fem,
                                    height: 54.96 * fem,
                                    margin: EdgeInsets.only(
                                        top: height / 65.1, left: 10),
                                    child: Row(
                                      children: [

                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              Useradd = !Useradd;
                                            });
                                          },
                                          child: Container(
                                            // bgmXF (8:2325)
                                            padding: EdgeInsets.fromLTRB(
                                                26.07 * fem,
                                                17.04 * fem,
                                                56.96 * fem,
                                                12.72 * fem),
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Constants().primaryAppColor,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10 * fem),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // plusUAm (8:2329)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      21.04 * fem,
                                                      4.32 * fem),
                                                  width: 13.04 * fem,
                                                  height: 13.04 * fem,
                                                  child: Image.asset(
                                                    'assets/images/plus.png',
                                                    width: 13.04 * fem,
                                                    height: 13.04 * fem,
                                                  ),
                                                ),
                                                KText(
                                                  // addalumniytD (8:2328)
                                                  text: Useradd == false
                                                      ? 'Add Alumni'
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
                                              ],
                                            ),
                                          ),
                                        ),
                                        ///Search Container
                                        Padding(
                                            padding: EdgeInsets.only(
                                              left: width / 2,),
                                            child:
                                            Material(
                                              elevation: 3,
                                              color: const Color(0xffFFFFFF),
                                              borderRadius: BorderRadius.circular(
                                                  5),
                                              child: Container(
                                                  height: height / 5.464,
                                                  width: width / 5.1,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffFFFFFF),
                                                      borderRadius: BorderRadius
                                                          .circular(5)
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: width / 81.375,
                                                        right: width / 341.5,
                                                        bottom: height / 61.375,
                                                        top: height / 61.375),
                                                    child: TextField(
                                                        style: SafeGoogleFont( 'Nunito',),
                                                        controller: SerachController,
                                                        decoration:  InputDecoration(
                                                            hintText: "Search",
                                                            border: InputBorder
                                                                .none,
                                                          prefixIcon: Icon(Icons.search_rounded,color:Constants().primaryAppColor),
                                                          suffixIcon: InkWell(
                                                              onTap:(){
                                                                setState(() {
                                                                  SerachValue ="";
                                                                  SerachController.clear();
                                                                });
                                                              },
                                                          child: Icon(Icons.clear,color:Constants().primaryAppColor)),
                                                        ),
                                                        onChanged: (value) {
                                                          if(_isMounted){
                                                            setState(() {
                                                              SerachValue = value.toString();
                                                              FilterDataValue="";
                                                            });
                                                          }
                                                        }
                                                    ),
                                                  )
                                              ),
                                            )
                                        ),

      /*
                                        Useradd == true ? const SizedBox() :
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: width / 40.6,),
                                          child: InkWell(
                                            key: filterDataKey,
                                            onTap: () async {
                                              if(mydate.isNotEmpty){
                                                print(mydate);
                                                print("List Is Clear++++++++++++++++++++++++++++++++++++++++++++++++++");
                                                setState((){
                                                  mydate.clear();
                                                  Date1Controller.clear();
                                                  Date2Controller.clear();
                                                });
                                              }
                                             else{
                                                filterDataMenuItem(
                                                    context, filterDataKey, size);
                                              }
                                            },
                                            child: Container(
                                              height: height / 16.275,
                                              decoration: BoxDecoration(
                                                color: Constants()
                                                    .primaryAppColor,
                                                borderRadius: BorderRadius
                                                    .circular(8),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(1, 2),
                                                    blurRadius: 3,
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width / 227.66),
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.filter_list_alt,
                                                        color: Colors.white),
                                                    KText(
                                                      text: mydate.isNotEmpty?"Clear Date":" Filter by Date",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize: width / 120.571,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )*/

                                      ],
                                    ),
                                  ),


                                ],
                              ),

                              SizedBox(height: height / 26.04),

                              ///stream titles text
                              Container(
                                width: width / 1,
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

                                    Container(
                                      color: Colors.white,
                                      width: width/20.2,
                                      height: height/14.78,
                                      alignment: Alignment.center,
                                      child: Center(
                                        ///SL.No
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            KText(
                                              text: "SL.No",
                                              style: SafeGoogleFont(
                                                'Nunito',
                                                color: Color(0xff030229),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(
                                                  left: width/192),
                                              child: InkWell(
                                                onTap: () {

                                                },
                                                child: Transform.rotate(
                                                  angle:  0,
                                                  child: Opacity(
                                                    // arrowdown2TvZ (8:2307)
                                                    opacity: 0.7,
                                                    child: Container(
                                                      width: width/153.6,
                                                      height: height/73.9,
                                                      child: Image.asset(
                                                        'assets/images/arrow-down-2.png',
                                                        width: width/153.6,
                                                        height: height/73.9,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ///NAme
                                    Container(
                                      color: Colors.white,
                                      width: width / 7.2,
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

                                    /// Email
                                    Container(
                                      color: Colors.white,
                                      width: width / 7.2,
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

                                    ///Phone Number
                                    Container(
                                      color: Colors.white,
                                      width: width / 6.8,
                                      height: height / 14.78,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          left: width / 100.533),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

                                    ///Gender
                                    Container(
                                      color: Colors.white,
                                      width: width / 10,
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

                                    /// Status
                                    Container(
                                      color: Colors.white,
                                      width: width / 11.5,
                                      height: height / 14.78,
                                      alignment: Alignment.center,

                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .end,
                                        children: [
                                          KText(
                                            text: "Status",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              color: const Color(0xff030229),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width / 170.75,
                                                right: 30),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  filtervalue = !filtervalue;
                                                  filterChageValue = "verifyed";
                                                });
                                              },
                                              child: Transform.rotate(
                                                angle: filtervalue &&
                                                    filterChageValue == "verifyed"
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
                                                            filterChageValue == "verifyed"?Colors.green:Colors.transparent
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///Batch
                                    Container(
                                      color: Colors.white,
                                      width: width / 11,
                                      height: height / 14.78,
                                      alignment: Alignment.center,
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          KText(
                                            text: "Batch",
                                            style: SafeGoogleFont(
                                              'Nunendito',
                                              color: const Color(0xff030229),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width / 170.75,
                                                right: width / 91.0666),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  filtervalue = !filtervalue;
                                                  filterChageValue = "yearofpassed";
                                                });
                                              },
                                              child: Transform.rotate(
                                                angle: filtervalue &&
                                                    filterChageValue == "yearofpassed"
                                                    ? 200
                                                    : 0,
                                                child: Opacity(
                                                  // arrowdown2TvZ (8:2307)
                                                  opacity: 0.7,
                                                  child: SizedBox(
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

                                    ///Actions
                                    Container(
                                      color: Colors.white,
                                      width: width / 9.98,
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
                                                right: width / 91.0666),
                                            child: InkWell(
                                              onTap: () {

                                              },
                                              child: Transform.rotate(
                                                angle: 0,
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: height / 65.1),
                              SerachValue==""?
                              StreamBuilder(
                                stream:
                                FirebaseFirestore.instance.collection("Users").orderBy(filterChageValue, descending: filtervalue).snapshots(),
                                builder: (context, snapshot)  {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasData == null) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                 // pagecount = snapshot.data!.docs.length;


                                  // Main starts here for the nomal one
                                  return Column(
                                    children: [
                                      Container(
                                        color: Colors.transparent,
                                        height: height / 1.18,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          itemCount: pagecount == temp ? snapshot.data!.docs.length.remainder(10) == 0 ? 10 : snapshot.data!.docs.length.remainder(10) : 10 ,
                                          itemBuilder: (context, index) {
                                            var _userdata = snapshot.data!.docs[(temp*10)-10+index];
                                            List<GlobalKey<State<StatefulWidget>>> popMenuKeys = List.generate(
                                              snapshot.data!.docs.length, (index) => GlobalKey(),);
                                            if(mydate.isNotEmpty){
                                              if(mydate.contains(_userdata['date'].toString().toLowerCase())){
                                                if (_userdata['Name'].toString().toLowerCase().startsWith(SerachValue.toLowerCase())|| _userdata['Phone'].toString().toLowerCase().startsWith(SerachValue.toLowerCase())||
                                                    _userdata['email'].toString().toLowerCase().startsWith(SerachValue.toLowerCase())
                                                ) {
                                                  return
                                                    (temp*10)-10+index >= documentlength ? SizedBox() :
                                                    Container(
                                                    padding: EdgeInsets.only(
                                                        left: width / 136.6),
                                                    width: width / 1.21,
                                                    height: 78.22 * fem,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffffffff),
                                                      // color: Colors.blue,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10 * fem),
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          color: Colors.white,
                                                          width: width/17.2,
                                                          height: height/14.78,
                                                          alignment: Alignment.center,
                                                          child: Center(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: [
                                                                KText(
                                                                  text: "${((temp*10)-10+index) + 1}",
                                                                  style: SafeGoogleFont(
                                                                      'Nunito',
                                                                      fontSize: 18 *
                                                                          ffem,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      height:
                                                                      1.3625 *
                                                                          ffem /
                                                                          fem,
                                                                      color:
                                                                      const Color(
                                                                          0xff030229),
                                                                      textStyle: const TextStyle(
                                                                          overflow: TextOverflow
                                                                              .ellipsis
                                                                      )
                                                                ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width / 7.2,
                                                          height: height / 14.78,
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              Container(
                                                                  height: height /
                                                                      21.7,
                                                                  width: width /
                                                                      45.533,
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                      0 * fem,
                                                                      0 * fem,
                                                                      14.34 * fem,
                                                                      0 * fem),
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        19.5553703308 *
                                                                            fem),
                                                                    image:
                                                                    DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: NetworkImage(
                                                                          _userdata[
                                                                          'UserImg']
                                                                              .toString()),
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                      child: _userdata['UserImg']
                                                                          .toString() ==
                                                                          ""
                                                                          ? const Icon(
                                                                          Icons
                                                                              .person)
                                                                          : const Text("")
                                                                  )
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                    0 * fem,
                                                                    4.14 * fem,
                                                                    129.49 * fem,
                                                                    0 * fem),
                                                                child: KText(
                                                                  text: "${_userdata['Name']} ${_userdata['lastName']}",
                                                                  style: SafeGoogleFont(

                                                                      'Nunito',
                                                                      fontSize: 18 *
                                                                          ffem,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      height:
                                                                      1.3625 *
                                                                          ffem /
                                                                          fem,
                                                                      color:
                                                                      const Color(
                                                                          0xff030229),
                                                                      textStyle: const TextStyle(
                                                                          overflow: TextOverflow
                                                                              .ellipsis
                                                                      )
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height / 14.78,
                                                          width: width / 6.2,
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              KText(
                                                                text: _userdata['email'],
                                                                style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize: 18 *
                                                                      ffem,
                                                                  fontWeight: FontWeight
                                                                      .w400,
                                                                  height: 1.3625 *
                                                                      ffem / fem,
                                                                  color: const Color(
                                                                      0xff030229),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height / 14.78,
                                                          width: width / 7.2,
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              KText(
                                                                text: _userdata['Phone']
                                                                    .toString(),
                                                                style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize: 18 *
                                                                      ffem,
                                                                  fontWeight: FontWeight
                                                                      .w400,
                                                                  height: 1.3625 *
                                                                      ffem / fem,
                                                                  color: const Color(
                                                                      0xff030229),

                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width / 10,
                                                          height: height / 14.78,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                left: width / 54.64,
                                                                right: width /
                                                                    54.64),
                                                            child: Container(
                                                              width: width / 34.15,
                                                              height: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                color:
                                                                _userdata['Gender'] ==
                                                                    "Male"
                                                                    ? const Color(
                                                                    0x195b92ff)
                                                                    : const Color(
                                                                    0xffFEF3F0),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    33 * fem),
                                                              ),
                                                              child: Center(
                                                                child: KText(
                                                                  text: _userdata['Gender'],
                                                                  style: SafeGoogleFont(
                                                                    'Nunito',
                                                                    fontSize: 16 *
                                                                        ffem,
                                                                    fontWeight:
                                                                    FontWeight.w400,
                                                                    height:
                                                                    1.3625 * ffem /
                                                                        fem,
                                                                    color: _userdata[
                                                                    'Gender'] ==
                                                                        "Male"
                                                                        ? const Color(
                                                                        0xff5b92ff)
                                                                        : const Color(
                                                                        0xffFE8F6B),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height / 14.78,
                                                          width: width / 11.5,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              SizedBox(
                                                                  width: width /
                                                                      54.64),
                                                              Container(
                                                                // gender8qf (8:2320)
                                                                  margin:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                      0 * fem,
                                                                      0 * fem,
                                                                      15.18 * fem,
                                                                      0 * fem),
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: 5),
                                                                  child: _userdata['verifyed'] ==
                                                                      true
                                                                      ? const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .verified,
                                                                      color:
                                                                      Colors.green,
                                                                    ),
                                                                  )
                                                                      : const Icon(
                                                                    Icons
                                                                        .verified_outlined,
                                                                  )
                                                              ),
                                                              Opacity(
                                                                // arrowdown5rFs (8:2318)
                                                                opacity: 0.0,
                                                                child: Container(
                                                                  margin:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                      0 * fem,
                                                                      1.6 * fem,
                                                                      0 * fem,
                                                                      0 * fem),
                                                                  width: 7.82 * fem,
                                                                  height: 6.52 *
                                                                      fem,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/arrow-down-5.png',
                                                                    width: 7.82 *
                                                                        fem,
                                                                    height: 6.52 *
                                                                        fem,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height / 14.78,
                                                          width: width / 11,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              SizedBox(
                                                                  width: width /
                                                                      54.64),
                                                              Container(
                                                                // gender8qf (8:2320)
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    15.18 * fem,
                                                                    0 * fem),
                                                                child: Center(
                                                                  child: KText(
                                                                    text: _userdata['yearofpassed'],
                                                                    style: SafeGoogleFont(
                                                                      'Nunito',
                                                                      fontSize: 16 *
                                                                          ffem,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      height:
                                                                      1.3625 *
                                                                          ffem /
                                                                          fem,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Opacity(
                                                                // arrowdown5rFs (8:2318)
                                                                opacity: 0.0,
                                                                child: Container(
                                                                  margin:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                      0 * fem,
                                                                      1.6 * fem,
                                                                      0 * fem,
                                                                      0 * fem),
                                                                  width: 7.82 * fem,
                                                                  height: 6.52 *
                                                                      fem,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/arrow-down-5.png',
                                                                    width: 7.82 *
                                                                        fem,
                                                                    height: 6.52 *
                                                                        fem,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Popupmenu(context,
                                                                _userdata.id,
                                                                popMenuKeys[index]);
                                                            print(viewUser_details);
                                                          },
                                                          child: SizedBox(

                                                              key: popMenuKeys[index],
                                                              width: width / 9.98,
                                                              height: height /
                                                                  26.04,
                                                              child: const Icon(
                                                                  Icons
                                                                      .more_horiz)),
                                                        ),
                                                        /*GestureDetector(
                                                            onTap: () {
                                                              // setState(() {
                                                              //   viewDocid=_userdata.id;
                                                              //   viewUser_details=!viewUser_details;
                                                              // });
                                                              Popupmenu(context, _userdata.id);
                                                              print(viewUser_details);
                                                            },
                                                            child: Container(
                                                                key: popmenukey,
                                                                color:Colors.red,
                                                                width: width / 14.0,
                                                                height: height / 26.04,
                                                                child: Icon(Icons.more_horiz)),
                                                          ),*/
                                                      ],
                                                    ),
                                                  );
                                                }
                                              }
                                            }
                                            else if (SerachValue == ""&&FilterDataValue=="") {
                                              return
                                                (temp*10)-10+index >= documentlength ? SizedBox() :
                                                Container(
                                                padding: EdgeInsets.only(
                                                    left: width / 136.6),
                                                width: width / 1.21,
                                                height: 78.22 * fem,
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                      0xffffffff),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10 * fem),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      color: Colors.white,
                                                      width: width/27.2,
                                                      height: height/14.78,
                                                      alignment: Alignment.center,
                                                      child: Center(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          children: [
                                                            KText(
                                                              text: "${((temp*10)-10+index) + 1}",
                                                              style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize: 18 *
                                                                      ffem,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  height:
                                                                  1.3625 *
                                                                      ffem /
                                                                      fem,
                                                                  color:
                                                                  const Color(
                                                                      0xff030229),
                                                                  textStyle: const TextStyle(
                                                                      overflow: TextOverflow
                                                                          .ellipsis
                                                                  )
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width / 7.2,
                                                      height: height / 14.78,
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Container(
                                                              height: height /
                                                                  21.7,
                                                              width: width /
                                                                  45.533,
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  14.34 * fem,
                                                                  0 * fem),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    19.5553703308 *
                                                                        fem),
                                                                image:
                                                                DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(
                                                                      _userdata[
                                                                      'UserImg']
                                                                          .toString()),
                                                                ),
                                                              ),
                                                              child: Center(
                                                                  child: _userdata['UserImg']
                                                                      .toString() ==
                                                                      ""
                                                                      ? const Icon(
                                                                      Icons
                                                                          .person)
                                                                      : const Text("")
                                                              )
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                0 * fem,
                                                                4.14 * fem,
                                                                129.49 * fem,
                                                                0 * fem),
                                                            child: KText(
                                                              text: "${_userdata['Name']} ${_userdata['lastName']}",
                                                              style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize: 18 *
                                                                      ffem,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  height:
                                                                  1.3625 *
                                                                      ffem /
                                                                      fem,
                                                                  color:
                                                                  const Color(
                                                                      0xff030229),
                                                                  textStyle: const TextStyle(
                                                                      overflow: TextOverflow
                                                                          .ellipsis
                                                                  )
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height / 14.78,
                                                      width: width / 6.2,
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          KText(
                                                            text: _userdata['email'],
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: 18 *
                                                                  ffem,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              height: 1.3625 *
                                                                  ffem / fem,
                                                              color: const Color(
                                                                  0xff030229),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height / 14.78,
                                                      width: width / 7.2,
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          KText(
                                                            text: _userdata['Phone']
                                                                .toString(),
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: 18 *
                                                                  ffem,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              height: 1.3625 *
                                                                  ffem / fem,
                                                              color: const Color(
                                                                  0xff030229),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width / 10,
                                                      height: height / 14.78,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .only(
                                                            left: width / 54.64,
                                                            right: width /
                                                                54.64),
                                                        child: Container(
                                                          width: width / 34.15,
                                                          height: double
                                                              .infinity,
                                                          decoration: BoxDecoration(
                                                            color:
                                                            _userdata['Gender'] ==
                                                                "Male"
                                                                ? const Color(
                                                                0x195b92ff)
                                                                : const Color(
                                                                0xffFEF3F0),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                33 * fem),
                                                          ),
                                                          child: Center(
                                                            child: KText(
                                                              text: _userdata['Gender'],
                                                              style: SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize: 16 *
                                                                    ffem,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                height:
                                                                1.3625 * ffem /
                                                                    fem,
                                                                color: _userdata[
                                                                'Gender'] ==
                                                                    "Male"
                                                                    ? const Color(
                                                                    0xff5b92ff)
                                                                    : const Color(
                                                                    0xffFE8F6B),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height / 14.78,
                                                      width: width / 11.5,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SizedBox(
                                                              width: width /
                                                                  54.64),
                                                          Container(
                                                            // gender8qf (8:2320)
                                                              margin:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  15.18 * fem,
                                                                  0 * fem),
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: 5),
                                                              child: _userdata['verifyed'] ==
                                                                  true
                                                                  ? const Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .verified,
                                                                  color:
                                                                  Colors.green,
                                                                ),
                                                              )
                                                                  : const Icon(
                                                                Icons
                                                                    .verified_outlined,
                                                              )
                                                          ),
                                                          Opacity(
                                                            // arrowdown5rFs (8:2318)
                                                            opacity: 0.0,
                                                            child: Container(
                                                              margin:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                  0 * fem,
                                                                  1.6 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                              width: 7.82 * fem,
                                                              height: 6.52 *
                                                                  fem,
                                                              child: Image
                                                                  .asset(
                                                                'assets/images/arrow-down-5.png',
                                                                width: 7.82 *
                                                                    fem,
                                                                height: 6.52 *
                                                                    fem,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height / 14.78,
                                                      width: width / 11,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SizedBox(
                                                              width: width /
                                                                  54.64),
                                                          Container(
                                                            // gender8qf (8:2320)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                0 * fem,
                                                                0 * fem,
                                                                15.18 * fem,
                                                                0 * fem),
                                                            child: Center(
                                                              child: KText(
                                                                text: _userdata['yearofpassed'],
                                                                style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize: 16 *
                                                                      ffem,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  height:
                                                                  1.3625 *
                                                                      ffem /
                                                                      fem,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Opacity(
                                                            // arrowdown5rFs (8:2318)
                                                            opacity: 0.0,
                                                            child: Container(
                                                              margin:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                  0 * fem,
                                                                  1.6 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                              width: 7.82 * fem,
                                                              height: 6.52 *
                                                                  fem,
                                                              child: Image
                                                                  .asset(
                                                                'assets/images/arrow-down-5.png',
                                                                width: 7.82 *
                                                                    fem,
                                                                height: 6.52 *
                                                                    fem,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Popupmenu(context,
                                                            _userdata.id,
                                                            popMenuKeys[index]);
                                                        print(viewUser_details);
                                                      },
                                                      child: SizedBox(

                                                          key: popMenuKeys[index],
                                                          width: width / 9.98,
                                                          height: height /
                                                              26.04,
                                                          child: const Icon(
                                                              Icons
                                                                  .more_horiz)),
                                                    ),
                                                    /*GestureDetector(
                                                            onTap: () {
                                                              // setState(() {
                                                              //   viewDocid=_userdata.id;
                                                              //   viewUser_details=!viewUser_details;
                                                              // });
                                                              Popupmenu(context, _userdata.id);
                                                              print(viewUser_details);
                                                            },
                                                            child: Container(
                                                                key: popmenukey,
                                                                color:Colors.red,
                                                                width: width / 14.0,
                                                                height: height / 26.04,
                                                                child: Icon(Icons.more_horiz)),
                                                          ),*/
                                                  ],
                                                ),
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                        ),
                                      ),
                                     /* SizedBox(
                                        width:width/1.7075,
                                        child: NumberPaginator(
                                          config: NumberPaginatorUIConfig(
                                            buttonSelectedBackgroundColor: Constants()
                                                .primaryAppColor,
                                            buttonSelectedForegroundColor: Colors
                                                .white,
                                          ),
                                          numberPages: pagecount,
                                          onPageChange: (int index) async {
                                            setState(()  {
                                              documentList.addAll(snapshot.data!.docs);
                                              temp = index + 1;
                                            });
                                            print(documentList.length);
                                          },
                                        ),
                                      )*/
                                      Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            height:height/13.02,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemCount: pagecount ,
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
                                },
                              ):

                              //     Search one
                              StreamBuilder(
                                stream:
                                FirebaseFirestore.instance.collection("Users").snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasData == null) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Container(
                                    height: height / 1.136923,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      itemCount:pagecount == temp ? snapshot.data!.docs.length.remainder(10) == 0 ? 10 : snapshot.data!.docs.length.remainder(10) : 10 ,
                                      itemBuilder: (context, index) {
                                        var _userdata = snapshot.data!.docs[index];
                                        List<GlobalKey<State<StatefulWidget>>> popMenuKeys = List.generate(
                                          snapshot.data!.docs.length, (index) => GlobalKey(),);
                                        if(mydate.isNotEmpty){
                                          if(SerachValue != ""){
                                            if(mydate.contains(_userdata['date'].toString().toLowerCase())){
                                              if (_userdata['Name']
                                                  .toString()
                                                  .toLowerCase()
                                                  .startsWith(
                                                  SerachValue.toLowerCase())||
                                                  _userdata['Phone']
                                                      .toString()
                                                      .toLowerCase()
                                                      .startsWith(
                                                      SerachValue.toLowerCase())||
                                                  _userdata['email']
                                                      .toString()
                                                      .toLowerCase()
                                                      .startsWith(
                                                      SerachValue.toLowerCase())
                                              ) {
                                                return Container(
                                                  padding: EdgeInsets.only(
                                                      left: width / 136.6),
                                                  width: width / 1.21,
                                                  height: 78.22 * fem,
                                                  decoration: BoxDecoration(
                                                    // color: Colors.pink,
                                                    color: const Color(
                                                        0xffffffff),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10 * fem),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: width / 7.2,
                                                        height: height / 14.78,
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            Container(
                                                                height: height /
                                                                    21.7,
                                                                width: width /
                                                                    45.533,
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    14.34 * fem,
                                                                    0 * fem),
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      19.5553703308 *
                                                                          fem),
                                                                  image:
                                                                  DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: NetworkImage(
                                                                        _userdata[
                                                                        'UserImg']
                                                                            .toString()),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                    child: _userdata['UserImg']
                                                                        .toString() ==
                                                                        ""
                                                                        ? const Icon(
                                                                        Icons
                                                                            .person)
                                                                        : const Text("")
                                                                )
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                   0 * fem,
                                                                   4.14 * fem,
                                                                   129.49 * fem,
                                                                   0 * fem
                                                              ),
                                                              child: KText(
                                                                text: "${_userdata['Name']} ${_userdata['lastName']}",
                                                                style: SafeGoogleFont(
                                                                    'Nunito',
                                                                    fontSize: 18 *
                                                                        ffem,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    height:
                                                                    1.3625 *
                                                                        ffem /
                                                                        fem,
                                                                    color:
                                                                    const Color(
                                                                        0xff030229),
                                                                    textStyle: const TextStyle(
                                                                        overflow: TextOverflow
                                                                            .ellipsis
                                                                    )
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height / 14.78,
                                                        width: width / 6.2,
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            KText(
                                                              text: _userdata['email'],
                                                              style: SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize: 18 *
                                                                    ffem,
                                                                fontWeight: FontWeight
                                                                    .w400,
                                                                height: 1.3625 *
                                                                    ffem / fem,
                                                                color: const Color(
                                                                    0xff030229),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height / 14.78,
                                                        width: width / 7.2,
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            KText(
                                                              text: _userdata['Phone']
                                                                  .toString(),
                                                              style: SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize: 18 *
                                                                    ffem,
                                                                fontWeight: FontWeight
                                                                    .w400,
                                                                height: 1.3625 *
                                                                    ffem / fem,
                                                                color: const Color(
                                                                    0xff030229),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width / 10,
                                                        height: height / 14.78,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .only(
                                                              left: width / 54.64,
                                                              right: width /
                                                                  54.64),
                                                          child: Container(
                                                            width: width / 34.15,
                                                            height: double
                                                                .infinity,
                                                            decoration: BoxDecoration(
                                                              color:
                                                              _userdata['Gender'] ==
                                                                  "Male"
                                                                  ? const Color(
                                                                  0x195b92ff)
                                                                  : const Color(
                                                                  0xffFEF3F0),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  33 * fem),
                                                            ),
                                                            child: Center(
                                                              child: KText(
                                                                text: _userdata['Gender'],
                                                                style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize: 16 *
                                                                      ffem,
                                                                  fontWeight:
                                                                  FontWeight.w400,
                                                                  height:
                                                                  1.3625 * ffem /
                                                                      fem,
                                                                  color: _userdata[
                                                                  'Gender'] ==
                                                                      "Male"
                                                                      ? const Color(
                                                                      0xff5b92ff)
                                                                      : const Color(
                                                                      0xffFE8F6B),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height / 14.78,
                                                        width: width / 11.5,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            SizedBox(
                                                                width: width /
                                                                    54.64),
                                                            Container(
                                                              // gender8qf (8:2320)
                                                                margin:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    15.18 * fem,
                                                                    0 * fem),
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 5),
                                                                child: _userdata['verifyed'] ==
                                                                    true
                                                                    ? const Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .verified,
                                                                    color:
                                                                    Colors.green,
                                                                  ),
                                                                )
                                                                    : const Icon(
                                                                  Icons
                                                                      .verified_outlined,
                                                                )
                                                            ),
                                                            Opacity(
                                                              // arrowdown5rFs (8:2318)
                                                              opacity: 0.0,
                                                              child: Container(
                                                                margin:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                    0 * fem,
                                                                    1.6 * fem,
                                                                    0 * fem,
                                                                    0 * fem),
                                                                width: 7.82 * fem,
                                                                height: 6.52 *
                                                                    fem,
                                                                child: Image
                                                                    .asset(
                                                                  'assets/images/arrow-down-5.png',
                                                                  width: 7.82 *
                                                                      fem,
                                                                  height: 6.52 *
                                                                      fem,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height / 14.78,
                                                        width: width / 11,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            SizedBox(
                                                                width: width /
                                                                    54.64),
                                                            Container(
                                                              // gender8qf (8:2320)
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  15.18 * fem,
                                                                  0 * fem),
                                                              child: Center(
                                                                child: KText(
                                                                  text: _userdata['yearofpassed'],
                                                                  style: SafeGoogleFont(
                                                                    'Nunito',
                                                                    fontSize: 16 *
                                                                        ffem,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    height:
                                                                    1.3625 *
                                                                        ffem /
                                                                        fem,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Opacity(
                                                              // arrowdown5rFs (8:2318)
                                                              opacity: 0.0,
                                                              child: Container(
                                                                margin:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                    0 * fem,
                                                                    1.6 * fem,
                                                                    0 * fem,
                                                                    0 * fem),
                                                                width: 7.82 * fem,
                                                                height: 6.52 *
                                                                    fem,
                                                                child: Image
                                                                    .asset(
                                                                  'assets/images/arrow-down-5.png',
                                                                  width: 7.82 *
                                                                      fem,
                                                                  height: 6.52 *
                                                                      fem,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Popupmenu(context,
                                                              _userdata.id,
                                                              popMenuKeys[index]);
                                                          print(viewUser_details);
                                                        },
                                                        child: SizedBox(
                                                            key: popMenuKeys[index],
                                                            width: width / 9.98,
                                                            height: height /
                                                                26.04,
                                                            child: const Icon(
                                                                Icons
                                                                    .more_horiz)),
                                                      ),

                                                      /*GestureDetector(
                                                            onTap: () {
                                                              // setState(() {
                                                              //   viewDocid=_userdata.id;
                                                              //   viewUser_details=!viewUser_details;
                                                              // });
                                                              Popupmenu(context, _userdata.id);
                                                              print(viewUser_details);
                                                            },
                                                            child: Container(
                                                                key: popmenukey,
                                                                color:Colors.red,
                                                                width: width / 14.0,
                                                                height: height / 26.04,
                                                                child: Icon(Icons.more_horiz)),
                                                          ),*/

                                                    ],
                                                  ),
                                                );
                                              }
                                            }


                                          }
                                          else{
                                            if(mydate.contains(_userdata['date'].toString().toLowerCase())){
                                              return Container(
                                                padding: EdgeInsets.only(
                                                    left: width / 136.6),
                                                width: width / 1.21,
                                                height: 78.22 * fem,
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                      0xffffffff),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10 * fem),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: width / 7.2,
                                                      height: height / 14.78,
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Container(
                                                              height: height /
                                                                  21.7,
                                                              width: width /
                                                                  45.533,
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  14.34 * fem,
                                                                  0 * fem),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    19.5553703308 *
                                                                        fem),
                                                                image:
                                                                DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(
                                                                      _userdata[
                                                                      'UserImg']
                                                                          .toString()),
                                                                ),
                                                              ),
                                                              child: Center(
                                                                  child: _userdata['UserImg']
                                                                      .toString() ==
                                                                      ""
                                                                      ? const Icon(
                                                                      Icons
                                                                          .person)
                                                                      : const Text("")
                                                              )
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                0 * fem,
                                                                4.14 * fem,
                                                                129.49 * fem,
                                                                0 * fem),
                                                            child: KText(
                                                              text: "${_userdata['Name']} ${_userdata['lastName']}",
                                                              style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize: 18 *
                                                                      ffem,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  height:
                                                                  1.3625 *
                                                                      ffem /
                                                                      fem,
                                                                  color:
                                                                  const Color(
                                                                      0xff030229),
                                                                  textStyle: const TextStyle(
                                                                      overflow: TextOverflow
                                                                          .ellipsis
                                                                  )
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height / 14.78,
                                                      width: width / 6.2,
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          KText(
                                                            text: _userdata['email'],
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: 18 *
                                                                  ffem,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              height: 1.3625 *
                                                                  ffem / fem,
                                                              color: const Color(
                                                                  0xff030229),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height / 14.78,
                                                      width: width / 7.2,
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          KText(
                                                            text: _userdata['Phone']
                                                                .toString(),
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: 18 *
                                                                  ffem,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              height: 1.3625 *
                                                                  ffem / fem,
                                                              color: const Color(
                                                                  0xff030229),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width / 10,
                                                      height: height / 14.78,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .only(
                                                            left: width / 54.64,
                                                            right: width /
                                                                54.64),
                                                        child: Container(
                                                          width: width / 34.15,
                                                          height: double
                                                              .infinity,
                                                          decoration: BoxDecoration(
                                                            color:
                                                            _userdata['Gender'] ==
                                                                "Male"
                                                                ? const Color(
                                                                0x195b92ff)
                                                                : const Color(
                                                                0xffFEF3F0),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                33 * fem),
                                                          ),
                                                          child: Center(
                                                            child: KText(
                                                              text: _userdata['Gender'],
                                                              style: SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize: 16 *
                                                                    ffem,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                height:
                                                                1.3625 * ffem /
                                                                    fem,
                                                                color: _userdata[
                                                                'Gender'] ==
                                                                    "Male"
                                                                    ? const Color(
                                                                    0xff5b92ff)
                                                                    : const Color(
                                                                    0xffFE8F6B),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height / 14.78,
                                                      width: width / 11.5,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SizedBox(
                                                              width: width /
                                                                  54.64),
                                                          Container(
                                                            // gender8qf (8:2320)
                                                              margin:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  15.18 * fem,
                                                                  0 * fem),
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: 5),
                                                              child: _userdata['verifyed'] ==
                                                                  true
                                                                  ? const Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .verified,
                                                                  color:
                                                                  Colors.green,
                                                                ),
                                                              )
                                                                  : const Icon(
                                                                Icons
                                                                    .verified_outlined,
                                                              )
                                                          ),
                                                          Opacity(
                                                            // arrowdown5rFs (8:2318)
                                                            opacity: 0.0,
                                                            child: Container(
                                                              margin:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                  0 * fem,
                                                                  1.6 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                              width: 7.82 * fem,
                                                              height: 6.52 *
                                                                  fem,
                                                              child: Image
                                                                  .asset(
                                                                'assets/images/arrow-down-5.png',
                                                                width: 7.82 *
                                                                    fem,
                                                                height: 6.52 *
                                                                    fem,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height / 14.78,
                                                      width: width / 11,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SizedBox(
                                                              width: width /
                                                                  54.64),
                                                          Container(
                                                            // gender8qf (8:2320)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                0 * fem,
                                                                0 * fem,
                                                                15.18 * fem,
                                                                0 * fem),
                                                            child: Center(
                                                              child: KText(
                                                                text: _userdata['yearofpassed'],
                                                                style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize: 16 *
                                                                      ffem,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  height:
                                                                  1.3625 *
                                                                      ffem /
                                                                      fem,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Opacity(
                                                            // arrowdown5rFs (8:2318)
                                                            opacity: 0.0,
                                                            child: Container(
                                                              margin:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                  0 * fem,
                                                                  1.6 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                              width: 7.82 * fem,
                                                              height: 6.52 *
                                                                  fem,
                                                              child: Image
                                                                  .asset(
                                                                'assets/images/arrow-down-5.png',
                                                                width: 7.82 *
                                                                    fem,
                                                                height: 6.52 *
                                                                    fem,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Popupmenu(context,
                                                            _userdata.id,
                                                            popMenuKeys[index]);
                                                        print(viewUser_details);
                                                      },
                                                      child: SizedBox(

                                                          key: popMenuKeys[index],
                                                          width: width / 9.98,
                                                          height: height /
                                                              26.04,
                                                          child: const Icon(
                                                              Icons
                                                                  .more_horiz)),
                                                    ),
                                                    /*GestureDetector(
                                                            onTap: () {
                                                              // setState(() {
                                                              //   viewDocid=_userdata.id;
                                                              //   viewUser_details=!viewUser_details;
                                                              // });
                                                              Popupmenu(context, _userdata.id);
                                                              print(viewUser_details);
                                                            },
                                                            child: Container(
                                                                key: popmenukey,
                                                                color:Colors.red,
                                                                width: width / 14.0,
                                                                height: height / 26.04,
                                                                child: Icon(Icons.more_horiz)),
                                                          ),*/
                                                  ],
                                                ),
                                              );
                                            }
                                          }

                                        }

                                        else if (SerachValue != "") {
                                          print("Validddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
                                          if (_userdata['Name'].toString().toLowerCase().startsWith(SerachValue.toLowerCase())||
                                              _userdata['Phone'].toString().toLowerCase().startsWith(SerachValue.toLowerCase())||
                                              _userdata['yearofpassed'].toString().toLowerCase().startsWith(SerachValue.toLowerCase())||
                                              _userdata['subjectStream'].toString().toLowerCase().startsWith(SerachValue.toLowerCase())||
                                              _userdata['email'].toString().toLowerCase().startsWith(SerachValue.toLowerCase())
                                          ) {
                                            return Container(
                                              padding: EdgeInsets.only(
                                                  left: width / 136.6),
                                              width: width / 1.21,
                                              height: 78.22 * fem,
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                    0xffffffff),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10 * fem),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: width / 7.2,
                                                    height: height / 14.78,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        Container(
                                                            height: height /
                                                                21.7,
                                                            width: width /
                                                                45.533,
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                0 * fem,
                                                                0 * fem,
                                                                14.34 * fem,
                                                                0 * fem),
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Colors
                                                                  .grey
                                                                  .shade300,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  19.5553703308 *
                                                                      fem),
                                                              image:
                                                              DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    _userdata[
                                                                    'UserImg']
                                                                        .toString()),
                                                              ),
                                                            ),
                                                            child: Center(
                                                                child: _userdata['UserImg']
                                                                    .toString() ==
                                                                    ""
                                                                    ? const Icon(
                                                                    Icons
                                                                        .person)
                                                                    : const Text("")
                                                            )
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                              0 * fem,
                                                              4.14 * fem,
                                                              129.49 * fem,
                                                              0 * fem),
                                                          child: KText(
                                                            text: "${_userdata['Name']} ${_userdata['lastName']}",
                                                            style: SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize: 18 *
                                                                    ffem,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400,
                                                                height:
                                                                1.3625 *
                                                                    ffem /
                                                                    fem,
                                                                color:
                                                                const Color(
                                                                    0xff030229),
                                                                textStyle: const TextStyle(
                                                                    overflow: TextOverflow
                                                                        .ellipsis
                                                                )
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height / 14.78,
                                                    width: width / 6.2,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        KText(
                                                          text: _userdata['email'],
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            fontSize: 18 *
                                                                ffem,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            height: 1.3625 *
                                                                ffem / fem,
                                                            color: const Color(
                                                                0xff030229),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height / 14.78,
                                                    width: width / 7.2,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        KText(
                                                          text: _userdata['Phone']
                                                              .toString(),
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            fontSize: 18 *
                                                                ffem,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            height: 1.3625 *
                                                                ffem / fem,
                                                            color: const Color(
                                                                0xff030229),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width / 10,
                                                    height: height / 14.78,
                                                    child: Padding(
                                                      padding: EdgeInsets
                                                          .only(
                                                          left: width / 54.64,
                                                          right: width /
                                                              54.64),
                                                      child: Container(
                                                        width: width / 34.15,
                                                        height: double
                                                            .infinity,
                                                        decoration: BoxDecoration(
                                                          color:
                                                          _userdata['Gender'] ==
                                                              "Male"
                                                              ? const Color(
                                                              0x195b92ff)
                                                              : const Color(
                                                              0xffFEF3F0),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              33 * fem),
                                                        ),
                                                        child: Center(
                                                          child: KText(
                                                            text: _userdata['Gender'],
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: 16 *
                                                                  ffem,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              height:
                                                              1.3625 * ffem /
                                                                  fem,
                                                              color: _userdata[
                                                              'Gender'] ==
                                                                  "Male"
                                                                  ? const Color(
                                                                  0xff5b92ff)
                                                                  : const Color(
                                                                  0xffFE8F6B),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height / 14.78,
                                                    width: width / 11.5,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SizedBox(
                                                            width: width /
                                                                54.64),
                                                        Container(
                                                          // gender8qf (8:2320)
                                                            margin:
                                                            EdgeInsets
                                                                .fromLTRB(
                                                                0 * fem,
                                                                0 * fem,
                                                                15.18 * fem,
                                                                0 * fem),
                                                            padding: const EdgeInsets
                                                                .only(
                                                                left: 5),
                                                            child: _userdata['verifyed'] ==
                                                                true
                                                                ? const Center(
                                                              child: Icon(
                                                                Icons
                                                                    .verified,
                                                                color:
                                                                Colors.green,
                                                              ),
                                                            )
                                                                : const Icon(
                                                              Icons
                                                                  .verified_outlined,
                                                            )
                                                        ),
                                                        Opacity(
                                                          // arrowdown5rFs (8:2318)
                                                          opacity: 0.0,
                                                          child: Container(
                                                            margin:
                                                            EdgeInsets
                                                                .fromLTRB(
                                                                0 * fem,
                                                                1.6 * fem,
                                                                0 * fem,
                                                                0 * fem),
                                                            width: 7.82 * fem,
                                                            height: 6.52 *
                                                                fem,
                                                            child: Image
                                                                .asset(
                                                              'assets/images/arrow-down-5.png',
                                                              width: 7.82 *
                                                                  fem,
                                                              height: 6.52 *
                                                                  fem,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height / 14.78,
                                                    width: width / 11,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SizedBox(
                                                            width: width /
                                                                54.64),
                                                        Container(
                                                          // gender8qf (8:2320)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              15.18 * fem,
                                                              0 * fem),
                                                          child: Center(
                                                            child: KText(
                                                              text: _userdata['yearofpassed'],
                                                              style: SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize: 16 *
                                                                    ffem,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400,
                                                                height:
                                                                1.3625 *
                                                                    ffem /
                                                                    fem,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Opacity(
                                                          // arrowdown5rFs (8:2318)
                                                          opacity: 0.0,
                                                          child: Container(
                                                            margin:
                                                            EdgeInsets
                                                                .fromLTRB(
                                                                0 * fem,
                                                                1.6 * fem,
                                                                0 * fem,
                                                                0 * fem),
                                                            width: 7.82 * fem,
                                                            height: 6.52 *
                                                                fem,
                                                            child: Image
                                                                .asset(
                                                              'assets/images/arrow-down-5.png',
                                                              width: 7.82 *
                                                                  fem,
                                                              height: 6.52 *
                                                                  fem,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Popupmenu(context,
                                                          _userdata.id,
                                                          popMenuKeys[index]);
                                                      print(viewUser_details);
                                                    },
                                                    child: SizedBox(

                                                        key: popMenuKeys[index],
                                                        width: width / 9.98,
                                                        height: height /
                                                            26.04,
                                                        child: const Icon(
                                                            Icons
                                                                .more_horiz)),
                                                  ),
                                                  /*GestureDetector(
                                                            onTap: () {
                                                              // setState(() {
                                                              //   viewDocid=_userdata.id;
                                                              //   viewUser_details=!viewUser_details;
                                                              // });
                                                              Popupmenu(context, _userdata.id);
                                                              print(viewUser_details);
                                                            },
                                                            child: Container(
                                                                key: popmenukey,
                                                                color:Colors.red,
                                                                width: width / 14.0,
                                                                height: height / 26.04,
                                                                child: Icon(Icons.more_horiz)),
                                                          ),*/
                                                ],
                                              ),
                                            );
                                          }
                                        }
                                        else if(SerachValue==""){
                                          return Container(
                                            padding: EdgeInsets.only(
                                                left: width / 136.6),
                                            width: width / 1.21,
                                            height: 78.22 * fem,
                                            decoration: BoxDecoration(
                                              color: const Color(
                                                  0xffffffff),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10 * fem),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width / 7.2,
                                                  height: height / 14.78,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Container(
                                                          height: height /
                                                              21.7,
                                                          width: width /
                                                              45.533,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              14.34 * fem,
                                                              0 * fem),
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Colors
                                                                .grey
                                                                .shade300,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                19.5553703308 *
                                                                    fem),
                                                            image:
                                                            DecorationImage(
                                                              fit: BoxFit
                                                                  .cover,
                                                              image: NetworkImage(
                                                                  _userdata[
                                                                  'UserImg']
                                                                      .toString()),
                                                            ),
                                                          ),
                                                          child: Center(
                                                              child: _userdata['UserImg']
                                                                  .toString() ==
                                                                  ""
                                                                  ? const Icon(
                                                                  Icons
                                                                      .person)
                                                                  : const Text("")
                                                          )
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .fromLTRB(
                                                            0 * fem,
                                                            4.14 * fem,
                                                            129.49 * fem,
                                                            0 * fem),
                                                        child: KText(
                                                          text: "${_userdata['Name']} ${_userdata['lastName']}",
                                                          style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: 18 *
                                                                  ffem,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              height:
                                                              1.3625 *
                                                                  ffem /
                                                                  fem,
                                                              color:
                                                              const Color(
                                                                  0xff030229),
                                                              textStyle: const TextStyle(
                                                                  overflow: TextOverflow
                                                                      .ellipsis
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height / 14.78,
                                                  width: width / 6.2,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      KText(
                                                        text: _userdata['email'],
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: 18 *
                                                              ffem,
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          height: 1.3625 *
                                                              ffem / fem,
                                                          color: const Color(
                                                              0xff030229),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height / 14.78,
                                                  width: width / 7.2,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      KText(
                                                        text: _userdata['Phone']
                                                            .toString(),
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: 18 *
                                                              ffem,
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          height: 1.3625 *
                                                              ffem / fem,
                                                          color: const Color(
                                                              0xff030229),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 10,
                                                  height: height / 14.78,
                                                  child: Padding(
                                                    padding: EdgeInsets
                                                        .only(
                                                        left: width / 54.64,
                                                        right: width /
                                                            54.64),
                                                    child: Container(
                                                      width: width / 34.15,
                                                      height: double
                                                          .infinity,
                                                      decoration: BoxDecoration(
                                                        color:
                                                        _userdata['Gender'] ==
                                                            "Male"
                                                            ? const Color(
                                                            0x195b92ff)
                                                            : const Color(
                                                            0xffFEF3F0),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            33 * fem),
                                                      ),
                                                      child: Center(
                                                        child: KText(
                                                          text: _userdata['Gender'],
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            fontSize: 16 *
                                                                ffem,
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            height:
                                                            1.3625 * ffem /
                                                                fem,
                                                            color: _userdata[
                                                            'Gender'] ==
                                                                "Male"
                                                                ? const Color(
                                                                0xff5b92ff)
                                                                : const Color(
                                                                0xffFE8F6B),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height / 14.78,
                                                  width: width / 11.5,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      SizedBox(
                                                          width: width /
                                                              54.64),
                                                      Container(
                                                        // gender8qf (8:2320)
                                                          margin:
                                                          EdgeInsets
                                                              .fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              15.18 * fem,
                                                              0 * fem),
                                                          padding: const EdgeInsets
                                                              .only(
                                                              left: 5),
                                                          child: _userdata['verifyed'] ==
                                                              true
                                                              ? const Center(
                                                            child: Icon(
                                                              Icons
                                                                  .verified,
                                                              color:
                                                              Colors.green,
                                                            ),
                                                          )
                                                              : const Icon(
                                                            Icons
                                                                .verified_outlined,
                                                          )
                                                      ),
                                                      Opacity(
                                                        // arrowdown5rFs (8:2318)
                                                        opacity: 0.0,
                                                        child: Container(
                                                          margin:
                                                          EdgeInsets
                                                              .fromLTRB(
                                                              0 * fem,
                                                              1.6 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                          width: 7.82 * fem,
                                                          height: 6.52 *
                                                              fem,
                                                          child: Image
                                                              .asset(
                                                            'assets/images/arrow-down-5.png',
                                                            width: 7.82 *
                                                                fem,
                                                            height: 6.52 *
                                                                fem,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height / 14.78,
                                                  width: width / 11,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      SizedBox(
                                                          width: width /
                                                              54.64),
                                                      Container(
                                                        // gender8qf (8:2320)
                                                        margin: EdgeInsets
                                                            .fromLTRB(
                                                            0 * fem,
                                                            0 * fem,
                                                            15.18 * fem,
                                                            0 * fem),
                                                        child: Center(
                                                          child: KText(
                                                            text: _userdata['yearofpassed'],
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: 16 *
                                                                  ffem,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              height:
                                                              1.3625 *
                                                                  ffem /
                                                                  fem,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Opacity(
                                                        // arrowdown5rFs (8:2318)
                                                        opacity: 0.0,
                                                        child: Container(
                                                          margin:
                                                          EdgeInsets
                                                              .fromLTRB(
                                                              0 * fem,
                                                              1.6 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                          width: 7.82 * fem,
                                                          height: 6.52 *
                                                              fem,
                                                          child: Image
                                                              .asset(
                                                            'assets/images/arrow-down-5.png',
                                                            width: 7.82 *
                                                                fem,
                                                            height: 6.52 *
                                                                fem,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Popupmenu(context,
                                                        _userdata.id,
                                                        popMenuKeys[index]);
                                                    print(viewUser_details);
                                                  },
                                                  child: SizedBox(

                                                      key: popMenuKeys[index],
                                                      width: width / 9.98,
                                                      height: height /
                                                          26.04,
                                                      child: const Icon(
                                                          Icons
                                                              .more_horiz)),
                                                ),
                                                /*GestureDetector(
                                                            onTap: () {
                                                              // setState(() {
                                                              //   viewDocid=_userdata.id;
                                                              //   viewUser_details=!viewUser_details;
                                                              // });
                                                              Popupmenu(context, _userdata.id);
                                                              print(viewUser_details);
                                                            },
                                                            child: Container(
                                                                key: popmenukey,
                                                                color:Colors.red,
                                                                width: width / 14.0,
                                                                height: height / 26.04,
                                                                child: Icon(Icons.more_horiz)),
                                                          ),*/
                                              ],
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                  );
                                },
                              ),



                            ],
                          ),
                        ),
                        Loading == true ?
                        SizedBox(
                          height: height / 2.38,
                          width: width / 5.106,
                          child: Column(
                            children: [
                              Lottie.asset("assets/FsRGzkbt6x.json",
                                height: height / 3.38,
                                width: width / 6.106,),
                              Text("Please Wait", style: SafeGoogleFont(
                                  'Nunito', fontWeight: FontWeight.w600,
                                  color: Colors.black))
                            ],
                          ),
                        ) : const SizedBox(),
                      ]
                  )
              ),
            ),
            SizedBox(height: height / 65.1),
            DeveloperCardWidget(),
            SizedBox(height: height / 65.1),
          ],
        ),
      ),
    );
  }

  ///select the city functions----------------------
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

  ///clear controller functions--------------------------------
  Popupmenu(BuildContext context, _userid, key) async {
    print(
        "Popupmenu open-----------------------------------------------------------");
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    final render = key.currentContext!.findRenderObject() as RenderBox;
    await showMenu(
      color: const Color(0xffFFFFFF),
      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(
          render
              .localToGlobal(Offset.zero)
              .dx,
          render
              .localToGlobal(Offset.zero)
              .dy + 50,
          double.infinity,
          double.infinity),
      items: usereditlist
          .map((item) =>
          PopupMenuItem<String>(
            enabled: true,
            onTap: () async {
              setState(() {
                userUpdateDocumentID = _userid;
              });
              if (item == "Edit") {
                setState(() {
                  UserEdit = !UserEdit;
                  docid=_userid;
                });
                //fetchdate(_userid);
              } else if (item == "Delete") {
                userDetelePopup();
              }else if (item == "View") {
                viewPopup(userUpdateDocumentID);
              }
            },
            value: item,
            child: Container(
              height: height / 18.475,
              decoration: BoxDecoration(
                  color: item == "Edit"
                      ? const Color(0xff5B93FF).withOpacity(0.6): item == "View"
                      ? Colors.green.withOpacity(0.6)
                      : const Color(0xffE71D36).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Here it is for the edit, view, delete (User)
                  item == "Edit"
                      ? const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ): item == "View"
                      ? Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.white,
                    size: 18,
                  )
                      : const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ))
          .toList(),
    );
  }
  viewPopup(String userUpdateDocumentID) async {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
    await FirebaseFirestore.instance.collection("Users").doc(userUpdateDocumentID).get();

    Map<String, dynamic>? userData = userSnapshot.data();

    return showDialog(
      context: context,
      builder: (ctx) {
        if (userData == null) {
          // Handle the case where user data is not found
          return AlertDialog(
            // Your error handling UI or message can go here
            // ...
          );
        }

        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            width: size.width * 0.5,
            margin: EdgeInsets.symmetric(horizontal: width / 68.3, vertical: height / 32.55),
            decoration: BoxDecoration(
              color: Constants().primaryAppColor,
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
              children: [
                SizedBox(
                  height: size.height * 0.1,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 68.3, vertical: height / 81.375),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "User details",
                          style: SafeGoogleFont('Poppins',
                              fontSize: width / 78.3,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: height / 16.275,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: width / 227.66),
                              child: Center(
                                child: KText(
                                  text: "CLOSE",
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: width / 105.375,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
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
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: size.width * 0.5,
                            height: size.height * 0.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                                image: NetworkImage(userData['UserImg']),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: width / 136.6, vertical: height / 65.1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(height: height / 32.55),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.15,
                                        child: KText(
                                          text: "Name",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600, fontSize: width / 95.375),
                                        ),
                                      ),
                                      Text(":"),
                                      SizedBox(width: width / 68.3),
                                      KText(
                                        text: userData['Name'],
                                        style: SafeGoogleFont('Poppins', fontSize: width / 105.571),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height / 32.55),
                                  // Continue displaying other user details in a similar manner
                                  // ...

                                  SizedBox(height: height / 32.55),
                                  InkWell(
                                    onTap: () {
                                      // Your logic goes here
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: height / 16.275,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(1, 2),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: width / 227.66),
                                        child: Center(
                                          child: KText(
                                            text: "Close",
                                            style: SafeGoogleFont(
                                              'Poppins',
                                              fontSize: width / 105.375,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 32.55),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }






  /// Delete Fucntion ------------------------------------
  userDetelePopup() {
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
                      KText(text: "Are You Sure Want to Delete User", style:
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
                        child: SvgPicture.asset(Constants().deleteUserSvg),
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
                              userDeteleFunction();
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

  userDeteleFunction() {
    FirebaseFirestore.instance.collection("Users")
        .doc(userUpdateDocumentID)
        .delete();
  }



  filterPopUp() {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              height: size.height * 0.4,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                color: Constants().primaryAppColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.07,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: width / 68.3),
                          child: KText(
                            text: "Filter",
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: width / 95.375,
                              fontWeight: FontWeight.bold,
                              color:Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 68.3, vertical: height / 32.55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: width / 15.177,
                                child: KText(
                                  text: "Start Date",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: width / 105.571,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: width / 85.375),
                              Container(
                                height: height / 16.275,
                                width: width / 15.177,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 3,
                                      offset: Offset(2, 3),
                                    )
                                  ],
                                ),
                                child: TextField(
                                  readOnly: true,
                                  controller:Date1Controller,
                                  decoration: InputDecoration(
                                    hintStyle: SafeGoogleFont('Nunito',
                                        color: const Color(0xff00A99D)),
                                    border: InputBorder.none,
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(3000));
                                    if (pickedDate != null) {
                                      setState(() {
                                        dateRangeStart = pickedDate;
                                        Date1Controller.text=DateFormat('d/M/yyyy').format(pickedDate);
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width / 15.177,
                                child: KText(
                                  text: "End Date",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: width / 105.571,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: width / 85.375),
                              Container(
                                height: height / 16.275,
                                width: width / 15.177,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 3,
                                      offset: Offset(2, 3),
                                    )
                                  ],
                                ),
                                child: TextField(
                                    readOnly: true,
                                    controller:Date2Controller,
                                    decoration: InputDecoration(
                                      hintStyle: SafeGoogleFont('Nunito',
                                          color: const Color(0xff00A99D)),

                                      border: InputBorder.none,
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(3000));
                                      if (pickedDate != null) {
                                        setState(() {
                                          Date2Controller.text=DateFormat('d/M/yyyy').format(pickedDate);
                                          dateRangeEnd = pickedDate;
                                        });
                                        DateTime startDate = DateTime.utc(dateRangeStart!.year, dateRangeStart!.month, dateRangeStart!.day);
                                        DateTime endDate = DateTime.utc(dateRangeEnd!.year, dateRangeEnd!.month, dateRangeEnd!.day);
                                        print(startDate);
                                        print(endDate);
                                        print("+++++++=================");
                                        getDaysInBetween() {
                                          final int difference = endDate.difference(startDate).inDays;
                                          return difference + 1;
                                        }


                                        final items = List<DateTime>.generate(
                                            getDaysInBetween(), (i) {
                                          DateTime date = startDate;
                                          return date.add(Duration(days: i));
                                        });
                                        setState(() {
                                          mydate.clear();
                                        });
                                        print(items.length);
                                        for (int i = 0; i < items.length; i++) {
                                          setState(() {
                                            mydate.add(formatter
                                                .format(items[i])
                                                .toString());
                                          });
                                          print(mydate);
                                          print("+++++++++++++000000000+++++++++++");
                                        }
                                      }
                                    }),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState((){
                                    Date1Controller.clear();
                                    Date2Controller.clear();
                                  });
                                  Navigator.pop(context, false);
                                },
                                child: Container(
                                  height: height / 16.275,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(1, 2),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 227.66),
                                    child: Center(
                                      child: KText(
                                        text: "Cancel",
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width / 105.375,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: width / 273.2),
                              InkWell(
                                onTap: () {
                                  setState((){
                                    Date1Controller.clear();
                                    Date2Controller.clear();
                                  });
                                  Navigator.pop(context, true);
                                },
                                child: Container(
                                  height: height / 16.275,
                                  decoration: BoxDecoration(
                                    color: Constants().primaryAppColor,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(1, 2),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 227.66),
                                    child: Center(
                                      child: KText(
                                        text: "Apply",
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width / 105.375,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
  TextEditingController FilterController = new TextEditingController();

  shortBydataPopUp(Name,context) async {
    setState((){
      FilterController.text="Select ${Name}";
      SerachValue="";
    });
    if(Name=="Department"){
      print("Department Data List+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      setState(() {
        FilterDataList.clear();
      });
      setState(() {
        FilterDataList.add('Select Department');
      });
      var departmentdata = await FirebaseFirestore.instance.collection("Department").orderBy("name").get();
      for (int x = 0; x < departmentdata.docs.length; x++) {
        setState(() {
          FilterDataList.add(departmentdata.docs[x]['name'].toString());
        });
      }
      print("department Data List $FilterDataList");

    }
    else{
      setState(() {
        FilterDataList.clear();
      });
      setState(() {
        FilterDataList.add('Select Year');
      });
      var acdamicYeardata = await FirebaseFirestore.instance.collection("AcademicYear").orderBy("name").get();
      for (int x = 0; x < acdamicYeardata.docs.length; x++) {
        setState(() {
          FilterDataList.add(acdamicYeardata.docs[x]['name'].toString());
        });
      }
      print("Year Data List $FilterDataList");
    }
    print("list of Data_____________________________________________");
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return
      showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setState) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              height: size.height * 0.4,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                color: Constants().primaryAppColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.07,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: width / 68.3),
                          child: KText(
                            text: "Filter by ${Name}",
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: width / 95.375,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 68.3, vertical: height / 32.55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: width / 14.8,
                                child: KText(
                                  text: "Please Select : ",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: width / 105.571,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: width / 85.375),
                              Container(
                                height: height / 16.275,
                                width: width / 8.177,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 3,
                                      offset: Offset(2, 3),
                                    )
                                  ],
                                ),
                                child:
                                DropdownButtonHideUnderline(
                                  child:
                                  DropdownButtonFormField2<
                                      String>(
                                    isExpanded: true,
                                    hint: Text('Select ${Name}',
                                      style:
                                      SafeGoogleFont(
                                        'Nunito',
                                        fontSize: width / 90.571,
                                      ),
                                    ),
                                    items: FilterDataList.map((String
                                    item) => DropdownMenuItem<String>(
                                      value: item,
                                          child: Text(item, style: SafeGoogleFont('Nunito', fontSize: width / 90.571,),),)).toList(),
                                    value: FilterController.text,
                                    onChanged: (String?
                                    value) {
                                      setState(() {
                                        FilterController.text = value!;
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
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState((){
                                    FilterDataValue="";
                                  });
                                  Navigator.pop(context, false);
                                },
                                child: Container(
                                  height: height / 16.275,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(1, 2),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 227.66),
                                    child: Center(
                                      child: KText(
                                        text: "Cancel",
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width / 105.375,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: width / 273.2),
                              InkWell(
                                onTap: () {
                                  setState((){
                                    SerachValue=FilterController.text;
                                  });
                                  print(SerachValue);
                                  print("Heloeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                                  Navigator.pop(context, true);
                                },
                                child: Container(
                                  height: height / 16.275,
                                  decoration: BoxDecoration(
                                    color: Constants().primaryAppColor,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(1, 2),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 227.66),
                                    child: Center(
                                      child: KText(
                                        text: "Apply",
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width / 105.375,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }







}

class Location {
  String name;
  String district;
  String region;
  String state;

  Location(this.name, this.district, this.region, this.state);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        json['Name'], json['District'], json['Region'], json['State']);
  }
}

class menuItem {
  Widget? widgets;
  String? Name;

  menuItem({this.widgets, this.Name});
}
