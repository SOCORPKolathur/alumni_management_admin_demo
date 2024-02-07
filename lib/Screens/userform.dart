import 'dart:convert';
import 'dart:math';
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


class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
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

class _UserFormState extends State<UserForm> {
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

  ///dropdown validator values
  bool dropdownValidator = false;
  bool dropdownValidator2 = false;
  bool dropdownValidator3 = false;
  bool dropdownDepartmentValidator = false;
  bool genderValidator = false;

  ///Text Controller validator boolean Value
  bool firstNameValidator = false;
  bool lastNameValidator = false;
  bool dobValidator = false;
  bool yearPassedValidator = false;
  bool classValidator = false;
  bool myStatusValidator = false;
  bool pincodeValidator = false;
  bool prefixValidator = true;


  userCounta() async {
    var user = await FirebaseFirestore.instance.collection("Users").get();
    setState(() {
      billcount = user.docs.length + 1;
    });
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
  }

  bool Loading = false;


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

  controllersclearfunc() {
    setState(() {
      Loading = false;
      firstNamecon.clear();
      middleNamecon.clear();
      lastNamecon.clear();
      dateofBirthcon.clear();
      gendercon.clear();
      alterEmailIdcon.clear();
      aadhaarNumbercon.clear();
      phoneNumbercon.clear();
      mobileNumbercon.clear();
      emailIDcon.clear();
      adreesscon.clear();
      citycon.text = "Select City";
      pinCodecon.clear();
      statecon.text = "Select State";
      countrycon.text = "Select Country";
      yearPassedcon.clear();
      subjectStremdcon.text = "Select Department";
      //ownBussinesscon.clear();
      classcon.clear();
      rollnocon.clear();
      lastvisitcon.clear();
      housecon.clear();
      statusmessagecon.clear();
      educationquvalificationcon.clear();
      additionalquvalificationcon.clear();
      occupationcon.clear();
      designationcon.clear();
      company_concerncon.clear();
      maritalStatuscon.text = "Marital Status";
      alumniEmployedController.text = "No";
      spouseNamecon.clear();
      anniversaryDatecon.clear();
      no_of_childreancon.clear();
      Uploaddocument = null;
      imgUrl = "";
      materialStatusCheck = false;
      dropdownValidator = false;
      dropdownValidator2 = false;
      dropdownValidator3 = false;
      dropdownDepartmentValidator = false;
      userUpdateDocumentID = "";
    });
  }

