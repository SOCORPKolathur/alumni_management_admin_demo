import 'dart:convert';
import 'dart:html' as html;

import 'package:alumni_management_admin/common_widgets/developer_card_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Constant_.dart';
import '../Gallery_FireCrud/Gallery_firecurd.dart';
import '../Models/Language_Model.dart';
import '../utils.dart';



class Gallery_Screen extends StatefulWidget {
  Gallery_Screen({super.key});

  @override
  State<Gallery_Screen> createState() => _Gallery_ScreenState();
}

class _Gallery_ScreenState extends State<Gallery_Screen> with SingleTickerProviderStateMixin {

  bool isEditGI = false;
  bool isEditSI = false;
  late AnimationController lottieController;

  String currentTab="VIEW";
  GlobalKey filterDataKey = GlobalKey();
  List filterDataList = [
    'Filter by Date',
  ];
  bool isLoading = false;

  Future<void> addImage(String collection, Size size) async {
    final html.FileUploadInputElement input = html.FileUploadInputElement()..accept = 'image/*';
    input.click();

    bool fileSelected = false;

    input.onChange.listen((event) {
      setState(() {
        fileSelected = input.files!.isNotEmpty;
      });

      if (fileSelected) {
        _uploadFile(input.files!.first, collection, size);
      }
    });
  }

  Future<void> _uploadFile(html.File file, String collection, Size size) async {
    setState(() {
      isLoading = true; // Show loader when file upload begins
    });

    var snapshot = await fs.ref().child('Photo').child("${file.name}").putBlob(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    if (collection == "Photo") {
      FirebaseFirestore.instance
          .collection("Photos")
          .doc(addphotoDocummentValue.toString())
          .collection(addphotoDocummentValue.toString())
          .doc()
          .set({
        "imgUrl": downloadUrl,
        "timestamp": DateTime.now().millisecondsSinceEpoch
      });
    }

    if (collection == "SliderImages") {
      FirebaseFirestore.instance.collection("SliderImages").doc().set({
        "imgUrl": downloadUrl,
        "timestamp": DateTime.now().millisecondsSinceEpoch
      });
    }

    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: "Image Added Successfully",
      width: size.width * 0.4,
      backgroundColor: Colors.blue,
    );

    setState(() {
      isLoading = false; // Hide loader after file upload is complete
    });
  }

