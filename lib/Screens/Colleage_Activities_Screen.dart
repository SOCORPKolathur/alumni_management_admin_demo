import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:alumni_management_admin/Collage_activitieCrud/Collage_activities.dart';
import 'package:alumni_management_admin/Colleage_Printing/Colleage-Printing.dart';
import 'package:alumni_management_admin/Constant_.dart';
import 'package:alumni_management_admin/Models/Colleage_activity.dart';
import 'package:alumni_management_admin/Models/Language_Model.dart';
import 'package:alumni_management_admin/Models/Response_Model.dart';
import 'package:alumni_management_admin/common_widgets/developer_card_widget.dart';
import 'package:alumni_management_admin/utils.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:csv/csv.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';

class Colleage_Activities_Screen extends StatefulWidget {
  const Colleage_Activities_Screen({super.key});

  @override
  State<Colleage_Activities_Screen> createState() =>
      _Colleage_Activities_ScreenState();
}

class _Colleage_Activities_ScreenState extends State<Colleage_Activities_Screen>
    with SingleTickerProviderStateMixin {
  late AnimationController lottieController;
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController departmentcon =
      TextEditingController(text: 'Select Department');
  TextEditingController yearcon = TextEditingController(text: 'Select Year');
  TextEditingController avtivityType = TextEditingController(text: 'All');

  bool alldepartBoolean = true;
  bool individualdepartBoolean = false;
  bool dataSaved = false;
  DateTime? dateRangeStart;
  DateTime? dateRangeEnd;
  bool isFiltered = false;
  List<String> departmentDataList = [];
  List<String> yearDataList = [];
  List<String> mydate = [];
  TextEditingController Date1Controller = TextEditingController();
  TextEditingController Date2Controller = TextEditingController();
  bool filtervalue = false;
  bool addPhoto = false;
  bool SliderImg = false;
  String addphotoDocummentValue = '';
  String filterChageValue = "title";

  File? profileImage;
  var uploadedImage;
  String? selectedImg;

  DateTime selectedDate = DateTime.now();

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  String currentTab = 'View';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      setState(() {
        dateController.text = formatter.format(picked);
        selectedDate = picked;
      });
    }
  }

  List datalist = [
    "Edit",
    "Delete",
  ];

  List exportDataList = [
    'Print',
    'Copy',
    'Csv',
  ];

  List filterDataList = [
    'Filter by Date',
  ];

  List exportdataListFromStream = [];

  selectImage() {
    InputElement input = FileUploadInputElement() as InputElement
      ..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
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
      });
      setState(() {});
    });
  }

  setDateTime() async {
    setState(() {
      dateController.text = formatter.format(selectedDate);
      timeController.text = DateFormat('hh:mm a').format(DateTime.now());
    });
  }

  ///Department Fetch Function
  dropDowndataFetchFunc() async {
    setState(() {
      departmentDataList.clear();
      yearDataList.clear();
    });
    setState(() {
      departmentDataList.add('Select Department');
      yearDataList.add('Select Year');
    });
    var departmentdata = await cf.FirebaseFirestore.instance
        .collection("Department")
        .orderBy("name")
        .get();
    var acadamicYeardata = await cf.FirebaseFirestore.instance
        .collection("AcademicYear")
        .orderBy("name")
        .get();
    for (int x = 0; x < departmentdata.docs.length; x++) {
      setState(() {
        departmentDataList.add(departmentdata.docs[x]['name'].toString());
      });
    }
    for (int y = 0; y < acadamicYeardata.docs.length; y++) {
      setState(() {
        yearDataList.add(acadamicYeardata.docs[y]['name'].toString());
      });
    }
    print("department Data List $departmentDataList");
    print("Year Data List $yearDataList");
  }

  int pagecount = 0;
  int temp = 1;
  List list = new List<int>.generate(1000, (i) => i + 1);
  List<cf.DocumentSnapshot> documentList = [];
  int documentlength = 0;

  doclength() async {
    final cf.QuerySnapshot result = await cf.FirebaseFirestore.instance
        .collection("ColleageActivities")
        .get();

    final List<cf.DocumentSnapshot> documents = result.docs;
    setState(() {
      documentlength = documents.length;
      pagecount = ((documentlength - 1) ~/ 10) + 1;
    });
    print(pagecount);
    print(documentlength);
    print(
        "Document Total Length+++++++++++++++++++++++++++++++++++++++++++++++++");
  }

  @override
  void initState() {
    setDateTime();
    doclength();
    dropDowndataFetchFunc();
    lottieController = AnimationController(vsync: this);
    lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        lottieController.reset();
      }
    });
    super.initState();
  }

  GlobalKey ExportDataKeys = GlobalKey();
  GlobalKey filterDataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height / 81.375, horizontal: width / 170.75),
      child: SingleChildScrollView(
          child: FadeInRight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height / 81.375, horizontal: width / 170.75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(
                        text: "College Activity",
                        style: SafeGoogleFont('Nunito',
                            fontSize: width / 82.538,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height / 81.375),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (currentTab.toUpperCase() == "VIEW") {
                                setState(() {
                                  currentTab = "Add";
                                });
                              } else {
                                setState(() {
                                  currentTab = 'View';
                                });
                                //clearTextControllers();
                              }
                            },
                            child: Container(
                              height: height / 18.6,
                              width: width / 10.9714,
                              decoration: BoxDecoration(
                                color: Constants().primaryAppColor,
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 227.66),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    currentTab.toUpperCase() != "VIEW"
                                        ? const SizedBox()
                                        : Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                    KText(
                                      text: currentTab.toUpperCase() == "VIEW"
                                          ? "Add Activity"
                                          : "View Activity",
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: width / 120.07,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: width / 170.75),
                          child: InkWell(
                              key: ExportDataKeys,
                              onTap: () {
                                menuItemExportData(
                                    context,
                                    exportdataListFromStream,
                                    ExportDataKeys,
                                    size);
                              },
                              child: Container(
                                height: height / 16.6,
                                width: width / 10.9714,
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 227.66),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.logout_rounded,
                                        color: Colors.black,
                                      ),
                                      KText(
                                        text: "Export Data",
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width / 120.07,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        currentTab.toUpperCase() == "ADD"
                            ? const SizedBox()
                            : Padding(
                                padding: EdgeInsets.only(left: width / 1.88),
                                child: InkWell(
                                  key: filterDataKey,
                                  onTap: () async {
                                    if (dateRangeStart != null) {
                                      setState(() {
                                        dateRangeStart = null;
                                        dateRangeEnd = null;
                                        mydate.clear();
                                      });
                                      doclength();
                                    } else {
                                      filterDataMenuItem(
                                          context, filterDataKey, size);
                                    }
                                  },
                                  child: Container(
                                    height: height / 16.275,
                                    decoration: BoxDecoration(
                                      color: Constants().primaryAppColor,
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 227.66),
                                      child: Row(
                                        children: [
                                          Icon(Icons.filter_list_alt,
                                              color: Colors.white),
                                          KText(
                                            text: dateRangeStart == null
                                                ? " Filter by Date"
                                                : "Clear Date",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              fontSize: width / 120.571,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            currentTab.toUpperCase() == "ADD"
                ? Container(
                    width: width / 1.26,
                    height: height / 1.231666,
                    //       margin: EdgeInsets.symmetric(
                    //           horizontal: width / 68.3, vertical: height / 32.55),
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   fit: BoxFit.fill,
                      //   image: AssetImage(Constants().patterImg)
                      // ),
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
                          height: height / 9.2375,
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width / 68.3,
                                vertical: height / 81.375),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                KText(
                                  text: "ADD NEW Activity",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: width / 98.3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                /*InkWell(
                                onTap: () async {
                                  if (dateController.text != "" &&
                                      timeController.text != "" ) {
                                    Response response =
                                    await ActivityFireCrud.addEvent(
                                      title: titleController.text,
                                      time: timeController.text,
                                      location: locationController.text,
                                      image: profileImage,
                                      description: descriptionController.text,
                                      date: dateController.text,
                                    );
                                    if (response.code == 200) {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.success,
                                          text: "Activity created successfully!",
                                          width: size.width * 0.4,
                                          backgroundColor: Constants()
                                              .primaryAppColor
                                              .withOpacity(0.8));
                                      setState(() {
                                        locationController.text = "";
                                        descriptionController.text = "";
                                        uploadedImage = null;
                                        profileImage = null;
                                        currentTab = 'View';
                                      });
                                    } else {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          text: "Failed to Create Activity!",
                                          width: size.width * 0.4,
                                          backgroundColor: Constants()
                                              .primaryAppColor
                                              .withOpacity(0.8));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 227.66),
                                    child: Center(
                                      child: KText(
                                        text: "ADD NOW",
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width / 125.375,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )*/
                              ],
                            ),
                          ),
                        ),
                        Container(
                            height: height / 1.421153,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xffF7FAFC),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            padding: EdgeInsets.symmetric(
                                horizontal: width / 68.3,
                                vertical: height / 32.55),
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: height / 16.02,
                                                width: width / 7.0,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: width / 192),
                                                      child: KText(
                                                        text: "All",
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize:
                                                              width / 105.571,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Checkbox(
                                                      value: alldepartBoolean,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          alldepartBoolean =
                                                              val ?? false;
                                                          if (alldepartBoolean) {
                                                            individualdepartBoolean =
                                                                false;
                                                          } else {
                                                            individualdepartBoolean =
                                                                true;
                                                            setState(() {
                                                              avtivityType
                                                                      .text =
                                                                  "Individual";
                                                            });
                                                          }
                                                        });
                                                        if (alldepartBoolean) {
                                                          setState(() {
                                                            avtivityType.text =
                                                                "All";
                                                          });
                                                        }
                                                        print(
                                                            "avtivityType Controller+++++++++++++++++++++++++++++++++++++++++");
                                                        print(
                                                            avtivityType.text);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: width / 68.3),
                                              SizedBox(
                                                height: height / 16.02,
                                                width: width / 7.0,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: width / 192),
                                                      child: KText(
                                                        text:
                                                            "Department/Batch",
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize:
                                                              width / 105.571,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Checkbox(
                                                      value:
                                                          individualdepartBoolean,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          individualdepartBoolean =
                                                              val ?? false;
                                                          if (individualdepartBoolean) {
                                                            alldepartBoolean =
                                                                false;
                                                          } else {
                                                            alldepartBoolean =
                                                                true;
                                                            setState(() {
                                                              avtivityType
                                                                  .text = "All";
                                                            });
                                                          }
                                                        });
                                                        if (individualdepartBoolean) {
                                                          setState(() {
                                                            avtivityType.text =
                                                                "Individual";
                                                          });
                                                        }
                                                        print(
                                                            "avtivityType Controller+++++++++++++++++++++++++++++++++++++++++");
                                                        print(
                                                            avtivityType.text);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: "Date *",
                                                    style: SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: width / 105.571,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: height / 108.5),
                                                  Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child: SizedBox(
                                                      height: height / 16.02,
                                                      width: width / 7.0,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    height /
                                                                        81.375,
                                                                horizontal:
                                                                    width /
                                                                        170.75),
                                                        child: TextFormField(
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            fontSize:
                                                                width / 105.571,
                                                          ),
                                                          readOnly: true,
                                                          decoration:
                                                              InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          controller:
                                                              dateController,
                                                          onTap: () async {
                                                            DateTime?
                                                                pickedDate =
                                                                await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            1900),
                                                                    lastDate:
                                                                        DateTime(
                                                                            3000));
                                                            if (pickedDate !=
                                                                null) {
                                                              setState(() {
                                                                dateController
                                                                        .text =
                                                                    formatter
                                                                        .format(
                                                                            pickedDate);
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: width / 68.3),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: "Time *",
                                                    style: SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: width / 105.571,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: height / 108.5),
                                                  Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child: SizedBox(
                                                      height: height / 16.02,
                                                      width: width / 7.0,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    height /
                                                                        81.375,
                                                                horizontal:
                                                                    width /
                                                                        170.75),
                                                        child: TextFormField(
                                                          readOnly: true,
                                                          onTap: () {
                                                            _selectTime(
                                                                context);
                                                          },
                                                          controller:
                                                              timeController,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintStyle:
                                                                SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: width /
                                                                  105.571,
                                                            ),
                                                          ),
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            fontSize:
                                                                width / 105.571,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: width / 68.3),
                                              /* Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: "Location *",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  fontSize: width / 105.571,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: height / 108.5),
                                              Material(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                color: Colors.white,
                                                elevation: 10,
                                                child: SizedBox(
                                                  height: height / 13.02,
                                                  width: width / 6.830,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: height / 81.375,
                                                        horizontal: width / 170.75),
                                                    child: TextFormField(
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize: width / 105.571,
                                                      ),
                                                      controller: locationController,
                                                      decoration: InputDecoration(
                                                        contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
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
                                          ),*/
                                            ],
                                          ),
                                          SizedBox(height: height / 65.1),
                                          avtivityType.text == "Individual"
                                              ? Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        KText(
                                                          text: "Department",
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            fontSize:
                                                                width / 105.571,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                height / 108.5),
                                                        Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          color:
                                                              Color(0xffDDDEEE),
                                                          elevation: 5,
                                                          child: SizedBox(
                                                            height:
                                                                height / 16.02,
                                                            width: width / 7.0,
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButtonFormField2<
                                                                      String>(
                                                                isExpanded:
                                                                    true,
                                                                hint: Text(
                                                                  'Select Department',
                                                                  style:
                                                                      SafeGoogleFont(
                                                                    'Nunito',
                                                                  ),
                                                                ),
                                                                items:
                                                                    departmentDataList
                                                                        .map((String
                                                                                item) =>
                                                                            DropdownMenuItem<String>(
                                                                              value: item,
                                                                              child: Text(
                                                                                item,
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                value:
                                                                    departmentcon
                                                                        .text,
                                                                onChanged:
                                                                    (String?
                                                                        value) {
                                                                  setState(() {
                                                                    departmentcon
                                                                            .text =
                                                                        value!;
                                                                  });
                                                                },
                                                                buttonStyleData:
                                                                    const ButtonStyleData(),
                                                                menuItemStyleData:
                                                                    const MenuItemStyleData(),
                                                                decoration:
                                                                    const InputDecoration(
                                                                        border:
                                                                            InputBorder.none),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        width: width / 68.3),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        KText(
                                                          text: "Year",
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            fontSize:
                                                                width / 105.571,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                height / 108.5),
                                                        Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          color:
                                                              Color(0xffDDDEEE),
                                                          elevation: 5,
                                                          child: SizedBox(
                                                            height:
                                                                height / 16.02,
                                                            width: width / 7.0,
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButtonFormField2<
                                                                      String>(
                                                                isExpanded:
                                                                    true,
                                                                hint: Text(
                                                                  'Select Year',
                                                                  style:
                                                                      SafeGoogleFont(
                                                                    'Nunito',
                                                                  ),
                                                                ),
                                                                items:
                                                                    yearDataList
                                                                        .map((String
                                                                                item) =>
                                                                            DropdownMenuItem<String>(
                                                                              value: item,
                                                                              child: Text(
                                                                                item,
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                value: yearcon
                                                                    .text,
                                                                onChanged:
                                                                    (String?
                                                                        value) {
                                                                  setState(() {
                                                                    yearcon.text =
                                                                        value!;
                                                                  });
                                                                },
                                                                buttonStyleData:
                                                                    const ButtonStyleData(),
                                                                menuItemStyleData:
                                                                    const MenuItemStyleData(),
                                                                decoration:
                                                                    const InputDecoration(
                                                                        border:
                                                                            InputBorder.none),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                          avtivityType.text == "Individual"
                                              ? SizedBox(height: height / 65.1)
                                              : const SizedBox(),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: "Title *",
                                                    style: SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: width / 105.571,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: height / 108.5),
                                                  Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child: SizedBox(
                                                      height: height / 10.850,
                                                      width: size.width * 0.36,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    height /
                                                                        81.375,
                                                                horizontal:
                                                                    width /
                                                                        170.75),
                                                        child: TextFormField(
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    "[a-zA-Z ]")),
                                                          ],
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            fontSize:
                                                                width / 105.571,
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          minLines: 1,
                                                          maxLines: null,
                                                          controller:
                                                              titleController,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintStyle:
                                                                SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: width /
                                                                  105.571,
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
                                          SizedBox(height: height / 65.1),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: "Description",
                                                    style: SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: width / 105.571,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: height / 108.5),
                                                  Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child: SizedBox(
                                                      height: height / 6.510,
                                                      width: size.width * 0.36,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    height /
                                                                        81.375,
                                                                horizontal:
                                                                    width /
                                                                        170.75),
                                                        child: TextFormField(
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            fontSize:
                                                                width / 105.571,
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          minLines: 1,
                                                          maxLines: 5,
                                                          controller:
                                                              descriptionController,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintStyle:
                                                                SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: width /
                                                                  105.571,
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
                                        ],
                                      ),
                                      InkWell(
                                        onTap: selectImage,
                                        child: Container(
                                          height: size.height * 0.2,
                                          width: size.width * 0.10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: uploadedImage != null
                                                  ? DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: MemoryImage(
                                                        Uint8List.fromList(
                                                          base64Decode(
                                                              uploadedImage!
                                                                  .split(',')
                                                                  .last),
                                                        ),
                                                      ),
                                                    )
                                                  : null),
                                          child: uploadedImage != null
                                              ? null
                                              : Icon(
                                                  Icons.add_photo_alternate,
                                                  size: size.height * 0.2,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: height / 8.9),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: width / 2.2925,
                                        ),

                                        ///Save  button
                                        GestureDetector(
                                          onTap: dataSaved == false
                                              ? () async {
                                                  if (titleController.text !=
                                                          "" &&
                                                      dateController.text !=
                                                          "" &&
                                                      timeController.text !=
                                                          "") {
                                                    setState(() {
                                                      dataSaved = true;
                                                      _submitData2();
                                                    });
                                                    Response response =
                                                        await ActivityFireCrud
                                                            .addEvent(
                                                      title:
                                                          titleController.text,
                                                      time: timeController.text,
                                                      location:
                                                          locationController
                                                              .text,
                                                      image: profileImage,
                                                      description:
                                                          descriptionController
                                                              .text,
                                                      date: dateController.text,
                                                      activityDep:
                                                          departmentcon.text,
                                                      activityType:
                                                          avtivityType.text,
                                                      activityYear:
                                                          yearcon.text,
                                                    );
                                                    if (response.code == 200) {
                                                      CoolAlert.show(
                                                          context: context,
                                                          type: CoolAlertType
                                                              .success,
                                                          text:
                                                              "Activity created successfully!",
                                                          width: size.width *
                                                              0.4,
                                                          backgroundColor:
                                                              Constants()
                                                                  .primaryAppColor
                                                                  .withOpacity(
                                                                      0.8));
                                                      setState(() {
                                                        locationController
                                                            .text = "";
                                                        descriptionController
                                                            .text = "";
                                                        titleController.text =
                                                            "";
                                                        avtivityType.text =
                                                            "All";
                                                        departmentcon.text =
                                                            'Select Department';
                                                        yearcon.text =
                                                            'Select Year';
                                                        alldepartBoolean = true;
                                                        individualdepartBoolean =
                                                            false;
                                                        dataSaved = false;
                                                        departmentcon.text = "";
                                                        uploadedImage = null;
                                                        profileImage = null;
                                                        currentTab = 'View';
                                                      });
                                                    } else {
                                                      CoolAlert.show(
                                                          context: context,
                                                          type: CoolAlertType
                                                              .error,
                                                          text:
                                                              "Failed to Create Activity!",
                                                          width: size.width *
                                                              0.4,
                                                          backgroundColor:
                                                              Constants()
                                                                  .primaryAppColor
                                                                  .withOpacity(
                                                                      0.8));
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  }
                                                }
                                              : () {},
                                          child: Container(
                                              height: height / 18.475,
                                              width: width / 12.8,
                                              decoration: BoxDecoration(
                                                color: Color(0xffD60A0B),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: KText(
                                                  text: 'Save',
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: width / 96,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffFFFFFF),
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
                                            setState(() {
                                              locationController.text = "";
                                              descriptionController.text = "";
                                              titleController.text = "";
                                              avtivityType.text = "All";
                                              departmentcon.text =
                                                  'Select Department';
                                              yearcon.text = 'Select Year';
                                              alldepartBoolean = true;
                                              individualdepartBoolean = false;
                                              dataSaved = false;
                                              uploadedImage = null;
                                              profileImage = null;
                                            });
                                          },
                                          child: Container(
                                              height: height / 18.475,
                                              width: width / 12.8,
                                              decoration: BoxDecoration(
                                                color: Color(0xff00A0E3),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: KText(
                                                  text: 'Reset',
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: width / 96,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffFFFFFF),
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
                                              locationController.text = "";
                                              descriptionController.text = "";
                                              titleController.text = "";
                                              avtivityType.text = "All";
                                              departmentcon.text =
                                                  'Select Department';
                                              yearcon.text = 'Select Year';
                                              alldepartBoolean = true;
                                              individualdepartBoolean = false;
                                              dataSaved = false;
                                              uploadedImage = null;
                                              profileImage = null;
                                              currentTab = 'View';
                                            });
                                          },
                                          child: Container(
                                              height: height / 18.475,
                                              width: width / 12.8,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: KText(
                                                  text: 'Back',
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: width / 96,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffFFFFFF),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                : currentTab.toUpperCase() == "VIEW"
                    ? Column(
                        children: [
                          Container(
                              color: Colors.white,
                              width: width / 1.2418,
                              height: height / 13.43636,
                              child: Row(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    width: width / 16.5,
                                    height: height / 14.78,
                                    alignment: Alignment.center,
                                    child: Center(
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
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Transform.rotate(
                                              angle: 0,
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
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: width / 4.3885,
                                    height: height / 14.78,
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          KText(
                                            text: "Activity Name",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  filtervalue = !filtervalue;
                                                  filterChageValue = "title";
                                                });
                                              },
                                              child: Transform.rotate(
                                                angle: filterChageValue ==
                                                            "title" &&
                                                        filtervalue
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
                                                        color: filterChageValue ==
                                                                    "title" &&
                                                                filtervalue ==
                                                                    true
                                                            ? Colors.green
                                                            : Colors
                                                                .transparent),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: width / 4.45,
                                    height: height / 14.78,
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          KText(
                                            text: "Description",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  filtervalue = !filtervalue;
                                                  filterChageValue = "subtitle";
                                                });
                                              },
                                              child: Transform.rotate(
                                                angle: filterChageValue ==
                                                            "subtitle" &&
                                                        filtervalue
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
                                                        color: filterChageValue ==
                                                                    "subtitle" &&
                                                                filtervalue ==
                                                                    true
                                                            ? Colors.green
                                                            : Colors
                                                                .transparent),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: width / 9.5,
                                    height: height / 14.78,
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          KText(
                                            text: "Created On",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  filtervalue = !filtervalue;
                                                  filterChageValue = "date";
                                                });
                                              },
                                              child: Transform.rotate(
                                                angle: filterChageValue ==
                                                            "date" &&
                                                        filtervalue
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
                                                        color: filterChageValue ==
                                                                    "date" &&
                                                                filtervalue ==
                                                                    true
                                                            ? Colors.green
                                                            : Colors
                                                                .transparent),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: width / 9.0,
                                    height: height / 14.78,
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          KText(
                                            text: "Time",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  filtervalue = !filtervalue;
                                                  filterChageValue =
                                                      "uploadTime";
                                                });
                                              },
                                              child: Transform.rotate(
                                                angle: filterChageValue ==
                                                            "uploadTime" &&
                                                        filtervalue
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
                                                        color: filterChageValue ==
                                                                    "uploadTime" &&
                                                                filtervalue ==
                                                                    true
                                                            ? Colors.green
                                                            : Colors
                                                                .transparent),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 15.36,
                                    height: height / 14.78,
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          KText(
                                            text: "Actions",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Transform.rotate(
                                              angle: filtervalue ? 200 : 0,
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
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: height / 1.34363,
                            width: width / 1.2288,
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Column(
                                children: [
                                  mydate.isEmpty
                                      ? StreamBuilder(
                                          stream: ActivityFireCrud
                                              .fetchActivityPost(
                                                  filter: filtervalue,
                                                  filterValue:
                                                      filterChageValue),
                                          builder: (ctx, snapshot) {
                                            if (snapshot.hasError) {
                                              return Container();
                                            } else if (snapshot.hasData) {
                                              List<ColleageActivityModel>
                                                  clgActivityData =
                                                  snapshot.data!;
                                              exportdataListFromStream =
                                                  clgActivityData;
                                              List<
                                                      GlobalKey<
                                                          State<
                                                              StatefulWidget>>>
                                                  popMenuKeys = List.generate(
                                                clgActivityData.length,
                                                (index) => GlobalKey(),
                                              );

                                              return SingleChildScrollView(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: height / 1.35625,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: pagecount ==
                                                                temp
                                                            ? clgActivityData
                                                                        .length
                                                                        .remainder(
                                                                            10) ==
                                                                    0
                                                                ? 10
                                                                : clgActivityData
                                                                    .length
                                                                    .remainder(
                                                                        10)
                                                            : 10,
                                                        itemBuilder: (ctx, i) {
                                                          var clgActivity =
                                                              clgActivityData[
                                                                  (temp * 10) -
                                                                      10 +
                                                                      i];

                                                          return ((temp * 10) -
                                                                      10 +
                                                                      i >=
                                                                  documentlength)
                                                              ? const SizedBox()
                                                              : SizedBox(
                                                                  width: width /
                                                                      1.2288,
                                                                  height: height /
                                                                      13.43636,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: width /
                                                                            170.75),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              width / 19.2,
                                                                          height:
                                                                              height / 14.78,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 8),
                                                                            child:
                                                                                KText(
                                                                              text: "${((temp * 10) - 10 + i) + 1}",
                                                                              style: SafeGoogleFont(
                                                                                'Nunito',
                                                                                color: Color(0xff030229),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width / 4.3885,
                                                                          height:
                                                                              height / 14.78,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 8),
                                                                            child:
                                                                                KText(
                                                                              text: clgActivity.title.toString(),
                                                                              style: SafeGoogleFont(
                                                                                'Nunito',
                                                                                color: Color(0xff030229),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width / 4.3885,
                                                                          height:
                                                                              height / 14.78,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 8),
                                                                            child:
                                                                                KText(
                                                                              text: clgActivity.description.toString(),
                                                                              style: SafeGoogleFont(
                                                                                'Nunito',
                                                                                color: Color(0xff030229),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width / 9.6,
                                                                          height:
                                                                              height / 14.78,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 8),
                                                                            child:
                                                                                KText(
                                                                              text: clgActivity.date.toString(),
                                                                              style: SafeGoogleFont(
                                                                                'Nunito',
                                                                                color: Color(0xff030229),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width / 9.6,
                                                                          height:
                                                                              height / 14.78,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 8),
                                                                            child:
                                                                                KText(
                                                                              text: clgActivity.time.toString(),
                                                                              style: SafeGoogleFont(
                                                                                'Nunito',
                                                                                color: Color(0xff030229),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Popupmenu(
                                                                                context,
                                                                                clgActivity,
                                                                                popMenuKeys[i],
                                                                                size);
                                                                          },
                                                                          child: SizedBox(
                                                                              key: popMenuKeys[i],
                                                                              width: width / 15.36,
                                                                              height: height / 14.78,
                                                                              child: Icon(Icons.more_horiz)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ));
                                                        },
                                                      ),
                                                    ),
                                                    Stack(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              height / 13.02,
                                                          child:
                                                              ListView.builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount:
                                                                      pagecount,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          temp =
                                                                              list[index];
                                                                        });
                                                                        print(
                                                                            temp);
                                                                      },
                                                                      child: Container(
                                                                          height: 30,
                                                                          width: 30,
                                                                          margin: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: temp.toString() == list[index].toString() ? Constants().primaryAppColor : Colors.transparent),
                                                                          child: Center(
                                                                            child:
                                                                                Text(
                                                                              list[index].toString(),
                                                                              style: SafeGoogleFont('Nunito', fontWeight: FontWeight.w700, color: temp.toString() == list[index].toString() ? Colors.white : Colors.black),
                                                                            ),
                                                                          )),
                                                                    );
                                                                  }),
                                                        ),
                                                        temp > 1
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            150.0),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      temp =
                                                                          temp -
                                                                              1;
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                      height: height / 16.275,
                                                                      width: width / 11.3833,
                                                                      decoration: BoxDecoration(color: Constants().primaryAppColor, borderRadius: BorderRadius.circular(80)),
                                                                      child: Center(
                                                                        child:
                                                                            Text(
                                                                          "Previous Page",
                                                                          style:
                                                                              SafeGoogleFont(
                                                                            'Nunito',
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ),
                                                              )
                                                            : Container(),
                                                        Container(
                                                          child:
                                                              temp < pagecount
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              20.0),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            temp =
                                                                                temp + 1;
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                            height: height / 16.275,
                                                                            width: width / 11.3833,
                                                                            decoration: BoxDecoration(color: Constants().primaryAppColor, borderRadius: BorderRadius.circular(80)),
                                                                            child: Center(
                                                                              child: Text(
                                                                                "Next Page",
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  fontWeight: FontWeight.w700,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    )
                                                                  : Container(),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                            return Container();
                                          },
                                        )
                                      : StreamBuilder(
                                          stream: ActivityFireCrud
                                              .fetchActivityPost(
                                                  filter: filtervalue,
                                                  filterValue:
                                                      filterChageValue),
                                          builder: (ctx, snapshot) {
                                            if (snapshot.hasError) {
                                              return Container();
                                            } else if (snapshot.hasData) {
                                              List<ColleageActivityModel>
                                                  clgActivityData =
                                                  snapshot.data!;
                                              exportdataListFromStream =
                                                  clgActivityData;
                                              List<
                                                      GlobalKey<
                                                          State<
                                                              StatefulWidget>>>
                                                  popMenuKeys = List.generate(
                                                clgActivityData.length,
                                                (index) => GlobalKey(),
                                              );

                                              return SizedBox(
                                                height: height / 1.35625,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      clgActivityData.length,
                                                  itemBuilder: (ctx, i) {
                                                    var clgActivity =
                                                        clgActivityData[i];

                                                    if (mydate.isNotEmpty) {
                                                      if (mydate.contains(
                                                          clgActivity.date)) {
                                                        return SizedBox(
                                                            width:
                                                                width / 1.2288,
                                                            height: height /
                                                                13.43636,
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: width /
                                                                          170.75),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        width /
                                                                            19.2,
                                                                    height:
                                                                        height /
                                                                            14.78,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8),
                                                                      child:
                                                                          KText(
                                                                        text:
                                                                            "${i + 1}",
                                                                        style:
                                                                            SafeGoogleFont(
                                                                          'Nunito',
                                                                          color:
                                                                              Color(0xff030229),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: width /
                                                                        4.3885,
                                                                    height:
                                                                        height /
                                                                            14.78,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8),
                                                                      child:
                                                                          KText(
                                                                        text: clgActivity
                                                                            .title
                                                                            .toString(),
                                                                        style:
                                                                            SafeGoogleFont(
                                                                          'Nunito',
                                                                          color:
                                                                              Color(0xff030229),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: width /
                                                                        4.3885,
                                                                    height:
                                                                        height /
                                                                            14.78,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8),
                                                                      child:
                                                                          KText(
                                                                        text: clgActivity
                                                                            .description
                                                                            .toString(),
                                                                        style:
                                                                            SafeGoogleFont(
                                                                          'Nunito',
                                                                          color:
                                                                              Color(0xff030229),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        width /
                                                                            9.6,
                                                                    height:
                                                                        height /
                                                                            14.78,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8),
                                                                      child:
                                                                          KText(
                                                                        text: clgActivity
                                                                            .date
                                                                            .toString(),
                                                                        style:
                                                                            SafeGoogleFont(
                                                                          'Nunito',
                                                                          color:
                                                                              Color(0xff030229),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        width /
                                                                            9.6,
                                                                    height:
                                                                        height /
                                                                            14.78,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8),
                                                                      child:
                                                                          KText(
                                                                        text: clgActivity
                                                                            .time
                                                                            .toString(),
                                                                        style:
                                                                            SafeGoogleFont(
                                                                          'Nunito',
                                                                          color:
                                                                              Color(0xff030229),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Popupmenu(
                                                                          context,
                                                                          clgActivity,
                                                                          popMenuKeys[
                                                                              i],
                                                                          size);
                                                                    },
                                                                    child: SizedBox(
                                                                        key: popMenuKeys[
                                                                            i],
                                                                        width: width /
                                                                            15.36,
                                                                        height: height /
                                                                            14.78,
                                                                        child: Icon(
                                                                            Icons.more_horiz)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ));
                                                      }
                                                    }
                                                    return const SizedBox();
                                                  },
                                                ),
                                              );
                                            }
                                            return Container();
                                          },
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
            SizedBox(height: height / 65.1),
            DeveloperCardWidget(),
            SizedBox(height: height / 65.1),
          ],
        ),
      )),
    );
  }

  viewPopup(ColleageActivityModel clgActivityData) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            width: size.width * 0.5,
            margin: EdgeInsets.symmetric(
                horizontal: width / 68.3, vertical: height / 32.55),
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
                    padding: EdgeInsets.symmetric(
                        horizontal: width / 68.3, vertical: height / 81.375),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          clgActivityData.location!,
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: width / 78.3,
                            fontWeight: FontWeight.w700,
                          ),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 227.66),
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
                                image: NetworkImage(clgActivityData.imgUrl!),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 136.6,
                                  vertical: height / 65.1),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(height: height / 32.55),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.15,
                                        child: KText(
                                          text: "Date",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 95.375),
                                        ),
                                      ),
                                      Text(":"),
                                      SizedBox(width: width / 68.3),
                                      Text(
                                        clgActivityData.date!,
                                        style: SafeGoogleFont('Poppins',
                                            fontSize: width / 105.571),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height / 32.55),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.15,
                                        child: KText(
                                          text: "Time",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 95.375),
                                        ),
                                      ),
                                      Text(":"),
                                      SizedBox(width: width / 68.3),
                                      Text(
                                        clgActivityData.time!,
                                        style: SafeGoogleFont('Poppins',
                                            fontSize: width / 105.571),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height / 32.55),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.15,
                                        child: KText(
                                          text: "Location",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 95.375),
                                        ),
                                      ),
                                      Text(":"),
                                      SizedBox(width: width / 68.3),
                                      KText(
                                        text: clgActivityData.location!,
                                        style: SafeGoogleFont('Poppins',
                                            fontSize: width / 105.571),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height / 32.55),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.15,
                                        child: KText(
                                          text: "Description",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 95.375),
                                        ),
                                      ),
                                      Text(":"),
                                      SizedBox(width: width / 68.3),
                                      KText(
                                        text: clgActivityData.description!,
                                        style: SafeGoogleFont('Poppins',
                                            fontSize: width / 105.571),
                                      )
                                    ],
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

  viewRegisteredUsers(List<String> regUsers) async {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<cf.DocumentSnapshot> users = [];
    var usersDoc =
        await cf.FirebaseFirestore.instance.collection('Users').get();
    for (int i = 0; i < regUsers.length; i++) {
      for (int j = 0; j < usersDoc.docs.length; j++) {
        if (regUsers[i] == usersDoc.docs[j].id) {
          users.add(usersDoc.docs[j]);
        }
      }
    }
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            width: size.width * 0.5,
            margin: EdgeInsets.symmetric(
                horizontal: width / 68.3, vertical: height / 32.55),
            decoration: BoxDecoration(
              color: Constants().primaryAppColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: height * 0.6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    height: height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Constants().primaryAppColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: "Registered Users",
                          style: SafeGoogleFont('Poppins',
                              fontSize: width / 105.538,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: height / 13.02,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 19.2,
                                    child: Center(
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            users[i].get("imgUrl")),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width / 7.68,
                                    child: Text(users[i].get("firstName") +
                                        " " +
                                        users[i].get("lastName")),
                                  ),
                                  Container(
                                    width: width / 6.144,
                                    child: Text(users[i].get("phone")),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  editPopUp(ColleageActivityModel clgActivityData, Size size) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              width: width / 1.2418,
              height: height / 1.231666,
              margin: EdgeInsets.symmetric(
                  horizontal: width / 68.5, vertical: height / 32.55),
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
                    height: height / 10.3,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 68.3, vertical: height / 81.375),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: "EDIT Activity",
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
                  Container(
                    width: double.infinity,
                    height: height / 1.421153,
                    decoration: BoxDecoration(
                        color: Color(0xffF7FAFC),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                    padding: EdgeInsets.symmetric(
                        horizontal: width / 68.3, vertical: height / 32.55),
                    child: SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: height / 16.02,
                                        width: width / 7.0,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: width / 192),
                                              child: KText(
                                                text: "All",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  fontSize: width / 105.571,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Checkbox(
                                                value: alldepartBoolean,
                                                onChanged: (val) {
                                                  setState(() {
                                                    alldepartBoolean =
                                                        !alldepartBoolean;
                                                  });
                                                  if (alldepartBoolean ==
                                                      true) {
                                                    setState(() {
                                                      avtivityType.text = "All";
                                                      individualdepartBoolean =
                                                          false;
                                                    });
                                                  }

                                                  print(
                                                      "avtivityType Controller+++++++++++++++++++++++++++++++++++++++++");
                                                  print(avtivityType.text);
                                                }),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: width / 68.3),
                                      SizedBox(
                                        height: height / 16.02,
                                        width: width / 7.0,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: width / 192),
                                              child: KText(
                                                text: "Department/Batch",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  fontSize: width / 105.571,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Checkbox(
                                                value: individualdepartBoolean,
                                                onChanged: (val) {
                                                  setState(() {
                                                    individualdepartBoolean =
                                                        !individualdepartBoolean;
                                                  });
                                                  if (individualdepartBoolean ==
                                                      true) {
                                                    setState(() {
                                                      avtivityType.text =
                                                          "Individual";
                                                      alldepartBoolean = false;
                                                    });
                                                  }
                                                  print(
                                                      "avtivityType Controller+++++++++++++++++++++++++++++++++++++++++");
                                                  print(avtivityType.text);
                                                }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: "Date *",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              fontSize: width / 105.571,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: height / 108.5),
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Color(0xffDDDEEE),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: height / 16.02,
                                              width: width / 7.0,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height / 81.375,
                                                    horizontal: width / 170.75),
                                                child: TextFormField(
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: width / 105.571,
                                                  ),
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none),
                                                  controller: dateController,
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(1900),
                                                            lastDate:
                                                                DateTime(3000));
                                                    if (pickedDate != null) {
                                                      setState(() {
                                                        dateController.text =
                                                            formatter.format(
                                                                pickedDate);
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: width / 68.3),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: "Time *",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              fontSize: width / 105.571,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: height / 108.5),
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Color(0xffDDDEEE),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: height / 16.02,
                                              width: width / 7.0,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height / 81.375,
                                                    horizontal: width / 170.75),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  onTap: () {
                                                    _selectTime(context);
                                                  },
                                                  controller: timeController,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintStyle: SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: width / 105.571,
                                                    ),
                                                  ),
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: width / 105.571,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: width / 68.3),
                                      /* Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: "Location *",
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: width / 105.571,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: height / 108.5),
                                                Material(
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  color: Colors.white,
                                                  elevation: 10,
                                                  child: SizedBox(
                                                    height: height / 13.02,
                                                    width: width / 6.830,
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: height / 81.375,
                                                          horizontal: width / 170.75),
                                                      child: TextFormField(
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: width / 105.571,
                                                        ),
                                                        controller: locationController,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5),
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
                                            ),*/
                                    ],
                                  ),
                                  SizedBox(height: height / 65.1),
                                  avtivityType.text == "Individual"
                                      ? Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: "Department",
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: width / 105.571,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: height / 108.5),
                                                Material(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: Color(0xffDDDEEE),
                                                  elevation: 5,
                                                  child: SizedBox(
                                                    height: height / 16.02,
                                                    width: width / 7.0,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButtonFormField2<
                                                              String>(
                                                        isExpanded: true,
                                                        hint: Text(
                                                          'Select Department',
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                          ),
                                                        ),
                                                        items:
                                                            departmentDataList
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
                                                                        ),
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                        value:
                                                            departmentcon.text,
                                                        onChanged:
                                                            (String? value) {
                                                          setState(() {
                                                            departmentcon.text =
                                                                value!;
                                                          });
                                                        },
                                                        buttonStyleData:
                                                            const ButtonStyleData(),
                                                        menuItemStyleData:
                                                            const MenuItemStyleData(),
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(width: width / 68.3),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: "Year",
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: width / 105.571,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: height / 108.5),
                                                Material(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: Color(0xffDDDEEE),
                                                  elevation: 5,
                                                  child: SizedBox(
                                                    height: height / 16.02,
                                                    width: width / 7.0,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButtonFormField2<
                                                              String>(
                                                        isExpanded: true,
                                                        hint: Text(
                                                          'Select Year',
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                          ),
                                                        ),
                                                        items: yearDataList
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
                                                                    ),
                                                                  ),
                                                                ))
                                                            .toList(),
                                                        value: yearcon.text,
                                                        onChanged:
                                                            (String? value) {
                                                          setState(() {
                                                            yearcon.text =
                                                                value!;
                                                          });
                                                        },
                                                        buttonStyleData:
                                                            const ButtonStyleData(),
                                                        menuItemStyleData:
                                                            const MenuItemStyleData(),
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  avtivityType.text == "Individual"
                                      ? SizedBox(height: height / 65.1)
                                      : const SizedBox(),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: "Title *",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              fontSize: width / 105.571,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: height / 108.5),
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Color(0xffDDDEEE),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: height / 10.850,
                                              width: size.width * 0.36,
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
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 1,
                                                  maxLines: null,
                                                  controller: titleController,
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
                                  SizedBox(height: height / 65.1),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: "Description",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              fontSize: width / 105.571,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: height / 108.5),
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Color(0xffDDDEEE),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: height / 6.510,
                                              width: size.width * 0.36,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height / 81.375,
                                                    horizontal: width / 170.75),
                                                child: TextFormField(
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: width / 105.571,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 1,
                                                  maxLines: 5,
                                                  controller:
                                                      descriptionController,
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
                                ],
                              ),
                              InkWell(
                                onTap: selectImage,
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: selectedImg != null
                                          ? DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(selectedImg!))
                                          : uploadedImage != null
                                              ? DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: MemoryImage(
                                                    Uint8List.fromList(
                                                      base64Decode(
                                                          uploadedImage!
                                                              .split(',')
                                                              .last),
                                                    ),
                                                  ),
                                                )
                                              : null),
                                  child:
                                      (selectedImg != null || selectedImg != '')
                                          ? null
                                          : Icon(
                                              Icons.add_photo_alternate,
                                              size: size.height * 0.2,
                                            ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height / 10.39),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: width / 2.2925,
                                ),

                                /// Update Button
                                GestureDetector(
                                  onTap: dataSaved == false
                                      ? () async {
                                          if (titleController.text != "" &&
                                              dateController.text != "" &&
                                              timeController.text != "") {
                                            setState(() {
                                              dataSaved = true;
                                            });
                                            Response response =
                                                await ActivityFireCrud
                                                    .updateRecord(
                                                        ColleageActivityModel(
                                                          id: clgActivityData
                                                              .id,
                                                          title: titleController
                                                              .text,
                                                          imgUrl:
                                                              clgActivityData
                                                                  .imgUrl,
                                                          timestamp:
                                                              clgActivityData
                                                                  .timestamp,
                                                          views: clgActivityData
                                                              .views,
                                                          time: timeController
                                                              .text,
                                                          location:
                                                              locationController
                                                                  .text,
                                                          description:
                                                              descriptionController
                                                                  .text,
                                                          date: dateController
                                                              .text,
                                                          registeredUsers:
                                                              clgActivityData
                                                                  .registeredUsers,
                                                          activityType:
                                                              avtivityType.text,
                                                          activityDep:
                                                              departmentcon
                                                                  .text,
                                                          activityYear:
                                                              yearcon.text,
                                                        ),
                                                        profileImage,
                                                        clgActivityData
                                                                .imgUrl ??
                                                            "");
                                            if (response.code == 200) {
                                              CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.success,
                                                  text:
                                                      "Activity updated successfully!",
                                                  width: size.width * 0.4,
                                                  backgroundColor: Constants()
                                                      .primaryAppColor
                                                      .withOpacity(0.8));
                                              setState(() {
                                                locationController.text = "";
                                                descriptionController.text = "";
                                                titleController.text = "";
                                                avtivityType.text = "All";
                                                departmentcon.text =
                                                    'Select Department';
                                                yearcon.text = 'Select Year';
                                                alldepartBoolean = true;
                                                individualdepartBoolean = false;
                                                dataSaved = false;
                                                uploadedImage = null;
                                                profileImage = null;
                                              });
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            } else {
                                              CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.error,
                                                  text:
                                                      "Failed to update Activity!",
                                                  width: size.width * 0.4,
                                                  backgroundColor: Constants()
                                                      .primaryAppColor
                                                      .withOpacity(0.8));
                                              Navigator.pop(context);
                                            }
                                          } else {
                                            CoolAlert.show(
                                                context: context,
                                                type: CoolAlertType.warning,
                                                text:
                                                    "Please fill the required fields",
                                                width: size.width * 0.4,
                                                backgroundColor: Constants()
                                                    .primaryAppColor
                                                    .withOpacity(0.8));
                                          }
                                        }
                                      : () {},
                                  child: Container(
                                      height: height / 18.475,
                                      width: width / 12.8,
                                      decoration: BoxDecoration(
                                        color: Color(0xffD60A0B),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: KText(
                                          text: 'Update',
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: width / 96,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: width / 76.8,
                                ),

                                ///Cancel Button
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      locationController.text = "";
                                      descriptionController.text = "";
                                      titleController.text = "";
                                      avtivityType.text = "All";
                                      departmentcon.text = 'Select Department';
                                      yearcon.text = 'Select Year';
                                      alldepartBoolean = true;
                                      individualdepartBoolean = false;
                                      dataSaved = false;
                                      uploadedImage = null;
                                      profileImage = null;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      height: height / 18.475,
                                      width: width / 12.8,
                                      decoration: BoxDecoration(
                                        color: Color(0xff00A0E3),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: KText(
                                          text: 'Cancel',
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: width / 96,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: width / 76.8,
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
        });
      },
    );
  }

  convertToCsv(List<ColleageActivityModel> clgActivityData) async {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("No.");
    row.add("Date");
    row.add("Time");
    row.add("Description");
    row.add("Activity Type");
    row.add("Activity Department");
    row.add("Activity Year");
    rows.add(row);
    for (int i = 0; i < clgActivityData.length; i++) {
      List<dynamic> row = [];
      row.add(i + 1);
      row.add(clgActivityData[i].date!);
      row.add(clgActivityData[i].time!);
      row.add(clgActivityData[i].description!);
      row.add(clgActivityData[i].activityType!);
      row.add(clgActivityData[i].activityDep!);
      row.add(clgActivityData[i].activityYear!);
      rows.add(row);
    }
    String csv = ListToCsvConverter().convert(rows);
    //FsaveCsvToFile(csv);
  }

  convertToPdf(List<ColleageActivityModel> clgActivityData) async {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("No.");
    row.add("Date");
    row.add("Time");
    row.add("Description");
    row.add("Activity Type");
    row.add("Activity Department");
    row.add("Activity Year");
    rows.add(row);
    for (int i = 0; i < clgActivityData.length; i++) {
      List<dynamic> row = [];
      row.add(i + 1);
      row.add(clgActivityData[i].date!);
      row.add(clgActivityData[i].time!);
      row.add(clgActivityData[i].description!);
      row.add(clgActivityData[i].activityType!);
      row.add(clgActivityData[i].activityDep!);
      row.add(clgActivityData[i].activityYear!);
      rows.add(row);
    }
    String pdf = ListToCsvConverter().convert(rows);
    //  savePdfToFile(pdf);
  }
  //
  // void saveCsvToFile(csvString) async {
  //   final blob = Blob([Uint8List.fromList(csvString.codeUnits)]);
  //   final url = Url.createObjectUrlFromBlob(blob);
  //   final anchor = AnchorElement(href: url)
  //     ..setAttribute("download", "data.csv")
  //     ..click();
  //   Url.revokeObjectUrl(url);
  // }
  //
  // void savePdfToFile(data) async {
  //   final blob = Blob([data], 'application/pdf');
  //   final url = Url.createObjectUrlFromBlob(blob);
  //   final anchor = AnchorElement(href: url)
  //     ..setAttribute("download", "clgActivity.pdf")
  //     ..click();
  //   Url.revokeObjectUrl(url);
  // }

  copyToClipBoard(List<ColleageActivityModel> clgActivityData) async {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("No.");
    row.add("    ");
    row.add("Date");
    row.add("    ");
    row.add("Time");
    row.add("    ");
    row.add("Location");
    row.add("    ");
    row.add("Description");
    rows.add(row);
    for (int i = 0; i < clgActivityData.length; i++) {
      List<dynamic> row = [];
      row.add(i + 1);
      row.add("       ");
      row.add(clgActivityData[i].date);
      row.add("       ");
      row.add(clgActivityData[i].time);
      row.add("       ");
      row.add(clgActivityData[i].location);
      row.add("       ");
      row.add(clgActivityData[i].description);
      rows.add(row);
    }
    String csv = ListToCsvConverter().convert(rows,
        fieldDelimiter: null,
        eol: null,
        textEndDelimiter: null,
        delimitAllFields: false,
        textDelimiter: null);
    await Clipboard.setData(ClipboardData(text: csv.replaceAll(",", "")));
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
                                  controller: Date1Controller,
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
                                        Date1Controller.text =
                                            DateFormat('d/M/yyyy')
                                                .format(pickedDate);
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
                                    controller: Date2Controller,
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
                                          Date2Controller.text =
                                              DateFormat('d/M/yyyy')
                                                  .format(pickedDate);
                                          dateRangeEnd = pickedDate;
                                        });
                                        DateTime startDate = DateTime.utc(
                                            dateRangeStart!.year,
                                            dateRangeStart!.month,
                                            dateRangeStart!.day);
                                        DateTime endDate = DateTime.utc(
                                            dateRangeEnd!.year,
                                            dateRangeEnd!.month,
                                            dateRangeEnd!.day);
                                        print(startDate);
                                        print(endDate);
                                        print("+++++++=================");
                                        getDaysInBetween() {
                                          final int difference = endDate
                                              .difference(startDate)
                                              .inDays;
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
                                          print(
                                              "+++++++++++++000000000+++++++++++");
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
                                  setState(() {
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
                                  setState(() {
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
                  style: SafeGoogleFont('Poppins', color: Colors.black)),
            ),
            Spacer(),
            TextButton(
                onPressed: () => debugPrint("Undid"), child: Text("Undo"))
          ],
        )),
  );

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
        timeController.text = picked.toString();
      });
    _formatTime(picked!);
  }

  String _formatTime(TimeOfDay time) {
    int hour = time.hourOfPeriod;
    int minute = time.minute;
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    setState(() {
      timeController.text =
          '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
    });

    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  Popupmenu(BuildContext context, clgActivityData, key, size) async {
    print(
        "Popupmenu open-----------------------------------------------------------");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final render = key.currentContext!.findRenderObject() as RenderBox;
    await showMenu(
      color: Color(0xffFFFFFF),
      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(
          render.localToGlobal(Offset.zero).dx,
          render.localToGlobal(Offset.zero).dy + 50,
          double.infinity,
          double.infinity),
      items: datalist
          .map((item) => PopupMenuItem<String>(
                enabled: true,
                onTap: () async {
                  if (item == "Edit") {
                    setState(() {
                      dateController.text = clgActivityData.date!;
                      titleController.text = clgActivityData.title!;
                      timeController.text = clgActivityData.time!;
                      locationController.text = clgActivityData.location!;
                      descriptionController.text = clgActivityData.description!;
                      selectedImg = clgActivityData.imgUrl;
                      avtivityType.text = clgActivityData.activityType;
                      departmentcon.text = clgActivityData.activityDep;
                      yearcon.text = clgActivityData.activityYear;
                      dataSaved = false;
                    });
                    if (clgActivityData.activityType == "All") {
                      setState(() {
                        alldepartBoolean = true;
                        avtivityType.text = "All";
                        individualdepartBoolean = false;
                      });
                    }
                    if (clgActivityData.activityType == "Individual") {
                      setState(() {
                        individualdepartBoolean = true;
                        avtivityType.text = "Individual";
                        alldepartBoolean = false;
                      });
                    }
                    editPopUp(clgActivityData, size);
                  } else if (item == "Delete") {
                    ActivityFireCrud.deleteRecord(id: clgActivityData.id);
                  }
                },
                value: item,
                child: Container(
                  height: height / 18.475,
                  decoration: BoxDecoration(
                      color: item == "Edit"
                          ? Color(0xff5B93FF).withOpacity(0.6)
                          : Color(0xffE71D36).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      item == "Edit"
                          ? Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            )
                          : Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 18,
                            ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          item,
                          style: TextStyle(
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

  menuItemExportData(BuildContext context, clgActivityData, key, size) async {
    print(
        "Popupmenu open-----------------------------------------------------------");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final render = key.currentContext!.findRenderObject() as RenderBox;
    await showMenu(
      color: Colors.grey.shade200,
      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(
          render.localToGlobal(Offset.zero).dx,
          render.localToGlobal(Offset.zero).dy + 50,
          double.infinity,
          double.infinity),
      items: exportDataList
          .map((item) => PopupMenuItem<String>(
                enabled: true,
                onTap: () async {
                  if (item == "Print") {
                    var data = await generateActivityPdf(
                        PdfPageFormat.letter, clgActivityData, false);
                  } else if (item == "Copy") {
                    copyToClipBoard(clgActivityData);
                  } else if (item == "Csv") {
                    convertToCsv(clgActivityData);
                  }
                },
                value: item,
                child: Material(
                  color: item == "Print"
                      ? Color(0xff5B93FF)
                      : item == "Copy"
                          ? Color(0xffE71D36)
                          : item == "Csv"
                              ? Colors.green
                              : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  elevation: 10,
                  child: Container(
                    height: height / 18.475,
                    decoration: BoxDecoration(
                        color: item == "Print"
                            ? Color(0xff5B93FF)
                            : item == "Copy"
                                ? Color(0xffE71D36)
                                : item == "Csv"
                                    ? Colors.green
                                    : Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        item == "Print"
                            ? Icon(
                                Icons.print,
                                color: Colors.white,
                                size: 18,
                              )
                            : item == "Copy"
                                ? Icon(
                                    Icons.copy,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : item == "Csv"
                                    ? Icon(
                                        Icons.file_copy_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : Icon(
                                        Icons.circle,
                                        color: Colors.transparent,
                                      ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: item == "Print"
                                  ? Colors.white
                                  : item == "Copy"
                                      ? Colors.white
                                      : item == "Csv"
                                          ? Colors.white
                                          : Colors.white,
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

  filterDataMenuItem(BuildContext context, key, size) async {
    print(
        "Popupmenu open-----------------------------------------------------------");

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final render = key.currentContext!.findRenderObject() as RenderBox;
    await showMenu(
      color: Colors.grey.shade200,
      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(
          render.localToGlobal(Offset.zero).dx,
          render.localToGlobal(Offset.zero).dy + 50,
          double.infinity,
          double.infinity),
      items: filterDataList
          .map((item) => PopupMenuItem<String>(
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
                },
                value: item,
                child: Container(
                  height: height / 18.475,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      item == "Filter by Date"
                          ? Icon(
                              Icons.print,
                              color: Color(0xff5B93FF),
                              size: 18,
                            )
                          : Icon(
                              Icons.circle,
                              color: Colors.transparent,
                            ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: item == "Filter by Date"
                                ? Color(0xff5B93FF)
                                : Colors.white,
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

  _submitData2() {
    FirebaseFirestore.instance.collection('Post').add({
      'catitle': titleController.text,

      'cadate': dateController.text,

      'cadescription': descriptionController.text,
      "caimageurl": "",
      "catime": timeController.text,

      'timestamp': Timestamp.now().microsecondsSinceEpoch,
      "types":"collegeactivity",
      "register":[],
      "likes":[],
      "views":[],
    });
  }
}