  ///choose the image fundtions------------------------'\

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
                });
                fetchdate(_userid);
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


  fetchdate(id) async {
    var document =
    await FirebaseFirestore.instance.collection("Users").doc(id).get();
    Map<String, dynamic>? value = document.data();
    getCity(value!['state'].toString());
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
      statecon.text = value['state'].toString();
      citycon.text = value['city'].toString();
      pinCodecon.text = value['pinCode'].toString();
      countrycon.text = value['country'].toString();
      yearPassedcon.text = value['yearofpassed'].toString();
      subjectStremdcon.text = value['subjectStream'].toString();
      classcon.text = value['class'].toString();
      rollnocon.text = value['rollNo'].toString();
      lastvisitcon.text = value['lastvisit'].toString();
      housecon.text = value['house'].toString();
      statusmessagecon.text = value['statusmessage'].toString();
      educationquvalificationcon.text =
          value['educationquvalification'].toString();
      additionalquvalificationcon.text =
          value['additionalquvalification'].toString();
      designationcon.text = value['designation'].toString();
      company_concerncon.text = value['company_concern'].toString();
      maritalStatuscon.text = value['maritalStatus'].toString();
      spouseNamecon.text = value['spouseName'].toString();
      anniversaryDatecon.text = value['anniversaryDate'].toString();
      no_of_childreancon.text = value['childreancount'].toString();
      imgUrl = value['UserImg'].toString();
      alumniEmployedController.text = value['workingStatus'].toString();
      // ownBussinesscon.text=value['Ownbusiness'].toString();
    });

    print("Sate Controller +++++++++++++++++++++++++++++++++++++++++++");
    print(statecon.text);
    print("++++++++++++++++++++++++++++++++++++++++++++");
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  userdatecreatefunc() async {
    setState(() {
      Loading = true;
    });
    print("Craete Funtion Entered+++++++++++++++++++++++++++");
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
        "Address": adreesscon.text,
        "Gender": gendercon.text,
        "Name": firstNamecon.text,
        "middleName": middleNamecon.text,
        "lastName": lastNamecon.text,
        "Occupation": occupationcon.text,
        "Phone": phoneNumbercon.text,
        "UserImg": imgUrl,
        "lastchat": "",
        "verifyed": false,
        "dob": dateofBirthcon.text,
        "alteremail": alterEmailIdcon.text,
        "aadhaarNo": aadhaarNumbercon.text,
        "mobileNo": mobileNumbercon.text,
        "email": emailIDcon.text,
        "city": citycon.text,
        "pinCode": pinCodecon.text,
        "state": statecon.text,
        "country": countrycon.text,
        "yearofpassed": yearPassedcon.text,
        "subjectStream": subjectStremdcon.text,
        "class": classcon.text,
        "rollNo": rollnocon.text,
        "lastvisit": lastvisitcon.text,
        "house": housecon.text,
        "statusmessage": statusmessagecon.text,
        "educationquvalification": educationquvalificationcon.text,
        "additionalquvalification": additionalquvalificationcon.text,
        "designation": designationcon.text,
        "company_concern": company_concerncon.text,
        "maritalStatus": maritalStatuscon.text,
        "spouseName": spouseNamecon.text,
        "anniversaryDate": anniversaryDatecon.text,
        "childreancount": no_of_childreancon.text,
        // "Ownbusiness": ownBussinesscon.text,
        "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "timestamp": DateTime
            .now()
            .millisecondsSinceEpoch,
        "userDocId": userid,
        "Active": false,
        "Editted":false,
        "Token": "",
        "longtitude": 0,
        "latitude": 0,
        'workingStatus': alumniEmployedController.text,
        "regno": "Al${(billcount).toString().padLeft(2, "0")}"
      });
      setState(() {
        Useradd = false;
      });
    }
    else {
      print("Else Fucntion_+++++++++++++++++++++++++++++++++++++++++++++");
      FirebaseFirestore.instance.collection("Users").doc(userid).set({
        "Address": adreesscon.text,
        "Gender": gendercon.text,
        "Name": firstNamecon.text,
        "middleName": middleNamecon.text,
        "lastName": lastNamecon.text,
        "Occupation": occupationcon.text,
        "Phone": phoneNumbercon.text,
        "UserImg": imgUrl,
        "lastchat": "",
        "verifyed": false,
        "dob": dateofBirthcon.text,
        "alteremail": alterEmailIdcon.text,
        "aadhaarNo": aadhaarNumbercon.text,
        "mobileNo": mobileNumbercon.text,
        "email": emailIDcon.text,
        "city": citycon.text,
        "pinCode": pinCodecon.text,
        "state": statecon.text,
        "country": countrycon.text,
        "yearofpassed": yearPassedcon.text,
        "subjectStream": subjectStremdcon.text,
        "class": classcon.text,
        "rollNo": rollnocon.text,
        "lastvisit": lastvisitcon.text,
        "house": housecon.text,
        "statusmessage": statusmessagecon.text,
        "educationquvalification": educationquvalificationcon.text,
        "additionalquvalification": additionalquvalificationcon.text,
        "designation": designationcon.text,
        "company_concern": company_concerncon.text,
        "maritalStatus": maritalStatuscon.text,
        "spouseName": spouseNamecon.text,
        "anniversaryDate": anniversaryDatecon.text,
        "childreancount": no_of_childreancon.text,
        //  "Ownbusiness": ownBussinesscon.text,
        "date": "${DateTime
            .now()
            .day}/${DateTime
            .now()
            .month}/${DateTime
            .now()
            .year}",
        "timestamp": DateTime
            .now()
            .millisecondsSinceEpoch,
        "userDocId": userid,
        "Active": false,
        "Editted":false,
        "Token": "",
        "longtitude": 0,
        "latitude": 0,
        'workingStatus': alumniEmployedController.text,
        "regno": "Al${(billcount).toString().padLeft(2, "0")}"
      });
      setState(() {
        Useradd = false;
      });
    }
    userCreateSuccessPopup();
    controllersclearfunc();
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


  userNotValidAgePopup() {
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
                      KText(text: "Please Select the Age Correctly ", style:
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

  userDataUpdatefuntio() async {
    print(
        "UPdate Fucntion++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    print(userUpdateDocumentID);
    print("1");
    print(adreesscon.text);
    print("2");
    print(gendercon.text);
    print("3");
    print(firstNamecon.text);
    print("4");
    print(middleNamecon.text);
    print("5");
    print(lastNamecon.text);
    print("6");
    print(occupationcon.text);
    print("7");
    print(phoneNumbercon.text);
    print("8");
    print(phoneNumbercon.text);
    print("9");
    print(imgUrl);
    print("10");
    print(dateofBirthcon.text);
    print("11");
    print(alterEmailIdcon.text);
    print("12");
    print(aadhaarNumbercon.text);
    print("13");
    print(mobileNumbercon.text);
    print("14");
    print(emailIDcon.text);
    print("15");
    print(citycon.text);
    print("16");
    print(pinCodecon.text);
    print("17");
    print(statecon.text);
    print("18");
    print(countrycon.text);
    print("19");
    print(yearPassedcon.text);
    print("20");
    print(subjectStremdcon.text);
    print("21");
    print(classcon.text);
    print("22");
    print(rollnocon.text);
    print("23");
    print(lastvisitcon.text);
    print("24");
    print(housecon.text);
    print("25");
    print(statusmessagecon.text);
    print("26");
    print(educationquvalificationcon.text);
    print("27");
    print(additionalquvalificationcon.text);
    print("28");
    print(designationcon.text);
    print("29");
    print(company_concerncon.text);
    print("30");
    print(maritalStatuscon.text);
    print("31");
    print(spouseNamecon.text);
    print("32");
    print(anniversaryDatecon.text);
    print("33");
    print(no_of_childreancon.text);
    print("34");
    print(alumniEmployedController.text);
    print("--------------------------------------------------------");
    if (imgUrl != "") {
      print("If Fucntion+++++++++++++++++++++++++++++++++++++++++++++++++++++");
      await FirebaseFirestore.instance.collection("Users").doc(
          userUpdateDocumentID).update({
        "Address": adreesscon.text,
        "Gender": gendercon.text,
        "Name": firstNamecon.text,
        "middleName": middleNamecon.text,
        "lastName": lastNamecon.text,
        "Occupation": occupationcon.text,
        "Phone": phoneNumbercon.text,
        "UserImg": imgUrl,
        "lastchat": "",
        "dob": dateofBirthcon.text,
        "alteremail": alterEmailIdcon.text,
        "aadhaarNo": aadhaarNumbercon.text,
        "mobileNo": mobileNumbercon.text,
        "email": emailIDcon.text,
        "city": citycon.text,
        "pinCode": pinCodecon.text,
        "state": statecon.text,
        "country": countrycon.text,
        "yearofpassed": yearPassedcon.text,
        "subjectStream": subjectStremdcon.text,
        "class": classcon.text,
        "rollNo": rollnocon.text,
        "lastvisit": lastvisitcon.text,
        "house": housecon.text,
        "statusmessage": statusmessagecon.text,
        "educationquvalification": educationquvalificationcon.text,
        "additionalquvalification": additionalquvalificationcon.text,
        "designation": designationcon.text,
        "company_concern": company_concerncon.text,
        "maritalStatus": maritalStatuscon.text,
        "spouseName": spouseNamecon.text,
        "anniversaryDate": anniversaryDatecon.text,
        "childreancount": no_of_childreancon.text,
        'workingStatus': alumniEmployedController.text,
        // "Ownbusiness": ownBussinesscon.text,

      });
      setState(() {
        UserEdit = false;
      });
    }
    else {
      print(
          "Else Fucntion+++++++++++++++++++++++++++++++++++++++++++++++++++++");
      if (imgUrl == "" && Url != null) {
        var snapshot = await FirebaseStorage.instance.ref()
            .child('Images')
            .child("${Url!.name}")
            .putBlob(Url);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imgUrl = downloadUrl;
        });
        await FirebaseFirestore.instance.collection("Users").doc(
            userUpdateDocumentID).update({
          "Address": adreesscon.text,
          "Gender": gendercon.text,
          "Name": firstNamecon.text,
          "middleName": middleNamecon.text,
          "lastName": lastNamecon.text,
          "Occupation": occupationcon.text,
          "Phone": phoneNumbercon.text,
          "UserImg": imgUrl == "" ? "" : imgUrl,
          "lastchat": "",
          "dob": dateofBirthcon.text,
          "alteremail": alterEmailIdcon.text,
          "aadhaarNo": aadhaarNumbercon.text,
          "mobileNo": mobileNumbercon.text,
          "email": emailIDcon.text,
          "city": citycon.text,
          "pinCode": pinCodecon.text,
          "state": statecon.text,
          "country": countrycon.text,
          "yearofpassed": yearPassedcon.text,
          "subjectStream": subjectStremdcon.text,
          "class": classcon.text,
          "rollNo": rollnocon.text,
          "lastvisit": lastvisitcon.text,
          "house": housecon.text,
          "statusmessage": statusmessagecon.text,
          "educationquvalification": educationquvalificationcon.text,
          "additionalquvalification": additionalquvalificationcon.text,
          "designation": designationcon.text,
          "company_concern": company_concerncon.text,
          "maritalStatus": maritalStatuscon.text,
          "spouseName": spouseNamecon.text,
          "anniversaryDate": anniversaryDatecon.text,
          "childreancount": no_of_childreancon.text,
          'workingStatus': alumniEmployedController.text,
          //"Ownbusiness": ownBussinesscon.text,

        });
        setState(() {
          UserEdit = false;
        });
      }
      else {
        await FirebaseFirestore.instance.collection("Users").doc(
            userUpdateDocumentID).update({
          "Address": adreesscon.text,
          "Gender": gendercon.text,
          "Name": firstNamecon.text,
          "middleName": middleNamecon.text,
          "lastName": lastNamecon.text,
          "Occupation": occupationcon.text,
          "Phone": phoneNumbercon.text,
          "UserImg": imgUrl == "" ? "" : imgUrl,
          "lastchat": "",
          "dob": dateofBirthcon.text,
          "alteremail": alterEmailIdcon.text,
          "aadhaarNo": aadhaarNumbercon.text,
          "mobileNo": mobileNumbercon.text,
          "email": emailIDcon.text,
          "city": citycon.text,
          "pinCode": pinCodecon.text,
          "state": statecon.text,
          "country": countrycon.text,
          "yearofpassed": yearPassedcon.text,
          "subjectStream": subjectStremdcon.text,
          "class": classcon.text,
          "rollNo": rollnocon.text,
          "lastvisit": lastvisitcon.text,
          "house": housecon.text,
          "statusmessage": statusmessagecon.text,
          "educationquvalification": educationquvalificationcon.text,
          "additionalquvalification": additionalquvalificationcon.text,
          "designation": designationcon.text,
          "company_concern": company_concerncon.text,
          "maritalStatus": maritalStatuscon.text,
          "spouseName": spouseNamecon.text,
          "anniversaryDate": anniversaryDatecon.text,
          "childreancount": no_of_childreancon.text,
          'workingStatus': alumniEmployedController.text,
          //"Ownbusiness": ownBussinesscon.text,

        });
        setState(() {
          UserEdit = false;
        });
      }
    }


    controllersclearfunc();
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

  filterDataMenuItem(BuildContext context, key, size) async {
    setState(() {
      SerachValue="";
    });
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
      color: Colors.grey.shade200,
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
      items: filterDataList
          .map((item) =>
          PopupMenuItem<String>(
            enabled: true,
            onTap: () async {
              if (item == "Filter by Date") {
                var result = await filterPopUp();
                if (result) {
                  setState(() {
                    isFiltered = true;
                  });
                }
              }
              if (item == "Filter by Year") {
                var result = await shortBydataPopUp("Year",context);
                if (result) {
                  setState(() {
                    isFiltered = true;
                  });
                }

              }
              if (item == "Filter by Department") {
                var result = await shortBydataPopUp("Department",context);
                if (result) {
                  setState(() {
                    isFiltered = true;
                  });
                }

              }
            },
            value: item,
            child: Container(
              height: height / 18.475,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    item == "Filter by Date"
                        ? const Icon(
                      Icons.calendar_month,
                      color: Color(0xff5B93FF),
                      size: 18,
                    ) :
                    item == "Filter by Department"
                        ? const Icon(
                      Icons.circle,
                      color: Color(0xff5B93FF),
                      size: 18,
                    ) :
                    item == "Filter by Year"
                        ? const Icon(
                      Icons.circle,
                      color: Color(0xff5B93FF),
                      size: 18,
                    ) :
                    const Icon(
                      Icons.circle,
                      color: Colors.transparent,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: item == "Filter by Date"
                              ? const Color(0xff5B93FF)
                              : const Color(0xff5B93FF),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ))
          .toList(),
    );
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

  LastVisitselectYear(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 1),
              // lastDate: DateTime.now(),
              lastDate:DateTime.now() ,
              initialDate: DateTime(1950),
              selectedDate: _selectedYear,
              currentDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                print(dateTime.year);
                setState(() {
                  _selectedYear = dateTime;
                  lastvisitcon.text =dateTime.year.toString();
                  showYear = "${dateTime.year}";
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size
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
                          vertical: height / 81.375),
                      child: Form(
                        key: _formkey,
                        child: SizedBox(
                          width: 1550 * fem,
                          child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [

                                      ///Alumni text
                                      SizedBox(height: height / 26.04),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: width / 307.2),
                                          KText(
                                            text: 'Add Users Details',
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
                                            width: width / 3.7463,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: height / 7.39,
                                                  width: width / 15.36,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          100),
                                                      color:
                                                      const Color(0xffDDDEEE),
                                                      image: Uploaddocument !=
                                                          null
                                                          ? DecorationImage(
                                                        fit: BoxFit
                                                            .cover,
                                                        image:
                                                        MemoryImage(
                                                          Uint8List
                                                              .fromList(
                                                            base64Decode(
                                                                Uploaddocument!
                                                                    .split(
                                                                    ',')
                                                                    .last),
                                                          ),
                                                        ),
                                                      )
                                                          : imgUrl != null
                                                          ? DecorationImage(
                                                          fit: BoxFit
                                                              .cover,
                                                          image: NetworkImage(
                                                              imgUrl))
                                                          : DecorationImage(
                                                          fit: BoxFit
                                                              .cover,
                                                          image: AssetImage(
                                                              Constants()
                                                                  .avator))),
                                                ),
                                                SizedBox(width: width / 102.4),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    KText(
                                                      text:
                                                      "Upload Student Photo (150px X 150px)",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize: 17 * ffem,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        height: 1.3625 *
                                                            ffem /
                                                            fem,
                                                        color: const Color(
                                                            0xff000000),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: height / 147.8),
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
                                                                color: const Color(
                                                                    0xffDDDEEE),
                                                                border: Border.all(
                                                                    color: const Color(
                                                                        0xff000000))),
                                                            child: Center(
                                                              child: KText(
                                                                text:
                                                                "Choose File",
                                                                style:
                                                                SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize:
                                                                  17 *
                                                                      ffem,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  height: 1.3625 *
                                                                      ffem /
                                                                      fem,
                                                                  color: const Color(
                                                                      0xff000000),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width / 307.2),
                                                        KText(
                                                          text: Uploaddocument ==
                                                              null
                                                              ? "No file chosen"
                                                              : "File is Selected",
                                                          style:
                                                          SafeGoogleFont(
                                                            'Nunito',
                                                            fontSize:
                                                            17 * ffem,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            height: 1.3625 *
                                                                ffem /
                                                                fem,
                                                            color: const Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                    
                                                  ],
                                                )
                                              ],
                                            ),
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

                                                          SizedBox(height: height / 75.9),

                                                          ///date of birth and

                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [

                                                              /// date of birth
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
                                                                      width: width / 5.12,
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
                                                                      width: width / 5.12,
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

                                                            ],
                                                          ),
                                                          ///adhaaar card and emailid
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              /*  SizedBox(
                                                                   height: height/9.369,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      KText(
                                                                        text:
                                                                            'Alternate Email Id ',
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
                                                                                  if (isEmail(value!)) {
                                                                                      return 'Enter the Correct the Email';
                                                                                    }

                                                                                  return null;
                                                                                },
                                                                          )
                                                                                  )
                                                                    ],
                                                                  ),
                                                                ),*/
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width / 71.8947),
                                                                child: SizedBox(
                                                                  height: height / 9.369,
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
                                                                          height: height /
                                                                              15.114,
                                                                          width: width / 5.12,
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
                                                ),

                                                Padding(
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
                                                              ),

                                                              /*  DropdownButtonHideUnderline(
                                                                        child: DropdownButtonFormField2<String>(
                                                                        value:statecon.text,
                                                                          isExpanded:true,
                                                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                    hint: Padding(
                                                                      padding:  EdgeInsets.only(left:width/170.75),
                                                                      child: Text(
                                                                        'Select State',
                                                                        style:
                                                                        SafeGoogleFont('Nunito',
                                                                          fontSize:
                                                                             20 * ffem,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    items: StateList
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
                                                                        validator: (value) {
                                                                          if (value=='Select State') {
                                                                           setState((){
                                                                             dropdownValidator=true;
                                                                           });
                                                                          }
                                                                          return null;
                                                                        },
                                                                    onChanged: (String?
                                                                        value) {
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
                                                                    buttonStyleData:
                                                                    ButtonStyleData(height:20,
                                                                      width:
                                                                      width / 2.571,
                                                                    ),
                                                                    menuItemStyleData: const MenuItemStyleData(),
                                                                    decoration:
                                                                    const InputDecoration(
                                                                            border:
                                                                                InputBorder
                                                                                    .none),
                                                                           ),
                                                                          ),*/

                                                            ),
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

                                                              /*  DropdownButtonHideUnderline(
                                                        child:
                                                        DropdownButtonFormField2<
                                                            String>(
                                                          isExpanded: true,
                                                          autovalidateMode: AutovalidateMode
                                                              .onUserInteraction,
                                                          hint: Text(
                                                            'Select City',
                                                            style:
                                                            SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize:
                                                              20 * ffem,
                                                            ),
                                                          ),
                                                          items: _cities
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
                                                              ))
                                                              .toList(),
                                                          value: citycon.text,
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
                                                      ),*/
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
                                                              ),
                                                              /* DropdownButtonHideUnderline(

                                                        child:
                                                        DropdownButtonFormField2<
                                                            String>(
                                                          isExpanded: true,
                                                          autovalidateMode: AutovalidateMode
                                                              .onUserInteraction,
                                                          hint: Text(
                                                            'Select Country',
                                                            style:
                                                            SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize:
                                                              20 * ffem,
                                                            ),
                                                          ),
                                                          items: coutryList
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
                                                              ))
                                                              .toList(),
                                                          value:
                                                          countrycon.text,
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
                                                      ),*/
                                                            ),
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

                                                ///alumni details
                                                SizedBox(height: height / 36.95),
                                                Row(
                                                  children: [
                                                    SizedBox(width: width / 307.2),
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
                                                    width: width / 1.4422,
                                                    color: Colors.grey.shade300,
                                                  ),
                                                ),
                                                SizedBox(height: height / 36.95),

                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: height / 2.8,
                                                      width: width / 2.19428,
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
                                                                            // final DateTime? picked = await showDatePicker(
                                                                            //   context: context,
                                                                            //   initialDate: DateTime
                                                                            //       .now(),
                                                                            //   firstDate: DateTime(
                                                                            //       1900),
                                                                            //   lastDate: DateTime
                                                                            //       .now(), initialDatePickerMode: DatePickerMode
                                                                            //       .year,
                                                                            // );
                                                                            // if(picked!.year<(BatchYearValid+17)){
                                                                            //   userNotValidYearOfPassedPopup();
                                                                            // }
                                                                            //
                                                                            // if (picked != null && picked != DateTime.now()) {
                                                                            //   print(
                                                                            //       'Selected year: ${picked
                                                                            //           .year}');
                                                                            //   setState(() {
                                                                            //     yearPassedcon
                                                                            //         .text =
                                                                            //         picked
                                                                            //             .year
                                                                            //             .toString();
                                                                            //   });
                                                                            // }
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
                                                                height: height / 9.369,
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

                                                ///alumni education Qualifications
                                                SizedBox(height: height / 36.95),
                                                Row(
                                                  children: [
                                                    SizedBox(width: width / 307.2),
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

                                                    /* SizedBox(width: width/38.4),
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
                                                                  controller:
                                                                  designationcon,
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp(
                                                                        "[a-zA-Z]")),
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
                                                      ),*/
                                                    // SizedBox(
                                                    //   height: height / 9.369,
                                                    //   child: Column(
                                                    //     crossAxisAlignment:
                                                    //     CrossAxisAlignment.start,
                                                    //     children: [
                                                    //       KText(
                                                    //         text:
                                                    //         "Company Name",
                                                    //         style: SafeGoogleFont(
                                                    //           'Nunito',
                                                    //           fontSize: 20 * ffem,
                                                    //           fontWeight:
                                                    //           FontWeight.w700,
                                                    //           height:
                                                    //           1.3625 * ffem / fem,
                                                    //           color:
                                                    //           const Color(0xff000000),
                                                    //         ),
                                                    //       ),
                                                    //       SizedBox(height: height / 123.1666),
                                                    //       Container(
                                                    //           height: height / 15.114,
                                                    //           width: width / 4.6545,
                                                    //           decoration: BoxDecoration(
                                                    //               color: const Color(
                                                    //                   0xffDDDEEE),
                                                    //               borderRadius:
                                                    //               BorderRadius
                                                    //                   .circular(
                                                    //                   3)),
                                                    //           child: TextFormField(
                                                    //             controller:
                                                    //             company_concerncon,
                                                    //             inputFormatters: [
                                                    //               FilteringTextInputFormatter
                                                    //                   .allow(RegExp(
                                                    //                   "[a-zA-Z ]")),
                                                    //             ],
                                                    //             decoration:
                                                    //             const InputDecoration(
                                                    //               border: InputBorder
                                                    //                   .none,
                                                    //               contentPadding:
                                                    //               EdgeInsets.only(
                                                    //                   bottom: 10,
                                                    //                   top: 2,
                                                    //                   left: 10),
                                                    //             ),
                                                    //             // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                    //           ))
                                                    //     ],
                                                    //   ),
                                                    // ),
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

                                                ///Material Status
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
                                                            print( "errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
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
                                                        controllersclearfunc();
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
                                                        setState(() {
                                                          Useradd = false;
                                                        });
                                                        controllersclearfunc();
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
                                                SizedBox(height: height / 24.633),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ]

                                )
                              ]

                          ),

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