  @override
  void initState() {
    doclength();
    lottieController = AnimationController(vsync: this);
    lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        lottieController.reset();
      }
    });
    super.initState();
  }

  TextEditingController pictureNameController=TextEditingController();
  TextEditingController Date1Controller = TextEditingController();
  TextEditingController Date2Controller = TextEditingController();
  DateTime? dateRangeStart;
  DateTime? dateRangeEnd;
  bool filtervalue=false;
  bool addPhoto=false;
  bool SliderImg=false;
  String addphotoDocummentValue='';
  String filterChageValue = "name";
  List<String> mydate=[];
  bool isFiltered=false;
  final DateFormat formatter = DateFormat('d-M-yyyy');

  int pagecount = 0;
  int temp = 1;
  List list = new List<int>.generate(1000, (i) => i + 1);
  List <DocumentSnapshot>documentList = [];
  int documentlength =0 ;
  doclength() async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance.collection("Photos").get();
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
  // doclength() async {
  //   try {
  //     final QuerySnapshot result = await FirebaseFirestore.instance.collection("Photos").get();
  //     final List<DocumentSnapshot> documents = result.docs;
  //
  //     setState(() {
  //       documentlength = documents.length;
  //       // Ensure pagecount is at least 1
  //       pagecount = ((documentlength - 1) ~/ 10) + 1;
  //       pagecount = pagecount < 1 ? 1 : pagecount;
  //     });
  //
  //     print(pagecount);
  //   } catch (error) {
  //     print("Error fetching data: $error");
  //     // Handle the error as needed
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Padding(
      padding:  EdgeInsets.only(left:width/170.75,top:height/65.1),
      child: FadeInRight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top:height/50.0769),
                  child: Row(
                    children: [
                      KText(
                        text: 'GALLERY',
                        style: SafeGoogleFont (
                          'Poppins',
                          fontSize: 25*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6*ffem/fem,
                          color: Color(0xff05004e),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height/81.375,),
                  child: Row(
                    children: [
                      addPhoto==false&&SliderImg==false
                      ?InkWell(
                          onTap: () {
                              addItemPopUp();
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
                                        ? "Add Album"
                                        : "View Album",
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
                          )):SizedBox(height: height / 18.6, width: width/10.9714,),
                      addPhoto==false&&SliderImg==false?
                      Padding(
                        padding:  EdgeInsets.only(left:width/68.3),
                        child: InkWell(
                            onTap: () {
                             setState(() {
                               SliderImg=true;
                             });
                            },
                            child: Container(
                              height: height / 18.6,
                              width: width/10.6,
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
                                          ? "Add SliderImage"
                                          : "View SliderImage",
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
                            )
                        ),
                      ) :SizedBox(
                        height: height / 18.6,
                        width: width/10.6,
                        ),
                     /* addPhoto==true||SliderImg==true?const SizedBox():
                      Padding(
                        padding:  EdgeInsets.only(left: width/1.905,),
                        child: InkWell(
                          key: filterDataKey,
                          onTap: () async {
                            filterDataMenuItem( context, filterDataKey, size);
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
                              child: Row(
                                children: [
                                  Icon(Icons.filter_list_alt,color:Colors.white),
                                  KText(
                                    text: " Filter by Date",
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
                      )*/
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height:height/65.1),
            addPhoto==true||SliderImg==true?const SizedBox():
            Container(
                color: Colors.white,
                width: width/1.2418,
                height: height/13.4363,
                child: Row(
                  children: [
                    Container(
                      color: Colors.white,
                      width: width/7.2,
                      height: height/14.78,
                      alignment: Alignment.center,
                      child: Center(
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            KText(
                              text: "Si.No",
                              style: SafeGoogleFont(
                                'Nunito',
                                color: Color(0xff030229),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    filtervalue = !filtervalue;
                                  });
                                },
                                child: Transform.rotate(
                                  angle: 0,
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
                      width: width/4.38857,
                      height: height/14.78,
                      alignment: Alignment.center,
                      child: Center(
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            KText(
                              text: "Name",
                              style: SafeGoogleFont(
                                'Nunito',
                                color: Color(0xff030229),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    filtervalue = !filtervalue;
                                    filterChageValue="name";
                                  });
                                },
                                child: Transform.rotate(
                                  angle: filtervalue ? 200 : 0,
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
                    SizedBox(
                      width: width/7.6,
                      height: height/14.78,
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
                              padding: const EdgeInsets.only(
                                  left: 8),
                              child: InkWell(
                                onTap: () {

                                },
                                child: Transform.rotate(
                                  angle: filtervalue ? 200 : 0,
                                  child: Opacity(
                                    // arrowdown2TvZ (8:2307)
                                    opacity: 0.7,
                                    child: SizedBox(
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
            addPhoto==true?
            Container(
              height: size.height * 0.3,
              width: width/1.2418,
              decoration: BoxDecoration(
                color: Constants().primaryAppColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(1, 2),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width/68.3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            children: [
                              InkWell(
                                  onTap: (){
                                    setState(() {
                                      addPhoto=false;
                                      isEditSI=false;
                                      addphotoDocummentValue='';
                                    });
                                  },
                                  child: Icon(Icons.arrow_back,color: Colors.white,)),
                              Padding(
                                padding:  EdgeInsets.only(left:width/192),
                                child: KText(
                                  text:addphotoDocummentValue==""?"Images": addphotoDocummentValue.toString(),
                                  style :SafeGoogleFont (
                                    'Poppins',
                                    fontSize: 22*ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6*ffem/fem,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  addImage("Photo",size);
                                },
                                child: KText(
                                  text: "ADD",
                                  style: SafeGoogleFont (
                                    'Poppins',
                                    fontSize: 20*ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6*ffem/fem,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width:width/307.2),
                              Icon(
                                Icons.add_circle,
                                color: Colors.white,
                              ),
                              SizedBox(width: width/91.06),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isEditSI = !isEditSI;
                                  });
                                },
                                child: KText(
                                  text: isEditSI?"CLOSE":"EDIT",
                                  style: SafeGoogleFont (
                                    'Poppins',
                                    fontSize: 20*ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6*ffem/fem,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width:width/307.2),
                              Icon(
                                Icons.edit_note,
                                color: Colors.white,
                              ),
                              SizedBox(width: width/91.06),
                              InkWell(
                                onTap: () {
                                  showImageGidView(context, addphotoDocummentValue);
                                },
                                child: KText(
                                  text: "VIEW MORE",
                                  style: SafeGoogleFont (
                                    'Poppins',
                                    fontSize: 20*ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6*ffem/fem,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width:width/307.2),
                              RotatedBox(
                                quarterTurns: 3,
                                child: Icon(
                                  Icons.expand_circle_down_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Photos").doc(addphotoDocummentValue.toString()).
                      collection(addphotoDocummentValue.toString()).orderBy('timestamp').snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return const Center(child:CircularProgressIndicator());
                        }

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (ctx, i) {
                            var allData=snapshot.data!.docs[i];
                            return InkWell(
                              onTap: () {
                                showImageModel(context, allData["imgUrl"]);
                              },
                              child: isEditSI
                                  ? Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    height: height/5.007,
                                    width: width/13.66,
                                    margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          allData['imgUrl'],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: width/136.6,
                                    top: height/65.1,
                                    child: InkWell(
                                      onTap: () {
                                        FirebaseFirestore.instance.collection("Photos").doc(addphotoDocummentValue).
                                        collection(addphotoDocummentValue).doc(allData.id).delete();
                                      },
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              )
                                  : Container(
                                height: height/5.007,
                                width: width/13.66,
                                margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      allData['imgUrl'],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ):
            SliderImg==true?
            Container(
              height: size.height * 0.3,
              width: width/1.2418,
              decoration: BoxDecoration(
                color: Constants().primaryAppColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(1, 2),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width/68.3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            children: [
                              InkWell(
                                  onTap: (){
                                    setState(() {
                                      addPhoto=false;
                                      isEditSI=false;
                                      SliderImg=false;
                                      addphotoDocummentValue='';
                                    });
                                  },
                                  child: Icon(Icons.arrow_back,color: Colors.white,)),
                              Padding(
                                padding:  EdgeInsets.only(left:width/192),
                                child: KText(
                                  text:" Slider Images",
                                  style :SafeGoogleFont (
                                    'Poppins',
                                    fontSize: 22*ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6*ffem/fem,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      addImage("SliderImages", size);
                                    },
                                    child: KText(
                                      text: "ADD",
                                      style: SafeGoogleFont(
                                        'Poppins',
                                        fontSize: 20 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.6 * ffem / fem,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  if (isLoading)
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0), // Adjust the padding as needed
                                      child: Container(
                                        color: Colors.black.withOpacity(0.5),
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                ],
                              ),


                              SizedBox(width:width/307.2),
                              Icon(
                                Icons.add_circle,
                                color: Colors.white,
                              ),
                              SizedBox(width: width/91.06),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isEditSI = !isEditSI;
                                  });
                                },
                                child: KText(
                                  text: isEditSI?"CLOSE":"EDIT",
                                  style: SafeGoogleFont (
                                    'Poppins',
                                    fontSize: 20*ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6*ffem/fem,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width:width/307.2),
                              Icon(
                                Icons.edit_note,
                                color: Colors.white,
                              ),
                              SizedBox(width: width/91.06),
                              InkWell(
                                onTap: () {
                                  showImageSlidersGidView(context, 'SliderImages');
                                },
                                child: KText(
                                  text: "VIEW MORE",
                                  style: SafeGoogleFont (
                                    'Poppins',
                                    fontSize: 20*ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6*ffem/fem,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width:width/307.2),
                              RotatedBox(
                                quarterTurns: 3,
                                child: Icon(
                                  Icons.expand_circle_down_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  Container(
                    height: size.height * 0.2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("SliderImages").orderBy("timestamp").snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return const Center(child:CircularProgressIndicator());
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (ctx, i) {
                            var allData=snapshot.data!.docs[i];
                            return InkWell(
                              onTap: () {
                                showImageModel(context, allData["imgUrl"]);
                              },
                              child: isEditSI
                                  ? Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    height: height/5.007,
                                    width: width/13.66,
                                    margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          allData['imgUrl'],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: width/136.6,
                                    top: height/65.1,
                                    child: InkWell(
                                      onTap: () {
                                        FirebaseFirestore.instance.collection("SliderImages").doc(allData.id).delete();
                                      },
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              )
                                  : Container(
                                height: height/5.007,
                                width: width/13.66,
                                margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      allData['imgUrl'],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ):
            SizedBox(
              height: height/1.34363,
              width: width/1.2418,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Photos").orderBy(filterChageValue, descending: filtervalue).snapshots(),
                      builder: (context, snapshot) {

                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height / 1.35625,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: pagecount == temp ? snapshot.data!.docs.length.remainder(10) == 0 ? 10 : snapshot.data!.docs.length.remainder(10) : 10 ,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var Value = snapshot.data!.docs[(temp * 10) - 10 + index];

                                    return ((temp * 10) - 10 + index >= documentlength)
                                        ? SizedBox()
                                        : SizedBox(
                                      width: width / 1.2418,
                                      height: height / 13.4363,
                                      child: Row(
                                        children: [
                                          Container(
                                            color: Colors.transparent,
                                            width: width / 7.2,
                                            height: height / 14.78,
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width / 102.4),
                                              child: KText(
                                                text: (index + 1).toString(),
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color: Color(0xff030229),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.transparent,
                                            width: width / 4.38857,
                                            height: height / 14.78,
                                            alignment: Alignment.centerLeft,
                                            child: KText(
                                              text: Value['name'].toString(),
                                              style: SafeGoogleFont(
                                                'Nunito',
                                                color: Color(0xff030229),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 7.6,
                                            height: height / 14.78,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  addPhoto = true;
                                                  addphotoDocummentValue = Value.id;
                                                });
                                                print(addphotoDocummentValue);
                                                print("00000000000000000000000000000000000000000000000000000000000000");
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(right: width / 15.8, top: height / 73.9, bottom: height / 73.9),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Constants().primaryAppColor,
                                                ),
                                                child: Center(
                                                  child: KText(
                                                    text: "View Album",
                                                    style: SafeGoogleFont(
                                                      'Nunito',
                                                      color: Color(0xffFFFFFF),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: height / 13.02,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: pagecount,
                                      itemBuilder: (context, index) {
                                        if (index >= 0 && index < list.length) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                temp = list[index];
                                              });
                                              print(temp);
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              margin: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: temp == list[index] ? Constants().primaryAppColor : Colors.transparent,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  list[index].toString(),
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    color: temp == list[index] ? Colors.white : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          // Handle the case when index is out of range
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                                  temp > 1
                                      ? Padding(
                                    padding: const EdgeInsets.only(right: 150.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          temp = temp > 1 ? temp - 1 : 1;
                                        });
                                      },
                                      child: Container(
                                        height: height / 16.275,
                                        width: width / 11.3833,
                                        decoration: BoxDecoration(
                                          color: Constants().primaryAppColor,
                                          borderRadius: BorderRadius.circular(80),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Previous Page",
                                            style: SafeGoogleFont(
                                              'Nunito',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                      : Container(),
                                  Container(
                                    child: temp < pagecount
                                        ? Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            temp = temp < pagecount ? temp + 1 : pagecount;
                                          });
                                        },
                                        child: Container(
                                          height: height / 16.275,
                                          width: width / 11.3833,
                                          decoration: BoxDecoration(
                                            color: Constants().primaryAppColor,
                                            borderRadius: BorderRadius.circular(80),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Next Page ",
                                              style: SafeGoogleFont(
                                                'Nunito',
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                        : Container(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
            ),),
            SizedBox(height: height / 65.1),
            DeveloperCardWidget(),
            SizedBox(height: height / 65.1),

          ],
        ),
      ),
    );
  }

  AwesomeDialog popup(context, bool isSuccess) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return AwesomeDialog(
      context: context,
      dialogType: isSuccess ? DialogType.success : DialogType.error,
      borderSide: BorderSide(
        color: isSuccess ? Colors.green : Colors.red,
        width: width/683,
      ),
      width: width/4.878,
      buttonsBorderRadius: BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      onDismissCallback: (type) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: KText(
              text: 'Dismissed by $type',
              style:
              SafeGoogleFont (
                'Poppins',
                fontSize: 22*ffem,
                fontWeight: FontWeight.w500,
                height: 1.6*ffem/fem,
              ),
            ),
          ),
        );
      },
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: isSuccess ? 'Done' : 'Failed',
      desc: isSuccess ? 'Event Created Successfully' : 'Failed to create event',
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    );
  }

  showImageModel(context, String imgUrl) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:  EdgeInsets.only(left:width/6.83),
          child: Dialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            insetPadding: EdgeInsets.all(12),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height/217,
                        horizontal: width/455.33
                    ),
                    child: Container(
                      height: size.height * 0.8,
                      width: size.width * 0.6,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(imgUrl),
                          )
                      ),
                    )
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.04,
                  right: size.width * 0.03,
                  child: InkWell(
                    onTap: () async {
                      try {
                        final http.Response r = await http.get(
                          Uri.parse(imgUrl),
                        );
                        final data = r.bodyBytes;
                        final base64data = base64Encode(data);
                        final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');
                        a.download = 'image.jpg';
                        a.click();
                        a.remove();
                      } catch (e) {
                        print(e);
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height/16.275,
                      width: width/9.106666666666667,
                      decoration: BoxDecoration(
                        color: Constants().primaryAppColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download_rounded, color: Colors.white),
                          SizedBox(width: width/136.6),
                          Text(
                            "Download",
                            style: SafeGoogleFont (
                              'Poppins',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


  showImageGidView(context, String collection) {
    Size size = MediaQuery.of(context).size;
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:  EdgeInsets.only(left:width/6.83),
          child: Dialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            insetPadding: EdgeInsets.all(12),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: StreamBuilder(
              stream:  FirebaseFirestore.instance.collection('Photos').doc(addphotoDocummentValue).collection(addphotoDocummentValue).snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.hasError) {
                  return Container();
                }
                return Container(
                  height: size.height * 0.7,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                      color: Constants().primaryAppColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black26,offset: Offset(2,3),blurRadius: 3)
                      ]
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.1,
                        padding: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Images',
                              style:SafeGoogleFont (
                                'Poppins',
                                fontSize: 22*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: KText(
                                text: 'Close',
                                style: SafeGoogleFont (
                                  'Poppins',
                                  fontSize: 20*ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6*ffem/fem,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          child: GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                                crossAxisCount: 3,
                                childAspectRatio: 12 / 9,
                              ),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (ctx, i) {
                                var data = snapshot.data!.docs[i];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: height/81.375, horizontal: width/170.75),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          data['imgUrl'],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                          ,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }


  showImageSlidersGidView(context, String collection) {
    Size size = MediaQuery.of(context).size;
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:  EdgeInsets.only(left:width/6.83),
          child: Dialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            insetPadding: EdgeInsets.all(12),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: StreamBuilder(
              stream:  FirebaseFirestore.instance.collection('SliderImages').orderBy('timestamp').snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.hasError) {
                  return Container();
                }
                return Container(
                  height: size.height * 0.7,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                      color: Constants().primaryAppColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black26,offset: Offset(2,3),blurRadius: 3)
                      ]
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.1,
                        padding: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Images',
                              style:SafeGoogleFont (
                                'Poppins',
                                fontSize: 22*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: KText(
                                text: 'Close',
                                style: SafeGoogleFont (
                                  'Poppins',
                                  fontSize: 20*ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6*ffem/fem,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          child: GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                                crossAxisCount: 3,
                                childAspectRatio: 12 / 9,
                              ),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (ctx, i) {
                                var data = snapshot.data!.docs[i];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: height/81.375, horizontal: width/170.75),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          data['imgUrl'],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                          ,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }



  filterDataMenuItem(BuildContext context, key, size) async {
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



  addItemPopUp() {
    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  width:width/2.56,
                  height:height/2.956,
                  // margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
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
                        width:width/1.70666,
                        height: height/9.2375,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/81.375),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: "Add Item",
                                    style:  SafeGoogleFont (
                                      'Nunito',
                                      fontSize: width/88.3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: width/5.12,),
                                  /* Row(
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          FirebaseFirestore.instance.collection("Department").doc().set({
                                            "name":departmentnameContoller.text,
                                            "timestamp":DateTime.now().millisecondsSinceEpoch
                                          });
                                          setState((){
                                            departmentnameContoller.clear();
                                          });
                                          Navigator.pop(context);

                                        },
                                        child: Container(
                                          height: height/16.275,
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
                                            padding:
                                            EdgeInsets.symmetric(horizontal:width/227.66),
                                            child: Center(
                                              child: KText(
                                                text: "Save",
                                                style:  SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: width/105.375,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: width/136.6),
                                      InkWell(
                                        onTap: () async {

                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: height/16.275,
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
                                            padding:
                                            EdgeInsets.symmetric(horizontal:width/227.66),
                                            child: Center(
                                              child: KText(
                                                text: "CANCEL",
                                                style:  SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: width/105.375,
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
                          ],
                        ),
                      ),

                      Container(
                          height: height/14.78,
                          width: width/5.12,
                          margin: EdgeInsets.only(bottom: height/73.9),
                          decoration: BoxDecoration(
                              color: const Color(
                                  0xffDDDEEE),
                              borderRadius:
                              BorderRadius.circular(
                                  3)),
                          child:
                          TextFormField(
                            controller:pictureNameController,

                            decoration: InputDecoration(
                              border:
                              InputBorder
                                  .none,
                              contentPadding: EdgeInsets.only(
                                  bottom:
                                  height/73.9,
                                  top: height/369.5,
                                  left:
                                  width/153.6),
                              counterText:
                              "",
                            ),

                          )),


                      Padding(
                        padding:  EdgeInsets.only(top:height/30.39),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [

                            SizedBox(
                              width: width/5.2925,
                            ),

                            /// Save Button
                            GestureDetector(
                              onTap:(){
                                FirebaseFirestore.instance.collection("Photos").doc(pictureNameController.text).set({
                                  "name":pictureNameController.text,
                                  "date":"${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                                  "time":DateFormat("hh:mm a").format(DateTime.now()),
                                  "timestamp":DateTime.now().millisecondsSinceEpoch
                                });
                                setState((){
                                  pictureNameController.clear();
                                });
                                Navigator.pop(context);

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

                            ///Cancel Button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  pictureNameController.clear();
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: height/18.475,
                                  width: width/12.8,
                                  decoration: BoxDecoration(
                                    color: Color(0xff00A0E3),
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
                                        color: Color(0xffFFFFFF),
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
              );
            }
        );
      },
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
                                            mydate.add(formatter.format(items[i])
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

}