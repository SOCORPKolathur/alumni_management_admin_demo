import 'dart:convert';
import 'dart:html';
import 'dart:html' as html;

import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../Constant_.dart';
import '../Gallery_FireCrud/Gallery_firecurd.dart';
import '../Models/Gallery_Image_Model.dart';
import '../Models/Language_Model.dart';
import '../Models/Response_Model.dart';
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

  addImage(String collection,Size size) {
    InputElement input = FileUploadInputElement() as InputElement
      ..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);

      reader.onLoadEnd.listen((event) async {

        var snapshot = await fs.ref().child('Photo').child("${file.name}").putBlob(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        FirebaseFirestore.instance.collection("Photos").doc(addphotoDocummentValue).collection(addphotoDocummentValue).doc().set({
          "imgUrl":downloadUrl,
          "timestamp":DateTime.now().millisecondsSinceEpoch
        });
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Event created successfully!",
            width: size.width * 0.4,
            backgroundColor: Constants().primaryAppColor.withOpacity(0.8)
        );
      });
    });
  }

  @override
  void initState() {
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

  bool filtervalue=false;

  bool addPhoto=false;
  String addphotoDocummentValue='';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: height/81.375, horizontal: width/170.75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                            addItemPopUp();
                        },
                        child: Container(
                          height: height / 18.6,
                          width: 140,
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
                        )),

                    Padding(
                      padding: const EdgeInsets.only(left: 950),
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        addPhoto==true?const SizedBox():  Container(
            color: Colors.white,
            width: width / 1.2418,
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

                Container(
                  color: Colors.white,
                  width: width/7.6,
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
                          padding: const EdgeInsets.only(
                              left: 8),
                          child: InkWell(
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
                  width: width/7.6,
                  height: height/14.78,
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
                          padding: const EdgeInsets.only(
                              left: 8),
                          child: InkWell(
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
                              addImage(addphotoDocummentValue,size);
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
                    if(snapshot.hasData==null){
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
        SizedBox(

          height: height/1.34363, width: width/1.2288,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Photos").snapshots(),
            builder: (context, snapshot) {

              if(snapshot.hasData==null){
                return const Center(child: CircularProgressIndicator(),);
              }
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(),);
              }
              return ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {

                  var Value=snapshot.data!.docs[index];

                  return Container(
                      color: Colors.white,
                      width: width / 1.2418,
                      height: height/13.4363,
                      child: Row(
                        children: [
                          Container(
                            color: Colors.white,
                            width: width/7.2,
                            height: height/14.78,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:  EdgeInsets.only(left:width/102.4),
                              child: KText(
                                text: (index+1).toString(),
                                style: SafeGoogleFont(
                                  'Nunito',
                                  color: Color(0xff030229),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            width: width/4.38857,
                            height: height/14.78,
                            alignment: Alignment.centerLeft,
                            child: KText(
                              text: Value['name'].toString(),
                              style: SafeGoogleFont(
                                'Nunito',
                                color: Color(0xff030229),
                              ),
                            ),
                          ),

                          Container(
                            color: Colors.white,
                            width: width/7.6,
                            height: height/14.78,
                            alignment: Alignment.centerLeft,
                            child: KText(
                              text: Value['date'].toString(),
                              style: SafeGoogleFont(
                                'Nunito',
                                color: Color(0xff030229),
                              ),
                            ),
                          ),

                          Container(
                            color: Colors.white,
                            width: width/7.6,
                            height: height/14.78,
                            alignment: Alignment.centerLeft,
                            child: KText(
                              text: Value['time'].toString(),
                              style: SafeGoogleFont(
                                'Nunito',
                                color: Color(0xff030229),
                              ),
                            ),
                          ),

                          SizedBox(

                            width: width/7.6,
                            height: height/14.78,
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  addPhoto=true;
                                  addphotoDocummentValue=Value.id;
                                });
                                print(addphotoDocummentValue);
                                print("00000000000000000000000000000000000000000000000000000000000000");
                              },
                              child: Container(
                                margin: EdgeInsets.only(right:width/12.8,top:height/73.9,bottom: height/73.9),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Constants().primaryAppColor,
                                ),
                                child: Center(
                                  child: KText(
                                    text: "Add",
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
                      ));
                },);
            },),
        )
      ],
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
          // if (item == "Filter by Date") {
          //   var result = await filterPopUp();
          //   if (result) {
          //     setState(() {
          //       isFiltered = true;
          //     });
          //   }
          // }
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


}