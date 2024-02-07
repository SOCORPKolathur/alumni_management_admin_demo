import 'dart:convert';
import 'dart:html';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:intl/intl.dart';

import '../Blog_FireCrud/blog_firecrude.dart';
import '../Constant_.dart';
import '../Models/Language_Model.dart';
import '../Models/Response_Model.dart';
import '../Models/blog_model.dart';
import '../common_widgets/developer_card_widget.dart';
import '../utils.dart';

class BlogTab extends StatefulWidget {
  const BlogTab({super.key});

  @override
  State<BlogTab> createState() => _BlogTabState();
}

class _BlogTabState extends State<BlogTab> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  TextEditingController titleController = TextEditingController();
  TextEditingController authorNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? dateRangeStart;
  DateTime? dateRangeEnd;
  bool isFiltered= false;
  File? profileImage;
  var uploadedImage;
  String? selectedImg;

  String currentTab = 'View';

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

  bool isLoading = false;

  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final authorFocusNode = FocusNode();
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
  bool filtervalue = false;
  String filterChageValue = "title";
  GlobalKey filterDataKey = GlobalKey();
  int documentlength =0 ;
  int pagecount = 0;
  int temp = 1;
  List list = new List<int>.generate(1000, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
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
                            text: "BLOG",
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
                                              ? "Add Blog"
                                              : "View blogs",
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
                                    boxShadow: [
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
                                        Icon(Icons.filter_list_alt,color:Colors.white),
                                        KText(
                                          text: dateRangeStart==null?"Filter by Date":"Clear Date",
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
                    ? Container(
                  width: width / 1.26,
                  height: height / 1.2336,
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 68.3, vertical: height / 81.375),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: "Add new Blog Post",
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
                          decoration: BoxDecoration(
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
                                                  text: "Author Name*",
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
                                                        controller: authorNameController,
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
                                          if(!isLoading){
                                            setState(() {
                                              isLoading = true;
                                            });
                                            if (profileImage != null &&
                                                titleController.text != "" &&
                                                authorNameController.text != "" &&
                                                descriptionController.text != "") {
                                              Response response =
                                              await BlogFireCrud.addBlog(
                                                image: profileImage!,
                                                author: authorNameController.text,
                                                time: formatter.format(DateTime.now()),
                                                title: titleController.text,
                                                description: descriptionController.text,
                                              );
                                              if (response.code == 200) {
                                                CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.success,
                                                    text: "Blog created successfully!",
                                                    width: size.width * 0.4,
                                                    backgroundColor: Constants()
                                                        .primaryAppColor
                                                        .withOpacity(0.8));
                                                setState(() {
                                                  currentTab = 'View';
                                                  uploadedImage = null;
                                                  profileImage = null;
                                                  titleController.text = "";
                                                  authorNameController.text = "";
                                                  descriptionController.text = "";
                                                  isLoading = false;
                                                });
                                              } else {
                                                CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.error,
                                                    text: "Failed to Create Blog!",
                                                    width: size.width * 0.4,
                                                    backgroundColor: Constants()
                                                        .primaryAppColor
                                                        .withOpacity(0.8));
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
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
                                                text: 'Save',
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
                                      SizedBox(
                                        width: width/76.8,
                                      ),

                                      ///Reset Button
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     setState(() {
                                      //       locationController.text = "";
                                      //       descriptionController.text = "";
                                      //       titleController.text = "";
                                      //       uploadedImage = null;
                                      //       profileImage = null;
                                      //     });
                                      //   },
                                      //   child: Container(
                                      //       height: height/18.475,
                                      //       width: width/12.8,
                                      //       decoration: BoxDecoration(
                                      //         color: Color(0xff00A0E3),
                                      //         borderRadius:
                                      //         BorderRadius.circular(4),
                                      //       ),
                                      //       child: Center(
                                      //         child: KText(
                                      //           text: 'Reset',
                                      //           style: SafeGoogleFont(
                                      //             'Nunito',
                                      //             fontSize: width/96,
                                      //             fontWeight:
                                      //             FontWeight.w600,
                                      //             color: Color(0xffFFFFFF),
                                      //           ),
                                      //         ),
                                      //       )),
                                      // ),
                                      SizedBox(
                                        width: width/76.8,
                                      ),

                                      ///back Button
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            authorNameController.text = "";
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
                          ),
                        ),
                      ),
                    ],
                  ),
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
                            Container(
                              color: Colors.white,
                              width: width/17.2,
                              height: height/14.78,
                              alignment: Alignment.center,
                              child: Center(
                                child: KText(
                                  text: "No",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    color: Color(0xff030229),
                                  ),
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
                                      text: "Title",
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        color: Color(0xff030229),
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
                                      text: "Description",
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        color: Color(0xff030229),
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
                                      text: "Date",
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
                                      text: "Date",
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
                                      text: "Likes",
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        color: Color(0xff030229),
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
                        stream: BlogFireCrud.fetchBlogsWithFilter(dateRangeStart!,dateRangeEnd!),
                        builder: (ctx, snapshot) {
                          if (snapshot.hasError) {
                            return Container();
                          } else if (snapshot.hasData) {
                    List<BlogModel> blog = snapshot.data!;
                            exportdataListFromStream = blog;
                            List<GlobalKey<State<StatefulWidget>>>popMenuKeys = List.generate(blog.length, (index) => GlobalKey(),);
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: blog.length,
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
                                                text:  '${i +1}',
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color:
                                                  Color(0xff030229),
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
                                                text:blog[i].title!,
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color:
                                                  Color(0xff030229),
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
                                                    text: blog[i].description!,
                                                    style: SafeGoogleFont(
                                                      'Nunito',
                                                      color: Color(
                                                          0xff030229),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets
                                                      .only(left: width/192),
                                                  child:
                                                  Icon(Icons.person),
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
                                                text:  blog[i]
                                                    .time
                                                    .toString(),
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color:
                                                  Color(0xff030229),
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
                                                text:blog[i].likes!.length.toString(),
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color:
                                                  Color(0xff030229),
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
                                                text:  blog[i].author!,
                                                style: SafeGoogleFont(
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
                                                  blog[i],
                                                  popMenuKeys[i],
                                                  size);
                                            },
                                            child: SizedBox(
                                                key: popMenuKeys[i],
                                                width: width/15.36,
                                                height: height/14.78,
                                                child: Icon(
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
                                      text: "No",
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
                            Container(
                              color: Colors.white,
                              width: width/9.6,
                              height: height/14.78,
                              alignment: Alignment.center,
                              child: Center(
                                child: KText(
                                  text: "Title",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    color: Color(0xff030229),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              width: width/9.6,
                              height: height/14.78,
                              alignment: Alignment.center,
                              child: Center(
                                child: KText(
                                  text: "Description",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    color: Color(0xff030229),
                                  ),
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
                                      text: "Date",
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        color: Color(0xff030229),
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
                                child: KText(
                                  text: "Likes",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    color: Color(0xff030229),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              width: width/8,
                              height: height/14.78,
                              alignment: Alignment.center,
                              child: Center(
                                child: KText(
                                  text: " Author",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    color: Color(0xff030229),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width/12.36,
                              height: height/14.78,
                              child: Center(
                                child: KText(
                                  text: "Actions",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    color: Color(0xff030229),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(

                      height: height/1.3436,
                      width: width/1.2288,
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          children: [
                            StreamBuilder(
                              stream: BlogFireCrud.fetchBlogs(),
                              builder: (ctx, snapshot) {
                                print("TT");
                                print(snapshot.data!.length);
                                if (snapshot.hasError) {
                                  return Container();
                                } else if (snapshot.hasData) {

                                  List<BlogModel> blog = snapshot.data!;
                                  exportdataListFromStream = blog;
                                  List<GlobalKey<State<StatefulWidget>>>popMenuKeys = List.generate(blog.length, (index) => GlobalKey(),);

                                  return
                                        SizedBox(
                                          height:height/1.35625,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount:blog.length,
                                            itemBuilder: (ctx, i) {

                                              var blogs=blog[(temp*10)-10+i];

                                              return
                                                SizedBox(
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
                                                                text: blogs.id!,
                                                                style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  color:
                                                                  Color(0xff030229),
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
                                                                text: blogs.title
                                                                    .toString(),
                                                                style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  color:
                                                                  Color(0xff030229),
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
                                                                    text: blogs
                                                                        .description!
                                                                        .length
                                                                        .toString(),
                                                                    style: SafeGoogleFont(
                                                                      'Nunito',
                                                                      color: Color(
                                                                          0xff030229),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .only(left: width/192),
                                                                  child:
                                                                  Icon(Icons.person),
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
                                                                text: blogs.time
                                                                    .toString(),
                                                                style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  color:
                                                                  Color(0xff030229),
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
                                                                text: blogs
                                                                    .description
                                                                    .toString(),
                                                                style: SafeGoogleFont(
                                                                  'Nunito',
                                                                  color:
                                                                  Color(0xff030229),
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
                                                                text: blogs
                                                                    .likes
                                                                    .toString(),
                                                                style: SafeGoogleFont(
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
                                                                  blogs,
                                                                  popMenuKeys[i],
                                                                  size);
                                                            },
                                                            child: SizedBox(
                                                                key: popMenuKeys[i],
                                                                width: width/15.36,
                                                                height: height/14.78,
                                                                child: Icon(
                                                                    Icons.more_horiz)),
                                                          ),
                                                        ],
                                                      ),
                                                    ));
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

  editPopUp(BlogModel blog, Size size) {
    double height = size.height;
    double width = size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height: size.height * 1.08,
            width: width/1.241818181818182,
            margin: const EdgeInsets.all(20),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                  width: double.infinity,
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: "Edit Blog Post",
                          style: GoogleFonts.openSans(
                            fontSize: width/68.3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              uploadedImage = null;
                              profileImage = null;
                              titleController.text == "";
                              descriptionController.text == "";
                            });
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.cancel_outlined,
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
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: height/3.829411764705882,
                              width: width/3.902857142857143,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Constants().primaryAppColor,
                                      width: 2),
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
                              child: selectedImg == null
                                  ? Center(
                                child: Icon(
                                  Icons.cloud_upload,
                                  size: width/8.5375,
                                  color: Colors.grey,
                                ),
                              )
                                  : null,
                            ),
                          ),
                          SizedBox(height: height/32.55),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: selectImage,
                                child: Container(
                                  height: height/18.6,
                                  width: size.width * 0.50,
                                  color: Constants().primaryAppColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_a_photo,
                                        color: Constants().btnTextColor,),
                                      SizedBox(width: width/136.6),
                                      KText(
                                        text: 'Select Blog Post Cover Photo',
                                        style: TextStyle(color: Constants().btnTextColor,),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: height/21.7),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: "Title *",
                                    style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontSize: width/105.0769230769231,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    style: TextStyle(fontSize: width/113.8333333333333),
                                    controller: titleController,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height/21.7),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: KText(
                                  text: "Description",
                                  style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontSize: width/105.0769230769231,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                height: size.height * 0.15,
                                width: double.infinity,
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Constants().primaryAppColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(1, 2),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: height/32.55,
                                      width: double.infinity,
                                    ),
                                    Expanded(
                                      child: Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: TextFormField(
                                            style: TextStyle(fontSize:  width/113.8333333333333),
                                            controller: descriptionController,
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(
                                                    left: 15,
                                                    top: 4,
                                                    bottom: 4)),
                                            maxLines: null,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height/21.7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (titleController.text != "") {
                                    Response response =
                                    await BlogFireCrud.updateRecord(
                                        BlogModel(
                                          timestamp: blog.timestamp,
                                          id: blog.id,
                                          author: blog.author,
                                          views: blog.views,
                                          imgUrl: blog.imgUrl,
                                          time: blog.time,
                                          title: titleController.text,
                                          description:
                                          descriptionController.text,
                                        ),
                                        profileImage,
                                        blog.imgUrl ?? "");
                                    if (response.code == 200) {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.success,
                                          text: "Blog updated successfully!",
                                          width: size.width * 0.4,
                                          backgroundColor: Constants()
                                              .primaryAppColor
                                              .withOpacity(0.8));
                                      setState(() {
                                        uploadedImage = null;
                                        profileImage = null;
                                        titleController.clear();
                                        descriptionController.clear();
                                      });
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    } else {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          text: "Failed to update Blog!",
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
                                  height: height/18.6,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Center(
                                      child: KText(
                                        text: "Update",
                                        style: GoogleFonts.openSans(
                                          color: Constants().btnTextColor,
                                          fontSize: width/136.6,
                                          fontWeight: FontWeight.bold,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  filterPopUp() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (context,setState) {
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
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: KText(
                                text: "Filter",
                                style: GoogleFonts.openSans(
                                  fontSize: width/85.375,
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
                              )
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: width/15.17777777777778,
                                    child: KText(
                                      text: "Start Date",
                                      style: GoogleFonts.openSans(
                                        fontSize: width/97.57142857142857,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width/85.375),
                                  Container(
                                    height: height/16.275,
                                    width: width/15.17777777777778,
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
                                      decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Color(0xff00A99D)),
                                        hintText: dateRangeStart != null ? "${dateRangeStart!.day}/${dateRangeStart!.month}/${dateRangeStart!.year}" : "",
                                        border: InputBorder.none,
                                      ),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                        await Constants().datePicker(context);
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
                                    width: width/15.17777777777778,
                                    child: KText(
                                      text: "End Date",
                                      style: GoogleFonts.openSans(
                                        fontSize: width/97.57142857142857,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width/85.375),
                                  Container(
                                    height: height/16.275,
                                    width: width/15.17777777777778,
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
                                      decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Color(0xff00A99D)),
                                        hintText: dateRangeEnd != null ? "${dateRangeEnd!.day}/${dateRangeEnd!.month}/${dateRangeEnd!.year}" : "",
                                        border: InputBorder.none,
                                      ),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                        await Constants().datePicker(context);
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
                                      Navigator.pop(context,false);
                                    },
                                    child: Container(
                                      height: height/16.275,
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
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 6),
                                        child: Center(
                                          child: KText(
                                            text: "Cancel",
                                            style: GoogleFonts.openSans(
                                              fontSize: width/85.375,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context,true);
                                    },
                                    child: Container(
                                      height: height/16.275,
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
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 6),
                                        child: Center(
                                          child: KText(
                                            text: "Apply",
                                            style: GoogleFonts.openSans(
                                              fontSize: width/85.375,
                                              fontWeight: FontWeight.bold,
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
            }
        );
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
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Please fill required fields !!',
                  style: TextStyle(color: Colors.black)),
            ),
            const Spacer(),
            TextButton(
                onPressed: () => debugPrint("Undid"), child: const Text("Undo"))
          ],
        )),
  );

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
                  ? Icon(
                Icons.print,
                color: Color(0xff5B93FF),
                size: 18,
              ) : Icon(
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

  ///popup for edit
  Popupmenu(BuildContext context,blogs, key, size) async {
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

              titleController.text = blogs.title!;
              descriptionController.text = blogs.description!;
              selectedImg = blogs.imgUrl;
            });
            editPopUp(blogs, size);
          } else if (item == "Delete") {
            BlogFireCrud.deleteRecord(id: blogs.id);
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
                padding: EdgeInsets.only(left: width/307.2),
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
}
