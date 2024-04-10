import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:alumni_management_admin/Constant_.dart';
import 'package:alumni_management_admin/Events_Printing/Events_printing.dart';
import 'package:alumni_management_admin/Events_fireCrud/Events_firecrud.dart';
import 'package:alumni_management_admin/Models/Language_Model.dart';
import 'package:alumni_management_admin/Models/Response_Model.dart';
import 'package:alumni_management_admin/Models/event_model.dart';
import 'package:alumni_management_admin/common_widgets/developer_card_widget.dart';
import 'package:alumni_management_admin/utils.dart';
import 'package:animate_do/animate_do.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:cool_alert/cool_alert.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';

import '../common_widgets/loading_state.dart';

class EventsTab extends StatefulWidget {
  EventsTab({super.key});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> with SingleTickerProviderStateMixin {
  late AnimationController lottieController;
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime? dateRangeStart;
  DateTime? dateRangeEnd;
  bool isFiltered = false;

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
    //"View",
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

  @override
  void initState() {
    doclength();
    setDateTime();
    lottieController = AnimationController(vsync: this);
    lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        lottieController.reset();
      }
    });
    super.initState();
  }

  bool filtervalue = true;
  String filterChageValue = "timestampmain";
  GlobalKey ExportDataKeys = GlobalKey();
  GlobalKey filterDataKey = GlobalKey();
  int pagecount = 0;
  int temp = 1;
  List list = new List<int>.generate(1000, (i) => i + 1);
  List <cf.DocumentSnapshot>documentList = [];
  int documentlength =0 ;

  doclength() async {
    try {
      // Fetch documents from the "Batch_events" collection
      final cf.QuerySnapshot result = await cf.FirebaseFirestore.instance.collection("Batch_events").get();

      // Extract a list of DocumentSnapshots from the QuerySnapshot
      final List<cf.DocumentSnapshot> documents = result.docs;

      // Update state variables
      setState(() {
        // Set the documentlength variable to the length of the documents list
        documentlength = documents.length;

        // Calculate the pagecount based on the documentlength (assuming 10 documents per page)
        pagecount = ((documentlength - 1) ~/ 10) + 1;
      });

      // Print information for debugging
      print(pagecount);
      print(documentlength);
      print("Document Total Length+++++++++++++++++++++++++++++++++++++++++++++++++");
    } catch (e) {
      // Handle any errors that might occur during the Firestore query
      print("Error fetching documents: $e");
    }
  }

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double baseWidth = 1920;
    double fem = MediaQuery
        .of(context)
        .size
        .width / baseWidth;
    double ffem = fem * 0.97;
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
                        text: "EVENTS",
                        style: SafeGoogleFont('Nunito',
                            fontSize: width / 82.538,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height/92.375),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              print('Media Query ');
                              print(height);
                              print(width);
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
                              width: width/10.9714,
                              decoration: BoxDecoration(
                                color: Constants().primaryAppColor,
                                borderRadius: BorderRadius.circular(8),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          ? "Add Event"
                                          : "View Events",
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
                          padding: EdgeInsets.only(left: width/192),
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
                                width: width/10.9714,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                        currentTab.toUpperCase() == "ADD"?const SizedBox():Padding(
                          padding:  EdgeInsets.only(left: width/1.88),
                          child: InkWell(
                            key: filterDataKey,
                            onTap: () async {
                              if(dateRangeStart!=null){
                                setState(() {
                                  dateRangeStart=null;
                                  dateRangeEnd=null;
                                });

                              }
                              else{
                              filterDataMenuItem( context, filterDataKey, size);
                              }

                            },
                            child:
                            Container(
                              height: height / 16.275,
                              decoration: BoxDecoration(
                                color: Constants().primaryAppColor,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1, 2),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                              child:
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 227.66),
                                child: Row(
                                  children: [
                                    const Icon(Icons.filter_list_alt,color:Colors.white),
                                    KText(
                                      text: dateRangeStart==null?"Filter by Date":"Back to Normal",
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: width / 120.571,
                                        color:Colors.white,
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
                ? Stack(
              alignment: Alignment.center,
                  children: [
                    Container(
                                  width: width / 1.26,
                                  height: height / 1.2336,
                                  decoration: BoxDecoration(
                    color: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 68.3, vertical: height / 81.375),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: "ADD NEW EVENT",
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: width / 98.3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: height / 1.4,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Color(0xffF7FAFC),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )),
                          padding: EdgeInsets.symmetric(
                              horizontal: width / 68.3, vertical: height / 32.55),
                          child: SingleChildScrollView(
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
                                                  color: const Color(0xffDDDEEE),
                                                  elevation: 5,
                                                  child: SizedBox(
                                                    height: height / 16.02,
                                                    width: width *0.17,
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
                                                        decoration: const InputDecoration(
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
                                            SizedBox(width: size.width*0.02),
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
                                                  color: const Color(0xffDDDEEE),
                                                  elevation: 5,
                                                  child: SizedBox(
                                                    height: height / 16.02,
                                                    width: width *0.17,
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
                                            //
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
                                                    height: height / 12,
                                                    width: size.width * 0.36,
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: height / 81.375,
                                                          horizontal: width / 170.75),
                                                      child: TextFormField(
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9 ]+$')),

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
                                                        validator: (val){



                                                        },
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
                                                  BorderRadius.circular(3),
                                                  color: const Color(0xffDDDEEE),
                                                  elevation: 5,
                                                  child: SizedBox(
                                                    height: height / 12,
                                                    width: size.width * 0.36,
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: height / 81.375,
                                                          horizontal: width / 170.75),
                                                      child: TextFormField(
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9 ]*')),
                                                        ],
                                                        style: SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: width / 105.571,
                                                        ),
                                                        textAlign: TextAlign.start, // Adjust as needed
                                                        textAlignVertical: TextAlignVertical.center,
                                                        keyboardType:
                                                        TextInputType.multiline,
                                                        minLines: 1,
                                                        maxLines: null,
                                                        controller: locationController,
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
                                            image: uploadedImage != null
                                                ? DecorationImage(
                                              fit: BoxFit.fill,
                                              image: MemoryImage(
                                                Uint8List.fromList(
                                                  base64Decode(uploadedImage!
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
                                  padding:  EdgeInsets.only(top:height/7.39),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: width/2.2925,
                                      ),

                                      ///Save  button

                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            isloading=true;
                                          });
                                          bool titlecheck = false;
                                          try{
                                            int a = int.parse(titleController.text);
                                            print("number");
                                            setState(() {
                                              titlecheck = true;
                                            });

                                          }
                                          catch(e){
                                            print("correct");
                                            setState(() {
                                              titlecheck = false;
                                            });

                                          }
                                          if(titlecheck == false) {
                                            if (dateController.text != "" &&
                                                timeController.text != "" &&
                                                locationController.text != "") {

                                              Response response =
                                              await EventsFireCrud.addEvent(
                                                title: titleController.text,
                                                time: timeController.text,
                                                location: locationController.text,
                                                image: profileImage,
                                                description: descriptionController
                                                    .text,
                                                date: dateController.text,
                                              );
                                              doclength();
                                              setDateTime();
                                              if (response.code == 200) {
                                                setState(() {
                                                  isloading=false;
                                                });
                                                CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.success,
                                                    text: "Event created successfully!",
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
                                                  currentTab = 'View';
                                                });
                                              } else {
                                                CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.error,
                                                    text: "Failed to Create Event!",
                                                    width: size.width * 0.4,
                                                    backgroundColor: Constants()
                                                        .primaryAppColor
                                                        .withOpacity(0.8));
                                              }
                                            } else {
                                              setState(() {
                                                isloading=false;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          }
                                          else{
                                            setState(() {
                                              isloading=false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.transparent,
                                              elevation: 0,
                                              content: Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Constants().primaryAppColor, width: 3),
                                                    boxShadow: const [
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
                                                        padding: const EdgeInsets.only(left: 8.0),
                                                        child: Text('Title should contain at least one alphabet !!',
                                                            style: SafeGoogleFont('Poppins', color: Colors.black)),
                                                      ),
                                                      const Spacer(),
                                                      TextButton(
                                                          onPressed: () => debugPrint("Undid"), child: const Text("Undo"))
                                                    ],
                                                  )),
                                            ));
                                          }
                                        },
                                        child: Container(
                                            height: height/18.475,
                                            width: width/12.8,
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
                                                  fontSize: width/96,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: const Color(0xffFFFFFF),
                                                ),
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        width: width/76.8,
                                      ),

                                      ///Reset Button
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            locationController.text = "";
                                            descriptionController.text = "";
                                            titleController.text = "";
                                            uploadedImage = null;
                                            profileImage = null;
                                          });
                                        },
                                        child: Container(
                                            height: height/18.475,
                                            width: width/12.8,
                                            decoration: BoxDecoration(
                                              color: const Color(0xff00A0E3),
                                              borderRadius:
                                              BorderRadius.circular(4),
                                            ),
                                            child: Center(
                                              child: KText(
                                                text: 'Reset',
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  fontSize: width/96,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: const Color(0xffFFFFFF),
                                                ),
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        width: width/76.8,
                                      ),

                                      ///back Button
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            locationController.text = "";
                                            descriptionController.text = "";
                                            titleController.text = "";
                                            uploadedImage = null;
                                            profileImage = null;
                                            currentTab = 'View';
                                          });
                                        },
                                        child: Container(
                                            height: height/18.475,
                                            width: width/12.8,
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
                                                  fontSize: width/96,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: const Color(0xffFFFFFF),
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
                      ),
                    ],
                                  ),
                                ),
                    isloading? Container(child:LoadingState()): SizedBox()
                  ],
                )


                : currentTab.toUpperCase() == "VIEW"
                    ? dateRangeStart != null
                        ? Column(
                          children: [
                            Container(
                                color: Colors.white,
                                width: width / 1.2418,
                                height: height/13.4363,
                                child: Row(
                                  children: [
                                    // sno
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
                                              text: "SL.No",
                                              style: SafeGoogleFont(
                                                'Nunito',
                                                color: const Color(0xff030229),
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
                                    // event name
                                    Container(
                                      color: Colors.white,
                                      width: width/9.6,
                                      height: height/14.78,
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            KText(
                                              text: "Event Name",
                                              style: SafeGoogleFont(
                                                'Nunito',
                                                color: const Color(0xff030229),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(
                                                  left: width/192),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    filtervalue = !filtervalue;
                                                    filterChageValue="title";
                                                  });
                                                },
                                                child: Transform.rotate(
                                                  angle: filterChageValue=="title"&&filtervalue ? 200 : 0,
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
                                                          color:filtervalue ==true&&
                                                              filterChageValue=="title"?Colors.green:Colors.transparent
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
                                    // register user
                                    Container(
                                      color: Colors.white,
                                      width: width/9.6,
                                      height: height/14.78,
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            KText(
                                              text: "Register Users",
                                              style: SafeGoogleFont(
                                                'Nunito',
                                                color: const Color(0xff030229),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(
                                                  left: width/192),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    filtervalue = !filtervalue;
                                                    filterChageValue="registeredUsers";
                                                  });
                                                },
                                                child: Transform.rotate(
                                                  angle: filterChageValue=="registeredUsers"&&filtervalue ? 200 : 0,
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
                                                          color:filtervalue ==true&&
                                                              filterChageValue=="registeredUsers"?Colors.green:Colors.transparent
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
                                    // venue
                                    Container(
                                      color: Colors.white,
                                      width: width/9.6,
                                      height: height/14.78,
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            KText(
                                              text: "venue",
                                              style: SafeGoogleFont(
                                                'Nunito',
                                                color: const Color(0xff030229),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(
                                                  left: width/192),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    filtervalue = !filtervalue;
                                                    filterChageValue="location";
                                                  });
                                                },
                                                child: Transform.rotate(
                                                  angle: filterChageValue=="location"&&filtervalue ? 200 : 0,
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
                                                          color:filtervalue ==true&&
                                                              filterChageValue=="location"?Colors.green:Colors.transparent
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
                                    // description
                                    Container(
                                      color: Colors.white,
                                      width: width/6.3,
                                      height: height/14.78,
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
                                                color: const Color(0xff030229),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(
                                                  left: width/192),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    filtervalue = !filtervalue;
                                                    filterChageValue="subtitle";
                                                  });
                                                },
                                                child: Transform.rotate(
                                                  angle: filterChageValue=="subtitle"&&filtervalue ? 200 : 0,
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
                                                          color:filtervalue ==true&&
                                                              filterChageValue=="subtitle"?Colors.green:Colors.transparent
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
                                    // created on
                                    Container(
                                      color: Colors.white,
                                      width: width/8,
                                      height: height/14.78,
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            KText(
                                              text: " Created On",
                                              style: SafeGoogleFont(
                                                'Nunito',
                                                color: const Color(0xff030229),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(
                                                  left: width/192),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    filtervalue = !filtervalue;
                                                    filterChageValue="date";
                                                  });
                                                },
                                                child: Transform.rotate(
                                                  angle: filterChageValue=="date"&&filtervalue ? 200 : 0,
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
                                                          color:filtervalue ==true&&
                                                              filterChageValue=="date"?Colors.green:Colors.transparent
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
                                    // actions
                                    SizedBox(
                                      width: width/12.36,
                                      height: height/14.78,
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            KText(
                                              text: "Actions",
                                              style: SafeGoogleFont(
                                                'Nunito',
                                                color: const Color(0xff030229),
                                              ),
                                            ),


                                            Padding(
                                              padding:  EdgeInsets.only(
                                                  left: width/192),
                                              child: InkWell(
                                                onTap: () {
                                                },
                                                child: Transform.rotate(
                                                  angle: filtervalue ? 200 : 0,
                                                  child: Opacity(
                                                    // arrowdown2TvZ (8:2307)
                                                    opacity: 0.7,
                                                    child: Container(
                                                      width: width/153.6,
                                                      height: height/73.9,
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
                              height: height/1.3436, width: width/1.2288,
                              child: StreamBuilder(
                                  stream: EventsFireCrud.fetchEventsWithFilter(dateRangeStart!, dateRangeEnd!),
                                  builder: (ctx, snapshot) {
                                    if (snapshot.hasError) {
                                      return Container();
                                    } else if (snapshot.hasData) {
                                      List<EventsModel> events = snapshot.data!;
                                      exportdataListFromStream = events;
                                      List<GlobalKey<State<StatefulWidget>>>popMenuKeys = List.generate(events.length, (index) => GlobalKey(),);
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: pagecount == temp ? events.length.remainder(10) == 0 ? 10 : events.length.remainder(10) : 10 ,
                                        itemBuilder: (ctx, i) {
                                          return SizedBox(
                                              width: width/1.2288,
                                              height: height/13.4363,
                                              child: Padding(
                                                padding:  EdgeInsets.only(left:width/170.75),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: width/19.2,
                                                      height: height/14.78,
                                                      child: Padding(
                                                        padding:
                                                         EdgeInsets.only(
                                                            left: width/192),
                                                        child: KText(
                                                          text: "${i + 1}",
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            color:
                                                            const Color(0xff030229),
                                                            // Colors.green
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                                events[i].imgUrl
                                                                    .toString()),
                                                          ),
                                                        ),
                                                        child: Center(
                                                            child:events[i].imgUrl
                                                                .toString() ==
                                                                ""
                                                                ? const Icon(
                                                                Icons
                                                                    .image)
                                                                : const Text("")
                                                        )
                                                    ),
                                                    SizedBox(
                                                      width: width/9.6,
                                                      height: height/14.78,
                                                      child: Padding(
                                                        padding:
                                                         EdgeInsets.only(
                                                            left: width/192),
                                                        child: KText(
                                                          text: events[i]
                                                              .title
                                                              .toString(),
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            color:
                                                            const Color(0xff030229),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width/9.6,
                                                      height: height/14.78,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                             EdgeInsets
                                                                .only(left: width/192),
                                                            child: KText(
                                                              text: events[i]
                                                                  .registeredUsers!
                                                                  .length
                                                                  .toString(),
                                                              style: SafeGoogleFont(
                                                                'Nunito',
                                                                color: const Color(
                                                                    0xff030229),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                             EdgeInsets
                                                                .only(left: width/192),
                                                            child:
                                                            const Icon(Icons.person),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width/9.6,
                                                      height: height/14.78,
                                                      child: Padding(
                                                        padding:
                                                         EdgeInsets.only(
                                                            left: width/192),
                                                        child: KText(
                                                          text: events[i]
                                                              .location
                                                              .toString(),
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            color:
                                                            const Color(0xff030229),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width/6.144,
                                                      height: height/14.78,
                                                      child: Padding(
                                                        padding:
                                                         EdgeInsets.only(
                                                            left: width/192),
                                                        child: KText(
                                                          text: events[i]
                                                              .description
                                                              .toString(),
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            color:
                                                            const Color(0xff030229),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width/9.6,
                                                      height: height/14.78,
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsets.only(
                                                            left: width/192),
                                                        child: KText(
                                                          text: events[i]
                                                              .date
                                                              .toString(),
                                                          style: SafeGoogleFont(
                                                            'Nunito',
                                                            color:
                                                            const Color(0xff030229),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Popupmenu(
                                                            context,
                                                            events[i],
                                                            popMenuKeys[i],
                                                            size);
                                                      },
                                                      child: SizedBox(
                                                          key: popMenuKeys[i],
                                                          width: width/15.36,
                                                          height: height/14.78,
                                                          child: const Icon(
                                                              Icons.more_horiz)),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                        },
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                            ),
                          ],
                        )
                        : Column(
                            children: [
                              Container(
                                  color: Colors.white,
                                  width: width / 1.2418,
                                  height: height/13.4363,
                                  child: Row(
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
                                                text: "SL.No",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color: const Color(0xff030229),
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
                                      Container(
                                        color: Colors.white,
                                        width: width/9.6,
                                        height: height/14.78,
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              KText(
                                                text: "Event Name",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color: const Color(0xff030229),
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(
                                                    left: width/192),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      filtervalue = !filtervalue;
                                                      filterChageValue="title";
                                                    });
                                                  },
                                                  child: Transform.rotate(
                                                    angle: filterChageValue=="title"&&filtervalue ? 200 : 0,
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
                                                            color:filtervalue ==true&&
                                                                filterChageValue=="title"?Colors.green:Colors.transparent
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
                                        width: width/9.6,
                                        height: height/14.78,
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              KText(
                                                text: "Register Users",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color: const Color(0xff030229),
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(
                                                    left: width/192),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      filtervalue = !filtervalue;
                                                      filterChageValue="registeredUsers";
                                                    });
                                                  },
                                                  child: Transform.rotate(
                                                    angle: filterChageValue=="registeredUsers"&&filtervalue ? 200 : 0,
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
                                                            color:filtervalue ==true&&
                                                                filterChageValue=="registeredUsers"?Colors.green:Colors.transparent
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
                                        width: width/9.6,
                                        height: height/14.78,
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              KText(
                                                text: "venue",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color: const Color(0xff030229),
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(
                                                    left: width/192),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      filtervalue = !filtervalue;
                                                      filterChageValue="location";
                                                    });
                                                  },
                                                  child: Transform.rotate(
                                                    angle: filterChageValue=="location"&&filtervalue ? 200 : 0,
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
                                                            color:filtervalue ==true&&
                                                                filterChageValue=="location"?Colors.green:Colors.transparent
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
                                        width: width/6.3,
                                        height: height/14.78,
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
                                                  color: const Color(0xff030229),
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(
                                                    left: width/192),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      filtervalue = !filtervalue;
                                                      filterChageValue="subtitle";
                                                    });
                                                  },
                                                  child: Transform.rotate(
                                                    angle: filterChageValue=="subtitle"&&filtervalue ? 200 : 0,
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
                                                            color:filtervalue ==true&&
                                                                filterChageValue=="subtitle"?Colors.green:Colors.transparent
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
                                        width: width/8,
                                        height: height/14.78,
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              KText(
                                                text: " Created On",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color: const Color(0xff030229),
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(
                                                    left: width/192),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      filtervalue = !filtervalue;
                                                      filterChageValue="date";
                                                    });
                                                  },
                                                  child: Transform.rotate(
                                                    angle: filterChageValue=="date"&&filtervalue ? 200 : 0,
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
                                                            color:filtervalue ==true&&
                                                                filterChageValue=="date"?Colors.green:Colors.transparent
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
                                      SizedBox(
                                        width: width/12.36,
                                        height: height/14.78,
                                        child: Center(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              KText(
                                                text: "Actions",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color: const Color(0xff030229),
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(
                                                    left: width/192),
                                                child: InkWell(
                                                  onTap: () {

                                                  },
                                                  child: Transform.rotate(
                                                    angle: filtervalue ? 200 : 0,
                                                    child: Opacity(
                                                      // arrowdown2TvZ (8:2307)
                                                      opacity: 0.7,
                                                      child: Container(
                                                        width: width/153.6,
                                                        height: height/73.9,

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
                                height: height/1.2,
                                width: width/1.2288,
                                child: Column(
                                  children: [
                                    StreamBuilder(
                                      stream: EventsFireCrud.fetchEvents(filter:filtervalue ,filterValue:filterChageValue ),
                                      builder: (ctx, snapshot) {
                                        if (snapshot.hasError) {
                                          return Container();
                                        } else if (snapshot.hasData) {
                                          List<EventsModel> events = snapshot.data!;
                                          exportdataListFromStream = events;
                                          List<GlobalKey<State<StatefulWidget>>>popMenuKeys = List.generate(events.length, (index) => GlobalKey(),);
                                          // Main Events
                                          return SingleChildScrollView(
                                            physics: const NeverScrollableScrollPhysics(),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height:height/1.35625,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemCount: pagecount == temp ? events.length.remainder(10) == 0 ? 10 : events.length.remainder(10) : 10 ,
                                                    itemBuilder: (ctx, i) {
                                                      var event=events[(temp*10)-10+i];
                                                      return
                                                        ((temp*10)-10+i >= documentlength)? const SizedBox():
                                                        SizedBox(
                                                          width: width/1.2288,
                                                          height: height/13.4363,
                                                          child: Padding(
                                                            padding:  EdgeInsets.only(left:width/170.75),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: width/19.2,
                                                                  // height: height/14.78,
                                                                  child: Padding(
                                                                    padding:
                                                                         EdgeInsets.only(
                                                                            left: width/192),
                                                                    child: KText(
                                                                      text: "${((temp*10)-10+i) + 1}",
                                                                      style: SafeGoogleFont(
                                                                        'Nunito',
                                                                        // color:
                                                                            // Color(0xff030229),
                                                                        // Colors.green
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
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
                                                                            events[i].imgUrl
                                                                                .toString()),
                                                                      ),
                                                                    ),
                                                                    child: Center(
                                                                        child:events[i].imgUrl
                                                                            .toString() ==
                                                                            ""
                                                                            ? const Icon(
                                                                            Icons
                                                                                .image)
                                                                            : const Text("")
                                                                    )
                                                                ),
                                                                SizedBox(
                                                                  width: width/9.6,
                                                                  // height: height/14.78,
                                                                  child: Padding(
                                                                    padding:
                                                                         EdgeInsets.only(
                                                                            left: width/192),
                                                                    child: KText(
                                                                      text: event.title
                                                                          .toString(),
                                                                      style: SafeGoogleFont(
                                                                        'Nunito',
                                                                        color:
                                                                            const Color(0xff030229),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                Container(
                                                                  // color: Colors.green,
                                                                  // width: width/9.6,
                                                                  width: 140,
                                                                  // height: height/20.78,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                             EdgeInsets
                                                                                .only(left: width/200),
                                                                        child: KText(
                                                                          text: event
                                                                              .registeredUsers!
                                                                              .length
                                                                              .toString(),
                                                                          style: SafeGoogleFont(
                                                                            'Nunito',
                                                                            color: const Color(
                                                                                0xff030229),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                             EdgeInsets
                                                                                .only(left: width/192),
                                                                        child:
                                                                            const Icon(Icons.person),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),


                                                                SizedBox(
                                                                  width: width/9.6,
                                                                  // height: height/14.78,
                                                                  child: Padding(
                                                                    padding:
                                                                         EdgeInsets.only(
                                                                            left: width/192),
                                                                    child: KText(
                                                                      text: event
                                                                          .location
                                                                          .toString(),
                                                                      style: SafeGoogleFont(
                                                                        'Nunito',
                                                                        color:
                                                                            const Color(0xff030229),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: width/6.144,
                                                                  // height: height/14.78,
                                                                  child: Padding(
                                                                    padding:
                                                                         EdgeInsets.only(
                                                                            left: width/192),
                                                                    child: KText(
                                                                      text: event
                                                                          .description
                                                                          .toString(),
                                                                      style: SafeGoogleFont(
                                                                        'Nunito',
                                                                        color:
                                                                            const Color(0xff030229),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: width/12.6,
                                                                  // height: height/14.78,
                                                                  child: Padding(
                                                                    padding:
                                                                    EdgeInsets.only(
                                                                        left: width/192),
                                                                    child: KText(
                                                                      text: event
                                                                          .date
                                                                          .toString(),
                                                                      style: SafeGoogleFont(
                                                                        'Nunito',
                                                                        color:
                                                                        const Color(0xff030229),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Popupmenu(
                                                                        context,
                                                                        event,
                                                                        popMenuKeys[i],
                                                                        size);
                                                                  },
                                                                  child: SizedBox(
                                                                      key: popMenuKeys[i],
                                                                      width: width/7.36,
                                                                      height: height/14.78,
                                                                      child: const Icon(
                                                                          Icons.more_horiz)),
                                                                ),
                                                              ],
                                                            ),
                                                          ));
                                                    },
                                                  ),
                                                ),







                                               Stack(
                                                  alignment: Alignment.centerRight,
                                                  children: [
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height:height/13.02,
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: pagecount,
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
                                                                  margin: const EdgeInsets.only(left:8,right:8,top:10,bottom:10),
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
                                            ),
                                          );
                                        }
                                        return Container();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                    : Container(),
                      SizedBox(height: height / 65.1),
                      const DeveloperCardWidget(),
                      SizedBox(height: height / 65.1),
                    ],
                  ),
          )),
    );
  }

  viewPopup(EventsModel event) {
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
                          event.location!,
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
                                image: NetworkImage(event.imgUrl!),
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
                                      const Text(":"),
                                      SizedBox(width: width / 68.3),
                                      Text(
                                        event.date!,
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
                                        event.time!,
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
                                        text: event.location!,
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
                                      const Text(":"),
                                      SizedBox(width: width / 68.3),
                                      KText(
                                        text: event.description!,
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
        return
          AlertDialog(
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
                    padding: EdgeInsets.symmetric(horizontal: width/76.8),
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
                            padding:  EdgeInsets.symmetric(
                              horizontal: width/192,
                              vertical: height/92.375
                            ),
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

  editPopUp(EventsModel event, Size size) {
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
              margin: EdgeInsets.symmetric(
                  horizontal: width / 68.3, vertical: height / 32.55),
              decoration: BoxDecoration(
                color: Colors.white,
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
                            text: "EDIT EVENT",
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
                                      timeController.text != "" &&
                                      locationController.text != "") {
                                    Response response =
                                        await EventsFireCrud.updateRecord(
                                            EventsModel(
                                              id: event.id,
                                              title: titleController.text,
                                              imgUrl: event.imgUrl,
                                              timestamp: event.timestamp,
                                              views: event.views,
                                              time: timeController.text,
                                              location: locationController.text,
                                              description:
                                                  descriptionController.text,
                                              date: dateController.text,
                                              registeredUsers:
                                                  event.registeredUsers,
                                            ),
                                            profileImage,
                                            event.imgUrl ?? "");
                                    if (response.code == 200) {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.success,
                                          text: "Event updated successfully!",
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
                                          text: "Failed to update Event!",
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
                  Container(
                    height: height/1.48,
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
                                  children: [
                                    Column(
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
                                          color: const Color(0xffDDDEEE),
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
                                                decoration: const InputDecoration(
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
                                          color: const Color(0xffDDDEEE),
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
                                    SizedBox(width: width / 68.3),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: "Location *",
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: width / 97.571,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: height / 108.5),
                                        Material(
                                          borderRadius: BorderRadius.circular(3),
                                          color: const Color(0xffDDDEEE),
                                          elevation: 5,
                                          child: SizedBox(
                                            height: height / 16.275,
                                            width: width / 6.830,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: width / 170.75,
                                                bottom: height / 81.375,
                                              ),
                                              child: TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                      "[a-zA-Z ]")),
                                                ],
                                                controller: locationController,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  border: InputBorder.none,
                                                  hintText: "Select Type",
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
                                          text: "Title *",
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: width / 97.571,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: height / 108.5),
                                        Material(
                                          borderRadius: BorderRadius.circular(3),
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
                                               /* inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                      r"^[a-zA-Z0-9.]+[a-zA-Z]+"))


                                                ],*/
                                                keyboardType: TextInputType.multiline,
                                                minLines: 1,
                                                maxLines: 5,
                                                controller: titleController,
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
                                        SizedBox(height: height / 108.5),
                                        Material(
                                          borderRadius: BorderRadius.circular(3),
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
                                                controller: descriptionController,
                                                decoration: InputDecoration(
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
                                          base64Decode(uploadedImage!
                                              .split(',')
                                              .last),
                                        ),
                                      ),
                                    )
                                        : null),
                                child: (selectedImg != null || selectedImg != '')
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
                          padding:  EdgeInsets.only(top:height/10.39),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: width/2.2925,
                              ),

                              /// Update Button
                              GestureDetector(
                                onTap: () async {
                                  if (titleController.text != "" &&
                                      dateController.text != "" &&
                                      timeController.text != "" &&
                                      locationController.text != "") {
                                    Response response =
                                    await EventsFireCrud.updateRecord(
                                        EventsModel(
                                          id: event.id,
                                          title: titleController.text,
                                          imgUrl: event.imgUrl,
                                          timestamp: event.timestamp,
                                          views: event.views,
                                          time: timeController.text,
                                          location: locationController.text,
                                          description:
                                          descriptionController.text,
                                          date: dateController.text,
                                          registeredUsers:
                                          event.registeredUsers,
                                          timestampmain: event.timestampmain
                                        ),
                                        profileImage,
                                        event.imgUrl ?? "");
                                    if (response.code == 200) {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.success,
                                          text: "Event updated successfully!",
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
                                        final snackBar = SnackBar(content: AwesomeSnackbarContent(title: 'Event Edited Successfully!', message: 'Edited!!!!!', contentType: ContentType.success,),);
                                        ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
                                      });
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    } else {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          text: "Failed to update Event!",
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
                                    height: height/18.475,
                                    width: width/12.8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD60A0B),
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
                                          color: const Color(0xffFFFFFF),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: width/76.8,
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
                                    height: height/18.475,
                                    width: width/12.8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff00A0E3),
                                      borderRadius:
                                      BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: KText(
                                        text: 'Cancel',
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width/96,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: const Color(0xffFFFFFF),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: width/76.8,
                              ),

                            ],
                          ),
                        ),
                      ],
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
  convertToCsv(List<EventsModel> events) async {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("No.");
    row.add("Date");
    row.add("Time");
    row.add("Location");
    row.add("Description");
    rows.add(row);
    for (int i = 0; i < events.length; i++) {
      List<dynamic> row = [];
      row.add(i + 1);
      row.add(events[i].date!);
      row.add(events[i].time!);
      row.add(events[i].location!);
      row.add(events[i].description!);
      rows.add(row);
    }
    String csv = const ListToCsvConverter().convert(rows);
    saveCsvToFile(csv);
  }

  convertToPdf(List<EventsModel> events) async {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("No.");
    row.add("Date");
    row.add("Time");
    row.add("Location");
    row.add("Description");
    rows.add(row);
    for (int i = 0; i < events.length; i++) {
      List<dynamic> row = [];
      row.add(i + 1);
      row.add(events[i].date!);
      row.add(events[i].time!);
      row.add(events[i].location!);
      row.add(events[i].description!);
      rows.add(row);
    }
    String pdf = const ListToCsvConverter().convert(rows);
    savePdfToFile(pdf);
  }

  void saveCsvToFile(csvString) async {
    final blob = Blob([Uint8List.fromList(csvString.codeUnits)]);
    final url = Url.createObjectUrlFromBlob(blob);
    final anchor = AnchorElement(href: url)
      ..setAttribute("download", "data.csv")
      ..click();
    Url.revokeObjectUrl(url);
  }

  void savePdfToFile(data) async {
    final blob = Blob([data], 'application/pdf');
    final url = Url.createObjectUrlFromBlob(blob);
    final anchor = AnchorElement(href: url)
      ..setAttribute("download", "events.pdf")
      ..click();
    Url.revokeObjectUrl(url);
  }

  copyToClipBoard(List<EventsModel> events) async {
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
    for (int i = 0; i < events.length; i++) {
      List<dynamic> row = [];
      row.add(i + 1);
      row.add("       ");
      row.add(events[i].date);
      row.add("       ");
      row.add(events[i].time);
      row.add("       ");
      row.add(events[i].location);
      row.add("       ");
      row.add(events[i].description);
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
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 3,
                                      offset: Offset(2, 3),
                                    )
                                  ],
                                ),
                                child: TextField(
                                  readOnly: true,
                                  style:SafeGoogleFont('Nunito',
                                      color:Colors.black
                                  ),
                                  decoration: InputDecoration(
                                    hintStyle: SafeGoogleFont('Nunito', color:Colors.black
                                        ),
                                    hintText: dateRangeStart != null
                                        ? "${dateRangeStart!.day}/${dateRangeStart!.month}/${dateRangeStart!.year}"
                                        : "",
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
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 3,
                                      offset: Offset(2, 3),
                                    )
                                  ],
                                ),
                                child: TextField(
                                  style:SafeGoogleFont('Nunito',
                                      color:Colors.black
                                  ),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintStyle: SafeGoogleFont('Nunito',
                                      color:Colors.black
                                    ),
                                    hintText: dateRangeEnd != null
                                        ? "${dateRangeEnd!.day}/${dateRangeEnd!.month}/${dateRangeEnd!.year}"
                                        : "",
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
                                        dateRangeEnd = pickedDate;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                child: Container(
                                  height: height / 16.275,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
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
                                  Navigator.pop(context, true);
                                },
                                child: Container(
                                  height: height / 16.275,
                                  decoration: BoxDecoration(
                                    color: Constants().primaryAppColor,
                                    borderRadius: BorderRadius.circular(8),
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
          boxShadow: const [
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

  Popupmenu(BuildContext context, events, key, size) async {
    print(
        "Popupmenu open-----------------------------------------------------------");
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
                      dateController.text = events.date!;
                      titleController.text = events.title!;
                      timeController.text = events.time!;
                      locationController.text = events.location!;
                      descriptionController.text = events.description!;
                      selectedImg = events.imgUrl;
                    });
                    editPopUp(events, size);
                  } else if (item == "Delete") {
                    EventsFireCrud.deleteRecord(id: events.id);

                  //   snakbar
                    final snackBar = SnackBar(content: AwesomeSnackbarContent(title: 'Event Deleted Successfully !', message: 'Deleted!!!!!', contentType: ContentType.success,),);
                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
                  }
                },
                value: item,
                child: Container(
                  height: height / 18.475,
                  decoration: BoxDecoration(
                      color: item == "Edit"
                          ? const Color(0xff5B93FF).withOpacity(0.6) : item == "View"
                          ?  Colors.green.withOpacity(0.6)
                          : const Color(0xffE71D36).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // item == "Edit"
                      //     ? const Icon(
                      //         Icons.edit,
                      //         color: Colors.white,
                      //         size: 18,
                      //       )
                      //     : const Icon(
                      //         Icons.delete,
                      //         color: Colors.white,
                      //         size: 18,
                      //       ),
                      item == "Edit"
                          ? const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ): item == "View"
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
                        padding: EdgeInsets.only(left: width/307.2),
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

  menuItemExportData(BuildContext context, events, key, size) async {
    print("Popupmenu open-----------------------------------------------------------");
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
                    var data = await generateEventPdf(PdfPageFormat.letter, events, false);
                  } else if (item == "Copy") {
                    copyToClipBoard(events);
                  }
                  else if (item == "Csv") {
                    convertToCsv(events);
                  }
                },
                value: item,
                child: Material(
                  elevation: 10,
                  color: item == "Print"
                      ? const Color(0xff5B93FF):
                  item == "Copy"
                      ? const Color(0xffE71D36):
                  item == "Csv"
                      ? Colors.green
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  shadowColor: Colors.black12,
                  child: Container(
                    height: height / 18.475,
                    decoration: BoxDecoration(
                        color: item == "Print"
                            ? const Color(0xff5B93FF):
                        item == "Copy"
                            ? const Color(0xffE71D36):
                        item == "Csv"
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
                          padding: EdgeInsets.only(left: width/307.2),
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

  filterDataMenuItem(BuildContext context,  key, size) async {
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
                  ? const Icon(
                Icons.print,
                color: Color(0xff5B93FF),
                size: 18,
              ) : const Icon(
                Icons.circle,
                color: Colors.transparent,
              ),
              Padding(
                padding: EdgeInsets.only(left: width/307.2),
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

}
