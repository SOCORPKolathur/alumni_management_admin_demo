import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:alumni_management_admin/Constant_.dart';
import 'package:alumni_management_admin/Job_Printing/Job_Prining.dart';
import 'package:alumni_management_admin/Models/Job_Post_Model.dart';
import 'package:alumni_management_admin/Models/Language_Model.dart';
import 'package:alumni_management_admin/Models/Response_Model.dart';
import 'package:alumni_management_admin/common_widgets/developer_card_widget.dart';
import 'package:alumni_management_admin/utils.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:randomstring_dart/randomstring_dart.dart';

import '../JOb_Posts_Crud/JobPost_Crud.dart';

class Job_Posts extends StatefulWidget {
  int pageval;
  Job_Posts(this.pageval);

  @override
  State<Job_Posts> createState() => _Job_PostsState();
}

class _Job_PostsState extends State<Job_Posts> with TickerProviderStateMixin {
  late AnimationController lottieController;
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController lastDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quvalificationController = TextEditingController();
  TextEditingController positionsController = TextEditingController();
  TextEditingController noOfOpeningController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController expController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DateTime? dateRangeStart;
  DateTime? dateRangeEnd;
  List<String> mydate = [];
  bool isFiltered = false;
  TextEditingController Date1Controller = TextEditingController();
  TextEditingController Date2Controller = TextEditingController();
  bool filtervalue = true;
  bool addPhoto = false;
  bool SliderImg = false;
  String addphotoDocummentValue = '';
  String filterChageValue = "timestamp";
  File? profileImage;
  var uploadedImage;
  String? selectedImg;

  DateTime selectedDate = DateTime.now();

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  String currentTab = 'View';

  /*Future<void> _selectDate(BuildContext context) async {
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
  }*/

  List datalist = [
    "Edit",
    "Delete",
    "View",
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

  TabController? tabController;

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

  @override
  void initState() {
    getdocid();
    setDateTime();
    doclength();
    exportdataListFromStream.clear();
    tabController = TabController(length: 2, vsync: this);
    lottieController = AnimationController(vsync: this);
    lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        lottieController.reset();
      }
    });

    setState(() {
      selectTabIndex = widget.pageval;
      tabController!
          .animateTo(widget.pageval, duration: Duration(milliseconds: 200));
    });
    super.initState();
  }

  GlobalKey ExportDataKeys = GlobalKey();
  GlobalKey filterDataKey = GlobalKey();

  int selectTabIndex = 0;
  int pagecount = 0;
  int pagecount2 = 0;
  int temp = 1;
  int temp2 = 1;
  List list = new List<int>.generate(1000, (i) => i + 1);
  List list2 = new List<int>.generate(1000, (i) => i + 1);
  List<cf.DocumentSnapshot> documentList = [];
  int documentlength = 0;
  int documentlength2 = 0;

  doclength() async {
    final cf.QuerySnapshot result = await cf.FirebaseFirestore.instance
        .collection("JobPosts")
        .where("verify", isEqualTo: true)
        .get();
    final List<cf.DocumentSnapshot> documents = result.docs;
    final cf.QuerySnapshot result2 = await cf.FirebaseFirestore.instance
        .collection("JobPosts")
        .where("verify", isEqualTo: false)
        .get();
    final List<cf.DocumentSnapshot> documents2 = result2.docs;
    setState(() {
      documentlength = documents.length;
      documentlength2 = documents2.length;
      pagecount = ((documentlength ~/ 10) + 1);
      pagecount2 = ((documentlength2 ~/ 10) + 1);
    });
    print(documents.length);
    print(documents2.length);
    print(pagecount);
    print(pagecount2);
    print(documentlength);
    print(documentlength2);
    print(temp);
    print(temp2);
    print(
        "Document Total Length+++++++++++++++++++++++++++++++++++++++++++++++++");
  }

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
        child: SizedBox(
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
                          text: "Job Post",
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
                                  setState(() {
                                    locationController.text = "";
                                    descriptionController.text = "";
                                    quvalificationController.text = "";
                                    positionsController.text = "";
                                    titleController.text = "";
                                    uploadedImage = null;
                                    profileImage = null;
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
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      currentTab.toUpperCase() != "VIEW"
                                          ? const SizedBox()
                                          : const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                      KText(
                                        text: currentTab.toUpperCase() == "VIEW"
                                            ? "Add Post"
                                            : "View Post",
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
                            padding: EdgeInsets.only(left: height / 81.375),
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
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
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
                                        child: Row(
                                          children: [
                                            const Icon(Icons.filter_list_alt,
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
                      height: height / 1.23166,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black26,
                            offset: Offset(1, 2),
                            blurRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: "ADD NEW POST",
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: width / 98.3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: height / 1.421153,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Color(0xffF7FAFC),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 68.3,
                                  vertical: height / 32.55),
                              child: SingleChildScrollView(
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: "Position *",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize:
                                                            width / 105.571,
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
                                                      color: const Color(
                                                          0xffDDDEEE),
                                                      elevation: 5,
                                                      child: SizedBox(
                                                        height: height / 16.02,
                                                        width:
                                                            size.width * 0.17,
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
                                                            style:
                                                                SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: width /
                                                                  105.571,
                                                            ),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Position is required';
                                                              }
                                                              return null;
                                                            },
                                                            maxLines: 1,
                                                            controller:
                                                                positionsController,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle:
                                                                  SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize:
                                                                    width /
                                                                        105.571,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width / 54.64),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      KText(
                                                        text: "Qualification *",
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
                                                        color: const Color(
                                                            0xffDDDEEE),
                                                        elevation: 5,
                                                        child: SizedBox(
                                                          height:
                                                              height / 16.02,
                                                          width:
                                                              size.width * 0.17,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        height /
                                                                            81.375,
                                                                    horizontal:
                                                                        width /
                                                                            170.75),
                                                            child:
                                                                TextFormField(
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        "[a-zA-Z ]")),
                                                              ],
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize:
                                                                    width /
                                                                        105.571,
                                                              ),
                                                              maxLines: 1,
                                                              controller:
                                                                  quvalificationController,
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintStyle:
                                                                    SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize:
                                                                      width /
                                                                          105.571,
                                                                ),
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
                                            SizedBox(height: height / 65.1),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                /*  Column(
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
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child: SizedBox(
                                                      height: height / 16.02,
                                                      width: width / 9.106,
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
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child: SizedBox(
                                                      height: height / 16.02,
                                                      width: width / 9.106,
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
                                              SizedBox(width: width / 68.3),*/

                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: "Location *",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize:
                                                            width / 105.571,
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
                                                      color: const Color(
                                                          0xffDDDEEE),
                                                      elevation: 5,
                                                      child: SizedBox(
                                                        height: height / 16.02,
                                                        width:
                                                            size.width * 0.17,
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
                                                            style:
                                                                SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: width /
                                                                  105.571,
                                                            ),
                                                            controller:
                                                                locationController,
                                                            maxLines: 1,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle:
                                                                  SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize:
                                                                    width /
                                                                        105.571,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width / 54.64),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      KText(
                                                        text: "No of Openings*",
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
                                                        color: const Color(
                                                            0xffDDDEEE),
                                                        elevation: 5,
                                                        child: SizedBox(
                                                          height:
                                                              height / 16.02,
                                                          width:
                                                              size.width * 0.17,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        height /
                                                                            81.375,
                                                                    horizontal:
                                                                        width /
                                                                            170.75),
                                                            child:
                                                                TextFormField(
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r"[0-9]")),
                                                              ],
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize:
                                                                    width /
                                                                        105.571,
                                                              ),
                                                              minLines: 1,
                                                              controller:
                                                                  noOfOpeningController,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintStyle:
                                                                    SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize:
                                                                      width /
                                                                          105.571,
                                                                ),
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
                                            SizedBox(height: height / 65.1),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                /*  Column(
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
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child: SizedBox(
                                                      height: height / 16.02,
                                                      width: width / 9.106,
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
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child: SizedBox(
                                                      height: height / 16.02,
                                                      width: width / 9.106,
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
                                              SizedBox(width: width / 68.3),*/

                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: "Last Date ",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize:
                                                            width / 105.571,
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
                                                      color: const Color(
                                                          0xffDDDEEE),
                                                      elevation: 5,
                                                      child: SizedBox(
                                                        height: height / 16.02,
                                                        width:
                                                            size.width * 0.17,
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
                                                            readOnly: true,
                                                            onTap: () async {
                                                              DateTime?
                                                                  pickedDate =
                                                                  await DatePicker
                                                                      .showSimpleDatePicker(
                                                                context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime
                                                                        .now(),
                                                                lastDate:
                                                                    DateTime(
                                                                        2060),
                                                                dateFormat:
                                                                    "dd-MM-yyyy",
                                                                locale:
                                                                    DateTimePickerLocale
                                                                        .en_us,
                                                                looping: true,
                                                              );
                                                              if (pickedDate !=
                                                                  null) {
                                                                setState(() {
                                                                  lastDateController
                                                                          .text =
                                                                      formatter
                                                                          .format(
                                                                              pickedDate);
                                                                });
                                                              }
                                                            },
                                                            style:
                                                                SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: width /
                                                                  105.571,
                                                            ),
                                                            controller:
                                                                lastDateController,
                                                            maxLines: 1,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle:
                                                                  SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize:
                                                                    width /
                                                                        105.571,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width / 54.64),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      KText(
                                                        text: "Company*",
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
                                                        color: const Color(
                                                            0xffDDDEEE),
                                                        elevation: 5,
                                                        child: SizedBox(
                                                          height:
                                                              height / 16.02,
                                                          width:
                                                              size.width * 0.17,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        height /
                                                                            81.375,
                                                                    horizontal:
                                                                        width /
                                                                            170.75),
                                                            child:
                                                                TextFormField(
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        "[a-zA-Z ]")),
                                                              ],
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize:
                                                                    width /
                                                                        105.571,
                                                              ),
                                                              controller:
                                                                  companyController,
                                                              maxLines: 1,
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintStyle:
                                                                    SafeGoogleFont(
                                                                  'Nunito',
                                                                  fontSize:
                                                                      width /
                                                                          105.571,
                                                                ),
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
                                            SizedBox(height: height / 65.1),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                /*  Column(
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
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child: SizedBox(
                                                      height: height / 16.02,
                                                      width: width / 9.106,
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
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child: SizedBox(
                                                      height: height / 16.02,
                                                      width: width / 9.106,
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
                                              SizedBox(width: width / 68.3),*/

                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text:
                                                          "Minimun Experience *",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize:
                                                            width / 105.571,
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
                                                      color: const Color(
                                                          0xffDDDEEE),
                                                      elevation: 5,
                                                      child: SizedBox(
                                                        height: height / 16.02,
                                                        width:
                                                            size.width * 0.17,
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
                                                                      "[0-9 ]")),
                                                            ],
                                                            style:
                                                                SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: width /
                                                                  105.571,
                                                            ),
                                                            minLines: 1,
                                                            controller:
                                                                expController,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle:
                                                                  SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize:
                                                                    width /
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
                                                      text: "Title *",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize:
                                                            width / 105.571,
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
                                                      color: const Color(
                                                          0xffDDDEEE),
                                                      elevation: 5,
                                                      child: SizedBox(
                                                        height: height / 10.850,
                                                        width:
                                                            size.width * 0.36,
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
                                                            style:
                                                                SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: width /
                                                                  105.571,
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
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle:
                                                                  SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize:
                                                                    width /
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
                                                        fontSize:
                                                            width / 105.571,
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
                                                      color: const Color(
                                                          0xffDDDEEE),
                                                      elevation: 5,
                                                      child: SizedBox(
                                                        height: height / 6.510,
                                                        width:
                                                            size.width * 0.36,
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
                                                            style:
                                                                SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize: width /
                                                                  105.571,
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
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle:
                                                                  SafeGoogleFont(
                                                                'Nunito',
                                                                fontSize:
                                                                    width /
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
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: width / 2.2925,
                                          ),

                                          ///Save  button
                                          GestureDetector(
                                            onTap: () async {
                                              if (dateController.text != "" &&
                                                  timeController.text != "" &&
                                                  titleController.text != "" &&
                                                  locationController.text !=
                                                      "" &&
                                                  descriptionController.text !=
                                                      "" &&
                                                  quvalificationController
                                                          .text !=
                                                      "" &&
                                                  noOfOpeningController.text !=
                                                      "" &&
                                                  positionsController.text !=
                                                      "") {
                                                // Check if Positions is not empty

                                                Response response = await JobPostFireCrud.addEvent(
                                                    title: titleController.text,
                                                    time: DateFormat('hh:mm a')
                                                        .format(DateTime.now()),
                                                    location:
                                                        locationController.text,
                                                    image: profileImage,
                                                    description:
                                                        descriptionController
                                                            .text,
                                                    date: formatter
                                                        .format(DateTime.now()),
                                                    positions:
                                                        positionsController
                                                            .text,
                                                    openings:
                                                        noOfOpeningController
                                                            .text,
                                                    quvalification:
                                                        quvalificationController
                                                            .text,
                                                    verify: true,
                                                    userName: "Admin",
                                                    UserOccupation: "Admin",
                                                    Batch: "Admin",
                                                    LastDate: lastDateController
                                                        .text);
                                                _submitData1();

                                                if (response.code == 200) {
                                                  CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.success,
                                                    text:
                                                        "Post created successfully!",
                                                    width: size.width * 0.4,
                                                    backgroundColor: Constants()
                                                        .primaryAppColor
                                                        .withOpacity(0.8),
                                                  );

                                                  setState(() {
                                                    locationController.text =
                                                        "";
                                                    descriptionController.text =
                                                        "";
                                                    quvalificationController
                                                        .text = "";
                                                    positionsController.text =
                                                        "";
                                                    titleController.text = "";
                                                    uploadedImage = null;
                                                    profileImage = null;
                                                    currentTab = 'View';
                                                  });
                                                  doclength();
                                                } else {
                                                  CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.error,
                                                    text:
                                                        "Failed to Create Post!",
                                                    width: size.width * 0.4,
                                                    backgroundColor: Constants()
                                                        .primaryAppColor
                                                        .withOpacity(0.8),
                                                  );
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            },
                                            child: Container(
                                              height: height / 18.475,
                                              width: width / 12.8,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffD60A0B),
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
                                                    color:
                                                        const Color(0xffFFFFFF),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                                quvalificationController.text =
                                                    "";
                                                positionsController.text = "";
                                                uploadedImage = null;
                                                profileImage = null;
                                              });
                                            },
                                            child: Container(
                                                height: height / 18.475,
                                                width: width / 12.8,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff00A0E3),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Center(
                                                  child: KText(
                                                    text: 'Reset',
                                                    style: SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: width / 96,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xffFFFFFF),
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
                                                quvalificationController.text =
                                                    "";
                                                positionsController.text = "";
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xffFFFFFF),
                                                    ),
                                                  ),
                                                )),
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
                    )
                  : currentTab.toUpperCase() == "VIEW"
                      ? SizedBox(
                          height: height / 1.0166,
                          width: width / 1.21964,
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: StreamBuilder<List<JobPostModel>>(
                                stream: JobPostFireCrud.fetchJobPost(
                                    filterValue: filterChageValue,
                                    filter: filtervalue),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData == null) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  List<JobPostModel> jobPost = snapshot.data!;
                                  exportdataListFromStream = jobPost;
                                  List<JobPostModel> verifyed = [];
                                  List<JobPostModel> Notverifyed = [];

                                  snapshot.data!.forEach((element) {
                                    if (element.verify == true) {
                                      verifyed.add(element);
                                    } else {
                                      Notverifyed.add(element);
                                    }
                                  });

                                  return Column(
                                    children: [
                                      TabBar(
                                        controller: tabController,
                                        labelColor: Colors.black,
                                        dividerColor: Colors.transparent,
                                        isScrollable: false,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        indicatorColor:
                                            Constants().primaryAppColor,
                                        physics: const BouncingScrollPhysics(),
                                        indicatorPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 0),
                                        labelPadding: const EdgeInsets.all(0),
                                        splashBorderRadius: BorderRadius.zero,
                                        splashFactory: NoSplash.splashFactory,
                                        labelStyle: GoogleFonts.nunito(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        unselectedLabelStyle:
                                            GoogleFonts.nunito(
                                                color: const Color(0xff4E4B66)),
                                        onTap: (index) {
                                          setState(() {
                                            selectTabIndex = index;
                                          });
                                        },
                                        tabs: [
                                          Tab(
                                            child: KText(
                                                text: "Verified",
                                                style: GoogleFonts.nunito(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Tab(
                                            child: KText(
                                                text: "Not Verified",
                                                style: GoogleFonts.nunito(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          color: Colors.white,
                                          width: width / 1.2418,
                                          // width: width/1.3009,
                                          height: height / 13.4363,
                                          child: Row(
                                            children: [
                                              Container(
                                                color: Colors.white,
                                                width: width / 19.2,
                                                height: height / 14.78,
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      KText(
                                                        text: "SL.No",
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          color: const Color(
                                                              0xff030229),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child:
                                                              Transform.rotate(
                                                            angle: 0,
                                                            child: Opacity(
                                                              // arrowdown2TvZ (8:2307)
                                                              opacity: 0.7,
                                                              child: Container(
                                                                width: width /
                                                                    153.6,
                                                                height: height /
                                                                    73.9,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/arrow-down-2.png',
                                                                  width: width /
                                                                      153.6,
                                                                  height:
                                                                      height /
                                                                          73.9,
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
                                              Container(
                                                color: Colors.white,
                                                width: width / 9.38857,
                                                height: height / 14.78,
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      KText(
                                                        text: "Post Name",
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          color: const Color(
                                                              0xff030229),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              filtervalue =
                                                                  !filtervalue;
                                                              filterChageValue =
                                                                  "title";
                                                            });
                                                          },
                                                          child:
                                                              Transform.rotate(
                                                            angle: filterChageValue ==
                                                                        "title" &&
                                                                    filtervalue
                                                                ? 200
                                                                : 0,
                                                            child: Opacity(
                                                              // arrowdown2TvZ (8:2307)
                                                              opacity: 0.7,
                                                              child: Container(
                                                                width: width /
                                                                    153.6,
                                                                height: height /
                                                                    73.9,
                                                                child: Image.asset(
                                                                    'assets/images/arrow-down-2.png',
                                                                    width: width /
                                                                        153.6,
                                                                    height:
                                                                        height /
                                                                            73.9,
                                                                    color: filterChageValue ==
                                                                                "title" &&
                                                                            filtervalue ==
                                                                                true
                                                                        ? Colors
                                                                            .green
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
                                                width: width / 7.38857,
                                                height: height / 14.78,
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      KText(
                                                        text: "Title",
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          color: const Color(
                                                              0xff030229),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              filtervalue =
                                                                  !filtervalue;
                                                              filterChageValue =
                                                                  "title";
                                                            });
                                                          },
                                                          child:
                                                              Transform.rotate(
                                                            angle: filterChageValue ==
                                                                        "title" &&
                                                                    filtervalue
                                                                ? 200
                                                                : 0,
                                                            child: Opacity(
                                                              // arrowdown2TvZ (8:2307)
                                                              opacity: 0.7,
                                                              child: Container(
                                                                width: width /
                                                                    153.6,
                                                                height: height /
                                                                    73.9,
                                                                child: Image.asset(
                                                                    'assets/images/arrow-down-2.png',
                                                                    width: width /
                                                                        153.6,
                                                                    height:
                                                                        height /
                                                                            73.9,
                                                                    color: filterChageValue ==
                                                                                "title" &&
                                                                            filtervalue ==
                                                                                true
                                                                        ? Colors
                                                                            .green
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
                                                width: width / 4.38857,
                                                height: height / 14.78,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: "Description",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        color: const Color(
                                                            0xff030229),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            filtervalue =
                                                                !filtervalue;
                                                            filterChageValue =
                                                                "subtitle";
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
                                                              width:
                                                                  width / 153.6,
                                                              height:
                                                                  height / 73.9,
                                                              child: Image.asset(
                                                                  'assets/images/arrow-down-2.png',
                                                                  width: width /
                                                                      153.6,
                                                                  height:
                                                                      height /
                                                                          73.9,
                                                                  color: filterChageValue ==
                                                                              "subtitle" &&
                                                                          filtervalue ==
                                                                              true
                                                                      ? Colors
                                                                          .green
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
                                              Container(
                                                color: Colors.white,
                                                width: width / 9.6,
                                                height: height / 14.78,
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      KText(
                                                        text: "Created On",
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          color: const Color(
                                                              0xff030229),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              filtervalue =
                                                                  !filtervalue;
                                                              filterChageValue =
                                                                  "date";
                                                            });
                                                          },
                                                          child:
                                                              Transform.rotate(
                                                            angle: filterChageValue ==
                                                                        "date" &&
                                                                    filtervalue
                                                                ? 200
                                                                : 0,
                                                            child: Opacity(
                                                              // arrowdown2TvZ (8:2307)
                                                              opacity: 0.7,
                                                              child: Container(
                                                                width: width /
                                                                    153.6,
                                                                height: height /
                                                                    73.9,
                                                                child: Image.asset(
                                                                    'assets/images/arrow-down-2.png',
                                                                    width: width /
                                                                        153.6,
                                                                    height:
                                                                        height /
                                                                            73.9,
                                                                    color: filterChageValue ==
                                                                                "date" &&
                                                                            filtervalue ==
                                                                                true
                                                                        ? Colors
                                                                            .green
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
                                                width: width / 16.0,
                                                height: height / 14.78,
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      KText(
                                                        text: "Last Date",
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          color: const Color(
                                                              0xff030229),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              filtervalue =
                                                                  !filtervalue;
                                                              filterChageValue =
                                                                  "LastDate";
                                                            });
                                                          },
                                                          child:
                                                              Transform.rotate(
                                                            angle: filterChageValue ==
                                                                        "LastDate" &&
                                                                    filtervalue
                                                                ? 200
                                                                : 0,
                                                            child: Opacity(
                                                              // arrowdown2TvZ (8:2307)
                                                              opacity: 0.7,
                                                              child: Container(
                                                                width: width /
                                                                    153.6,
                                                                height: height /
                                                                    73.9,
                                                                child: Image.asset(
                                                                    'assets/images/arrow-down-2.png',
                                                                    width: width /
                                                                        153.6,
                                                                    height:
                                                                        height /
                                                                            73.9,
                                                                    color: filterChageValue ==
                                                                                "uploadTime" &&
                                                                            filtervalue ==
                                                                                true
                                                                        ? Colors
                                                                            .green
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
                                                width: width / 17.6,
                                                height: height / 14.78,
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      KText(
                                                        text: "Status",
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          color: const Color(
                                                              0xff030229),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              filtervalue =
                                                                  !filtervalue;
                                                              filterChageValue =
                                                                  "verify";
                                                            });
                                                          },
                                                          child:
                                                              Transform.rotate(
                                                            angle: filterChageValue ==
                                                                        "verify" &&
                                                                    filtervalue
                                                                ? 200
                                                                : 0,
                                                            child: Opacity(
                                                              // arrowdown2TvZ (8:2307)
                                                              opacity: 0.7,
                                                              child: Container(
                                                                width: width /
                                                                    153.6,
                                                                height: height /
                                                                    73.9,
                                                                child: Image.asset(
                                                                    'assets/images/arrow-down-2.png',
                                                                    width: width /
                                                                        153.6,
                                                                    height:
                                                                        height /
                                                                            73.9,
                                                                    color: filterChageValue ==
                                                                                "verify" &&
                                                                            filtervalue ==
                                                                                true
                                                                        ? Colors
                                                                            .green
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
                                                width: width / 16.36,
                                                height: height / 14.78,
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      KText(
                                                        text: "Actions",
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          color: const Color(
                                                              0xff030229),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              filtervalue =
                                                                  !filtervalue;
                                                            });
                                                          },
                                                          child:
                                                              Transform.rotate(
                                                            angle: filtervalue
                                                                ? 200
                                                                : 0,
                                                            child: Opacity(
                                                              // arrowdown2TvZ (8:2307)
                                                              opacity: 0.7,
                                                              child: Container(
                                                                width: width /
                                                                    153.6,
                                                                height: height /
                                                                    73.9,
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
                                          )),
                                      SizedBox(
                                        height: height / 1.102,
                                        child: TabBarView(
                                          controller: tabController,
                                          physics: const ScrollPhysics(),
                                          children: [
                                            SizedBox(
                                                height: height / 1.14363,
                                                width: width / 1.2288,
                                                child: SingleChildScrollView(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: height / 1.38,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          itemCount: pagecount ==
                                                                  temp
                                                              ? verifyed.length
                                                                          .remainder(
                                                                              10) ==
                                                                      0
                                                                  ? 10
                                                                  : verifyed
                                                                      .length
                                                                      .remainder(
                                                                          10)
                                                              : 10,
                                                          itemBuilder:
                                                              (ctx, i) {
                                                            var verifyedData =
                                                                verifyed[(temp *
                                                                        10) -
                                                                    10 +
                                                                    i];
                                                            List<
                                                                    GlobalKey<
                                                                        State<
                                                                            StatefulWidget>>>
                                                                popMenuKeys =
                                                                List.generate(
                                                              verifyed.length,
                                                              (index) =>
                                                                  GlobalKey(),
                                                            );

                                                            if (mydate
                                                                .isNotEmpty) {
                                                              if (mydate.contains(
                                                                  verifyedData
                                                                      .date)) {
                                                                return SizedBox(
                                                                    width: width /
                                                                        1.2288,
                                                                    height: height /
                                                                        13.4363,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width /
                                                                              170.75),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                width / 19.2,
                                                                            height:
                                                                                height / 14.78,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: "${temp * i + 2}",
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width / 9.38857,
                                                                            height:
                                                                                height / 14.78,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: verifyedData.positions.toString(),
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width / 7.38857,
                                                                            height:
                                                                                height / 14.78,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: verifyedData.title.toString(),
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width / 4.38857,
                                                                            height:
                                                                                height / 14.78,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: verifyedData.description.toString(),
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
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
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: verifyedData.date.toString(),
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width / 16.0,
                                                                            height:
                                                                                height / 14.78,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: verifyedData.LastDate.toString(),
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: width / 17.6,
                                                                              height: height / 14.78,
                                                                              child: verifyedData.verify == true
                                                                                  ? const Icon(
                                                                                      Icons.verified,
                                                                                      color: Colors.green,
                                                                                    )
                                                                                  : const Icon(
                                                                                      Icons.verified_outlined,
                                                                                    )),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Popupmenu(context, verifyedData, popMenuKeys[i], size);
                                                                            },
                                                                            child: SizedBox(
                                                                                key: popMenuKeys[i],
                                                                                width: width / 18.36,
                                                                                height: height / 14.78,
                                                                                child: const Icon(Icons.more_horiz)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ));
                                                              }
                                                            } else if (mydate
                                                                .isEmpty) {
                                                              return ((temp * 10) -
                                                                          10 +
                                                                          i >=
                                                                      documentlength)
                                                                  ? const SizedBox()
                                                                  : SizedBox(
                                                                      width: width /
                                                                          1.2288,
                                                                      height: height /
                                                                          13.4363,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: width / 170.75),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: width / 19.2,
                                                                              height: height / 14.78,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 8),
                                                                                child: KText(
                                                                                  text: "${temp * i + 2}",
                                                                                  style: SafeGoogleFont(
                                                                                    'Nunito',
                                                                                    color: const Color(0xff030229),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: width / 9.38857,
                                                                              height: height / 14.78,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 8),
                                                                                child: KText(
                                                                                  text: verifyedData.positions.toString(),
                                                                                  style: SafeGoogleFont(
                                                                                    'Nunito',
                                                                                    color: const Color(0xff030229),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: width / 7.38857,
                                                                              height: height / 14.78,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 8),
                                                                                child: KText(
                                                                                  text: verifyedData.title.toString(),
                                                                                  style: SafeGoogleFont(
                                                                                    'Nunito',
                                                                                    color: const Color(0xff030229),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: width / 4.38857,
                                                                              height: height / 14.78,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 8),
                                                                                child: KText(
                                                                                  text: verifyedData.description.toString(),
                                                                                  style: SafeGoogleFont(
                                                                                    'Nunito',
                                                                                    color: const Color(0xff030229),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: width / 9.6,
                                                                              height: height / 14.78,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 8),
                                                                                child: KText(
                                                                                  text: verifyedData.date.toString(),
                                                                                  style: SafeGoogleFont(
                                                                                    'Nunito',
                                                                                    color: const Color(0xff030229),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: width / 16.0,
                                                                              height: height / 14.78,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 8),
                                                                                child: KText(
                                                                                  text: verifyedData.LastDate.toString(),
                                                                                  style: SafeGoogleFont(
                                                                                    'Nunito',
                                                                                    color: const Color(0xff030229),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                                width: width / 17.6,
                                                                                height: height / 14.78,
                                                                                child: verifyedData.verify == true
                                                                                    ? const Icon(
                                                                                        Icons.verified,
                                                                                        color: Colors.green,
                                                                                      )
                                                                                    : const Icon(
                                                                                        Icons.verified_outlined,
                                                                                      )),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                Popupmenu(context, verifyedData, popMenuKeys[i], size);
                                                                              },
                                                                              child: SizedBox(key: popMenuKeys[i], width: width / 18.36, height: height / 14.78, child: const Icon(Icons.more_horiz)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ));
                                                            }
                                                            return const SizedBox();
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width / 1.2418,
                                                        child: Stack(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          children: [
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              height: height /
                                                                  13.02,
                                                              child: ListView
                                                                  .builder(
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
                                                                            setState(() {
                                                                              temp = list[index];
                                                                            });
                                                                            print(temp);
                                                                          },
                                                                          child: Container(
                                                                              height: 30,
                                                                              width: 30,
                                                                              margin: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: temp.toString() == list[index].toString() ? Constants().primaryAppColor : Colors.transparent),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  list[index].toString(),
                                                                                  style: SafeGoogleFont('Nunito', fontWeight: FontWeight.w700, color: temp.toString() == list[index].toString() ? Colors.white : Colors.black),
                                                                                ),
                                                                              )),
                                                                        );
                                                                      }),
                                                            ),
                                                            temp > 1
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            150.0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          temp =
                                                                              temp - 1;
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
                                                            Container(
                                                              child: temp <
                                                                      pagecount
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
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            SizedBox(
                                                height: height / 1.34363,
                                                width: width / 1.2288,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: height / 1.7131,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const ScrollPhysics(),
                                                        itemCount:
                                                            Notverifyed.length,
                                                        itemBuilder: (ctx, i) {
                                                          var NotverifyedData =
                                                              Notverifyed[
                                                                  (temp2 * 10) -
                                                                      10 +
                                                                      i];
                                                          List<
                                                                  GlobalKey<
                                                                      State<
                                                                          StatefulWidget>>>
                                                              popMenuKeys =
                                                              List.generate(
                                                            Notverifyed.length,
                                                            (index) =>
                                                                GlobalKey(),
                                                          );
                                                          if (mydate
                                                              .isNotEmpty) {
                                                            if (mydate.contains(
                                                                NotverifyedData
                                                                    .date)) {
                                                              return ((temp2 *
                                                                              10) -
                                                                          10 +
                                                                          i >=
                                                                      documentlength2)
                                                                  ? const SizedBox()
                                                                  : SizedBox(
                                                                      width: width /
                                                                          1.2288,
                                                                      height: height /
                                                                          13.4363,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                width / 19.2,
                                                                            height:
                                                                                height / 14.78,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: "${i + 1}",
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width / 9.38857,
                                                                            height:
                                                                                height / 14.78,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: NotverifyedData.positions.toString(),
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width / 7.38857,
                                                                            height:
                                                                                height / 14.78,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: NotverifyedData.title.toString(),
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width / 4.38857,
                                                                            height:
                                                                                height / 14.78,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: NotverifyedData.description.toString(),
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
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
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: NotverifyedData.date.toString(),
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width / 16.0,
                                                                            height:
                                                                                height / 14.78,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: KText(
                                                                                text: NotverifyedData.LastDate.toString(),
                                                                                style: SafeGoogleFont(
                                                                                  'Nunito',
                                                                                  color: const Color(0xff030229),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: width / 17.6,
                                                                              height: height / 14.78,
                                                                              child: NotverifyedData.verify == true
                                                                                  ? const Icon(
                                                                                      Icons.verified,
                                                                                      color: Colors.green,
                                                                                    )
                                                                                  : const Icon(
                                                                                      Icons.verified_outlined,
                                                                                    )),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Popupmenu(context, NotverifyedData, popMenuKeys[i], size);
                                                                            },
                                                                            child: SizedBox(
                                                                                key: popMenuKeys[i],
                                                                                width: width / 18.36,
                                                                                height: height / 14.78,
                                                                                child: const Icon(Icons.more_horiz)),
                                                                          ),
                                                                        ],
                                                                      ));
                                                            }
                                                          } else if (mydate
                                                              .isEmpty) {
                                                            return ((temp2 *
                                                                            10) -
                                                                        10 +
                                                                        i >=
                                                                    documentlength2)
                                                                ? const SizedBox()
                                                                : SizedBox(
                                                                    width: width /
                                                                        1.2288,
                                                                    height: height /
                                                                        13.4363,
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
                                                                              text: "${i + 1}",
                                                                              style: SafeGoogleFont(
                                                                                'Nunito',
                                                                                color: const Color(0xff030229),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width / 9.38857,
                                                                          height:
                                                                              height / 14.78,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 8),
                                                                            child:
                                                                                KText(
                                                                              text: NotverifyedData.positions.toString(),
                                                                              style: SafeGoogleFont(
                                                                                'Nunito',
                                                                                color: const Color(0xff030229),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width / 7.38857,
                                                                          height:
                                                                              height / 14.78,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 8),
                                                                            child:
                                                                                KText(
                                                                              text: NotverifyedData.title.toString(),
                                                                              style: SafeGoogleFont(
                                                                                'Nunito',
                                                                                color: const Color(0xff030229),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width / 4.38857,
                                                                          height:
                                                                              height / 14.78,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 8),
                                                                            child:
                                                                                KText(
                                                                              text: NotverifyedData.description.toString(),
                                                                              style: SafeGoogleFont(
                                                                                'Nunito',
                                                                                color: const Color(0xff030229),
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
                                                                              text: NotverifyedData.date.toString(),
                                                                              style: SafeGoogleFont(
                                                                                'Nunito',
                                                                                color: const Color(0xff030229),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width / 16.0,
                                                                          height:
                                                                              height / 14.78,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 8),
                                                                            child:
                                                                                KText(
                                                                              text: NotverifyedData.LastDate.toString(),
                                                                              style: SafeGoogleFont(
                                                                                'Nunito',
                                                                                color: const Color(0xff030229),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width: width /
                                                                                17.6,
                                                                            height:
                                                                                height / 14.78,
                                                                            child: NotverifyedData.verify == true
                                                                                ? const Icon(
                                                                                    Icons.verified,
                                                                                    color: Colors.green,
                                                                                  )
                                                                                : const Icon(
                                                                                    Icons.verified_outlined,
                                                                                  )),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Popupmenu(
                                                                                context,
                                                                                NotverifyedData,
                                                                                popMenuKeys[i],
                                                                                size);
                                                                          },
                                                                          child: SizedBox(
                                                                              key: popMenuKeys[i],
                                                                              width: width / 18.36,
                                                                              height: height / 14.78,
                                                                              child: const Icon(Icons.more_horiz)),
                                                                        ),
                                                                      ],
                                                                    ));
                                                          }
                                                          return const SizedBox();
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width / 1.2418,
                                                      child: Stack(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                height / 13.02,
                                                            child: ListView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis
                                                                            .horizontal,
                                                                    itemCount:
                                                                        pagecount2,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            temp2 =
                                                                                list2[index];
                                                                          });
                                                                          print(
                                                                              temp2);
                                                                        },
                                                                        child: Container(
                                                                            height: 30,
                                                                            width: 30,
                                                                            margin: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: temp2.toString() == list2[index].toString() ? Constants().primaryAppColor : Colors.transparent),
                                                                            child: Center(
                                                                              child: Text(
                                                                                list2[index].toString(),
                                                                                style: SafeGoogleFont('Nunito', fontWeight: FontWeight.w700, color: temp2.toString() == list2[index].toString() ? Colors.white : Colors.black),
                                                                              ),
                                                                            )),
                                                                      );
                                                                    }),
                                                          ),
                                                          temp2 > 1
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              150.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        temp2 =
                                                                            temp2 -
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
                                                                              fontWeight: FontWeight.w700,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        )),
                                                                  ),
                                                                )
                                                              : Container(),
                                                          Container(
                                                            child: temp2 <
                                                                    pagecount2
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
                                                                          temp2 =
                                                                              temp2 + 1;
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                          height: height / 16.275,
                                                                          width: width / 11.3833,
                                                                          decoration: BoxDecoration(color: Constants().primaryAppColor, borderRadius: BorderRadius.circular(80)),
                                                                          child: Center(
                                                                            child:
                                                                                Text(
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
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        )
                      : Container(),
              SizedBox(height: height / 65.1),
              const DeveloperCardWidget(),
              SizedBox(height: height / 65.1),
            ],
          ),
        ),
      )),
    );
  }

  countValue(elseIValue) {
    return elseIValue = elseIValue + 1;
  }

  viewPopup(JobPostModel jobPost) {
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
                const BoxShadow(
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
                          "Post Details",
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
                    decoration: const BoxDecoration(
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
                                image: NetworkImage(jobPost.imgUrl!),
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
                                          text: "Post Name",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 95.375),
                                        ),
                                      ),
                                      const Text(":"),
                                      SizedBox(width: width / 68.3),
                                      KText(
                                        text: jobPost.title!,
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
                                          text: "Position",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 95.375),
                                        ),
                                      ),
                                      const Text(":"),
                                      SizedBox(width: width / 68.3),
                                      Text(
                                        jobPost.positions!,
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
                                      const Text(":"),
                                      SizedBox(width: width / 68.3),
                                      KText(
                                        text: jobPost.location!,
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
                                          text: "Last Date",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 95.375),
                                        ),
                                      ),
                                      const Text(":"),
                                      SizedBox(width: width / 68.3),
                                      KText(
                                        text: jobPost.LastDate!,
                                        style: SafeGoogleFont('Poppins',
                                            fontSize: width / 105.571),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height / 32.55),
                                  SizedBox(
                                    height: 50,
                                    child: Row(
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
                                        const Text(":"),
                                        SizedBox(width: width / 68.3),
                                        Expanded(
                                          child: KText(
                                            text: jobPost.description!,
                                            maxLines: 2,
                                            style: SafeGoogleFont('Poppins',
                                                fontSize: width / 105.571),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: height / 32.55),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.15,
                                        child: KText(
                                          text: "No Of Openings",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 95.375),
                                        ),
                                      ),
                                      const Text(":"),
                                      SizedBox(width: width / 68.3),
                                      KText(
                                        text: jobPost.openings.toString(),
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
                                          text: "Posted By",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 95.375),
                                        ),
                                      ),
                                      const Text(":"),
                                      SizedBox(width: width / 68.3),
                                      Text(
                                        jobPost.userName!,
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
                                          text: "User Occupation",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 95.375),
                                        ),
                                      ),
                                      const Text(":"),
                                      SizedBox(width: width / 68.3),
                                      Text(
                                        jobPost.UserOccupation!,
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
                                          text: "Date",
                                          style: SafeGoogleFont('Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 95.375),
                                        ),
                                      ),
                                      const Text(":"),
                                      SizedBox(width: width / 68.3),
                                      Text(
                                        jobPost.date!,
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
                                      const Text(":"),
                                      SizedBox(width: width / 68.3),
                                      Text(
                                        jobPost.time!,
                                        style: SafeGoogleFont('Poppins',
                                            fontSize: width / 105.571),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height / 32.55),
                                  InkWell(
                                    onTap: () async {
                                      cf.FirebaseFirestore.instance
                                          .collection('JobPosts')
                                          .doc(jobPost.id)
                                          .update({
                                        "verify": jobPost.verify == true
                                            ? false
                                            : true
                                      });
                                      var Userdata = await cf
                                          .FirebaseFirestore.instance
                                          .collection("Users")
                                          .orderBy("timestamp")
                                          .get();
                                      for (int x = 0;
                                          x < Userdata.docs.length;
                                          x++) {
                                        cf.FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(Userdata.docs[x].id)
                                            .collection("Posted_Jobs")
                                            .doc(jobPost.id)
                                            .update({
                                          "verify": jobPost.verify == true
                                              ? false
                                              : true
                                        });
                                      }

                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: height / 16.275,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: jobPost.verify == true
                                            ? Colors.red
                                            : Colors.green,
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
                                            text: jobPost.verify == true
                                                ? "Un Verify"
                                                : "Verify",
                                            style: SafeGoogleFont('Poppins',
                                                fontSize: width / 105.375,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
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
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.black,
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

  editPopUp(JobPostModel jobPost, Size size) {
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
              height: height * 0.9,
              margin: EdgeInsets.symmetric(
                  horizontal: width / 68.3, vertical: height / 32.55),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(
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
                          horizontal: width / 68.3, vertical: height / 81.375),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: "EDIT POST",
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: width / 88.3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          /*Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (titleController.text != "" &&
                                      dateController.text != "" &&
                                      timeController.text != "" ) {
                                    Response response =
                                    await JobPostFireCrud.updateRecord(
                                        JobPostModel(
                                          id: jobPost.id,
                                          title: titleController.text,
                                          imgUrl: jobPost.imgUrl,
                                          timestamp: jobPost.timestamp,
                                          views: jobPost.views,
                                          time: timeController.text,
                                          location: locationController.text,
                                          description:
                                          descriptionController.text,
                                          date: dateController.text,
                                          registeredUsers:
                                          jobPost.registeredUsers,
                                        ),
                                        profileImage,
                                        jobPost.imgUrl ?? "");
                                    if (response.code == 200) {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.success,
                                          text: "Post updated successfully!",
                                          width: size.width * 0.4,
                                          backgroundColor: Constants()
                                              .primaryAppColor
                                              .withOpacity(0.8));
                                      setState(() {
                                        locationController.text = "";
                                        descriptionController.text = "";
                                        titleController.text = "";
                                        uploadedImage = null;
                                        profileImage = null;
                                      });
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    } else {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          text: "Failed to update Post!",
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
                                        text: "Please fill the required fields",
                                        width: size.width * 0.4,
                                        backgroundColor: Constants()
                                            .primaryAppColor
                                            .withOpacity(0.8));
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
                                        text: "UPDATE",
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width / 105.375,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: width / 136.6),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    locationController.text = "";
                                    descriptionController.text = "";
                                    titleController.text = "";
                                    uploadedImage = null;
                                    profileImage = null;
                                  });
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
                                        text: "CANCEL",
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width / 105.375,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )*/
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xffF7FAFC),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 68.3, vertical: height / 32.55),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: "Position",
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
                                            color: const Color(0xffDDDEEE),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: height / 16.02,
                                              width: size.width * 0.17,
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
                                                  minLines: 1,
                                                  controller:
                                                      positionsController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 54.64),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: "Qualification *",
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
                                              color: const Color(0xffDDDEEE),
                                              elevation: 5,
                                              child: SizedBox(
                                                height: height / 16.02,
                                                width: size.width * 0.17,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: height / 81.375,
                                                      horizontal:
                                                          width / 170.75),
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
                                                    minLines: 1,
                                                    controller:
                                                        quvalificationController,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      border: InputBorder.none,
                                                      hintStyle: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize:
                                                            width / 105.571,
                                                      ),
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
                                  SizedBox(height: height / 65.1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: "Location",
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
                                            color: const Color(0xffDDDEEE),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: height / 16.02,
                                              width: size.width * 0.17,
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
                                                  minLines: 1,
                                                  controller:
                                                      locationController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 54.64),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: "No of openings *",
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
                                              color: const Color(0xffDDDEEE),
                                              elevation: 5,
                                              child: SizedBox(
                                                height: height / 16.02,
                                                width: size.width * 0.17,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: height / 81.375,
                                                      horizontal:
                                                          width / 170.75),
                                                  child: TextFormField(
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp("[0-9 ]")),
                                                    ],
                                                    style: SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: width / 105.571,
                                                    ),
                                                    minLines: 1,
                                                    controller:
                                                        noOfOpeningController,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      border: InputBorder.none,
                                                      hintStyle: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize:
                                                            width / 105.571,
                                                      ),
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
                                  SizedBox(height: height / 65.1),
                                  const Row(
                                    children: [
                                      /*   Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: "Date *",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              fontSize: width / 97.571,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: height / 108.5),
                                          Material(
                                            borderRadius: BorderRadius.circular(3),
                                            color: Color(0xffDDDEEE),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: height / 16.275,
                                              width: width / 9.106,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height / 81.375,
                                                    horizontal: width / 170.75),
                                                child: TextFormField(
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
                                                            formatter
                                                                .format(pickedDate);
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
                                              fontSize: width / 97.571,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: height / 108.5),
                                          Material(
                                            borderRadius: BorderRadius.circular(3),
                                            color: Color(0xffDDDEEE),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: height / 16.275,
                                              width: width / 9.106,
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
                                                      fontSize: width / 97.571,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: width / 68.3),*/
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
                                            text: "Title *",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              fontSize: width / 97.571,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: height / 108.5),
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: const Color(0xffDDDEEE),
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
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 1,
                                                  maxLines: 5,
                                                  controller: titleController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    border: InputBorder.none,
                                                    hintStyle: SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: width / 97.571,
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
                                              fontSize: width / 97.571,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          // SizedBox(height: height / 108.5),
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: const Color(0xffDDDEEE),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: height / 6.510,
                                              width: size.width * 0.36,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height / 81.375,
                                                    horizontal: width / 170.75),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 1,
                                                  maxLines: 5,
                                                  controller:
                                                      descriptionController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    border: InputBorder.none,
                                                    hintText: "",
                                                    hintStyle: SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: width / 97.571,
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
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: width / 2.2925,
                                ),

                                /// Update Button
                                GestureDetector(
                                  onTap: () async {
                                    if (titleController.text != "" &&
                                        dateController.text != "" &&
                                        timeController.text != "") {
                                      Response response =
                                          await JobPostFireCrud.updateRecord(
                                        JobPostModel(
                                          verify: jobPost.verify,
                                          id: jobPost.id,
                                          title: titleController.text,
                                          imgUrl: jobPost.imgUrl,
                                          timestamp: jobPost.timestamp,
                                          views: jobPost.views,
                                          time: timeController.text,
                                          location: locationController.text,
                                          description:
                                              descriptionController.text,
                                          date: dateController.text,
                                          registeredUsers:
                                              jobPost.registeredUsers,
                                          openings: int.parse(
                                              noOfOpeningController.text
                                                          .toString() ==
                                                      ""
                                                  ? "1"
                                                  : noOfOpeningController.text
                                                      .toString()),
                                          userName: 'Admin',
                                          Batch: 'Admin',
                                          UserOccupation: 'Admin',
                                          quvalification:
                                              quvalificationController.text,
                                          positions: positionsController.text,
                                        ),
                                        profileImage,
                                        jobPost.imgUrl ?? "",
                                      );
                                      if (response.code == 200) {
                                        CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.success,
                                            text: "Post updated successfully!",
                                            width: size.width * 0.4,
                                            backgroundColor: Constants()
                                                .primaryAppColor
                                                .withOpacity(0.8));
                                        setState(() {
                                          locationController.text = "";
                                          titleController.text = "";
                                          descriptionController.text = "";
                                          titleController.text = "";
                                          uploadedImage = null;
                                          profileImage = null;
                                        });
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      } else {
                                        CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Failed to update Post!",
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
                                  },
                                  child: Container(
                                      height: height / 18.475,
                                      width: width / 12.8,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffD60A0B),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: KText(
                                          text: 'Update',
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: width / 96,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xffFFFFFF),
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
                                      uploadedImage = null;
                                      profileImage = null;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      height: height / 18.475,
                                      width: width / 12.8,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff00A0E3),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: KText(
                                          text: 'Cancel',
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: width / 96,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xffFFFFFF),
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

  convertToCsv(List<JobPostModel> jobPost) async {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("No.");
    row.add("Post Name");
    row.add("Posted By");
    row.add("Date");
    row.add("Time");
    row.add("Location");
    row.add("Description");
    rows.add(row);
    for (int i = 0; i < jobPost.length; i++) {
      List<dynamic> row = [];
      row.add(i + 1);
      row.add(jobPost[i].title!);
      row.add(jobPost[i].userName!);
      row.add(jobPost[i].date!);
      row.add(jobPost[i].time!);
      row.add(jobPost[i].location!);
      row.add(jobPost[i].description!);
      rows.add(row);
    }
    String csv = const ListToCsvConverter().convert(rows);
    // saveCsvToFile(csv);
  }

  convertToPdf(List<JobPostModel> jobPost) async {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("No.");
    row.add("Post Name");
    row.add("Posted By");
    row.add("Date");
    row.add("Time");
    row.add("Location");
    row.add("Description");
    rows.add(row);
    for (int i = 0; i < jobPost.length; i++) {
      List<dynamic> row = [];
      row.add(i + 1);
      row.add(jobPost[i].title!);
      row.add(jobPost[i].userName!);
      row.add(jobPost[i].date!);
      row.add(jobPost[i].time!);
      row.add(jobPost[i].location!);
      row.add(jobPost[i].description!);
      rows.add(row);
    }
    print(row);
    print("dynamic list++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    String pdf = const ListToCsvConverter().convert(rows);
    // savePdfToFile(pdf);
  }

  // void saveCsvToFile(csvString) async {
  //   final blob = Blob([Uint8List.fromList(csvString.codeUnits)]);
  //   final url = Url.createObjectUrlFromBlob(blob);
  //   final anchor = AnchorElement(href: url)
  //     ..setAttribute("download", "JobPost.csv")
  //     ..click();
  //   Url.revokeObjectUrl(url);
  // }
  //
  // void savePdfToFile(data) async {
  //   final blob = Blob([data], 'application/pdf');
  //   final url = Url.createObjectUrlFromBlob(blob);
  //   final anchor = AnchorElement(href: url)
  //     ..setAttribute("download", "jobPost.pdf")
  //     ..click();
  //   Url.revokeObjectUrl(url);
  // }

  copyToClipBoard(List<JobPostModel> jobPost) async {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("No.");
    row.add("    ");
    row.add("Post Name");
    row.add("    ");
    row.add("Posted By");
    row.add("    ");
    row.add("Date");
    row.add("    ");
    row.add("Time");
    row.add("    ");
    row.add("Location");
    row.add("    ");
    row.add("Description");
    rows.add(row);
    for (int i = 0; i < jobPost.length; i++) {
      List<dynamic> row = [];
      row.add(i + 1);
      row.add("       ");
      row.add(jobPost[i].title);
      row.add("       ");
      row.add(jobPost[i].userName);
      row.add("       ");
      row.add(jobPost[i].date);
      row.add("       ");
      row.add(jobPost[i].time);
      row.add("       ");
      row.add(jobPost[i].location);
      row.add("       ");
      row.add(jobPost[i].description);
      rows.add(row);
    }
    String csv = const ListToCsvConverter().convert(rows,
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
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Constants().primaryAppColor, width: 3),
          boxShadow: [
            const BoxShadow(
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
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Please fill required fields !!',
                  style: SafeGoogleFont('Poppins', color: Colors.black)),
            ),
            const Spacer(),
            TextButton(
                onPressed: () => debugPrint("Undid"), child: const Text("Undo"))
          ],
        )),
  );

  TimeOfDay _selectedTime = TimeOfDay.now();

  /* Future<void> _selectTime(BuildContext context) async {
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
  }*/

  Popupmenu(BuildContext context, jobPost, key, size) async {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final render = key.currentContext!.findRenderObject() as RenderBox;
    await showMenu(
      color: const Color(0xffFFFFFF),
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
                      dateController.text = jobPost.date!;
                      titleController.text = jobPost.title!;
                      timeController.text = jobPost.time!;
                      locationController.text = jobPost.location!;
                      descriptionController.text = jobPost.description!;
                      quvalificationController.text = jobPost.quvalification;
                      positionsController.text = jobPost.positions;
                      selectedImg = jobPost.imgUrl;
                    });

                    print("Edit __________________________________________");
                    print(selectedImg);
                    print(dateController.text);
                    print(titleController.text);
                    print(timeController.text);
                    print(locationController.text);
                    print(descriptionController.text);
                    print(quvalificationController.text);
                    print(positionsController.text);
                    editPopUp(jobPost, size);
                  } else if (item == "Delete") {
                    JobPostFireCrud.deleteRecord(id: jobPost.id);
                  } else if (item == "View") {
                    viewPopup(jobPost);
                  } else if (item == "Verify") {
                    cf.FirebaseFirestore.instance
                        .collection('JobPosts')
                        .doc(jobPost.id)
                        .update({"verify": !jobPost.verify});

                    var Userdata = await cf.FirebaseFirestore.instance
                        .collection("Users")
                        .orderBy("timestamp")
                        .get();

                    for (int x = 0; x < Userdata.docs.length; x++) {
                      cf.FirebaseFirestore.instance
                          .collection("Users")
                          .doc(Userdata.docs[x].id)
                          .collection("Posted_Jobs")
                          .doc(jobPost.id)
                          .update({"verify": !jobPost.verify});
                    }
                  }
                },
                value: item,
                child: Container(
                  height: height / 18.475,
                  decoration: BoxDecoration(
                      color: item == "Edit"
                          ? const Color(0xff5B93FF).withOpacity(0.6)
                          : item == "View"
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
                            )
                          : item == "View"
                              ? const Icon(
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

  menuItemExportData(BuildContext context, jobPost, key, size) async {
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
                    print(jobPost.first.title);
                    print(
                        "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11");
                    var data = await generateJobPostPdf(
                        PdfPageFormat.letter, jobPost, false);
                  } else if (item == "Copy") {
                    print(exportdataListFromStream.length);
                    print(jobPost.length);
                    print(
                        "222222222222222222222222222222222222222222222222222222222222222222222222222");
                    copyToClipBoard(jobPost);
                  } else if (item == "Csv") {
                    print(exportdataListFromStream.length);
                    print(jobPost.length);
                    print(
                        "333333333333333333333333333333333333333333333333333333333333333333333");
                    convertToCsv(jobPost);
                  }
                },
                value: item,
                child: Material(
                  color: item == "Print"
                      ? const Color(0xff5B93FF)
                      : item == "Copy"
                          ? const Color(0xffE71D36)
                          : item == "Csv"
                              ? Colors.green
                              : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  shadowColor: Colors.black12,
                  elevation: 10,
                  child: Container(
                    height: height / 18.475,
                    decoration: BoxDecoration(
                        color: item == "Print"
                            ? const Color(0xff5B93FF)
                            : item == "Copy"
                                ? const Color(0xffE71D36)
                                : item == "Csv"
                                    ? Colors.green
                                    : Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        item == "Print"
                            ? const Icon(
                                Icons.print,
                                color: Colors.white,
                                size: 18,
                              )
                            : item == "Copy"
                                ? const Icon(
                                    Icons.copy,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : item == "Csv"
                                    ? const Icon(
                                        Icons.file_copy_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : const Icon(
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
                          ? const Icon(
                              Icons.print,
                              color: Color(0xff5B93FF),
                              size: 18,
                            )
                          : const Icon(
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

  _submitData1() {
    // String idGenerator() {
    //   final now = DateTime.now();
    //   return now.microsecondsSinceEpoch.toString();
    // }

    final rs = RandomString();
    String documentid = rs.getRandomString();
    FirebaseFirestore.instance.collection("JobPosts").doc(documentid).set({
      "Batch": "Admin",
      "views": [],
      "verify": [],
      "userName": "",
      "uploadTime": timeController.text,
      "title": titleController.text,
      "timestamp": Timestamp.now().microsecondsSinceEpoch,
      "subtitle": "",
      "registeredUsers": "",
      "quvalification": quvalificationController.text,
      "positions": positionsController.text,
      "openings": noOfOpeningController.text,
      "location": locationController.text,
      "img": "",
      "id": "",
      "date": dateController.text,
      "UserOccupation": "Admin",
      "LastDate": lastDateController.text,
      "Batch": "Admin",
    });

    FirebaseFirestore.instance.collection('Post').doc(documentid).set({
      'jposttitle': titleController.text,
      'jpostdate': dateController.text,
      'jpostlocation': locationController.text,
      'jpostdescription': descriptionController.text,
      "jpostimageurl": "",
      "jposttime": timeController.text,
      "jpostposition": positionsController.text,
      "jpostopening": noOfOpeningController.text,
      "jpostqualification": quvalificationController.text,
      "jpostlastdate": lastDateController.text,
      'timestamp': Timestamp.now().microsecondsSinceEpoch,
      "types": "jobpost",
      "register": [],
      "likes": [],
      "views": [],
      "name": name,
      "userimage": image,
      "exp": expController.text,
      "company": companyController.text,
    });
  }

  String name = "";
  String image = "";
  getdocid() async {
    var doc =
        await FirebaseFirestore.instance.collection("AlumniDetails").get();
    for (int i = 0; i < doc.docs.length; i++) {
      if (doc.docs[i]["name"] != "") {
        print(doc.docs[i]["logo"]);
        setState(() {
          name = doc.docs[i]["name"];
          image = doc.docs[i]["logo"];
        });
      }
    }
    print(image);
  }
  //  generateDocument() {
  //   CollectionReference collection = _firestore.collection('your_collection_name');
  //   DocumentReference docRef = collection.doc();
  //   String docId = docRef.id;
  //   // Use the generated document ID as needed
  //   print('Generated Firestore Document ID: $docId');
  // }
}
