import 'dart:convert';
import 'dart:html';
import 'dart:html' as html;

import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  addImage(String collection,Size size) {
    InputElement input = FileUploadInputElement() as InputElement
      ..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        Response res = await GalleryFireCrud.addImage(file, collection);
        if (res.code == 200) {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              text: "Event created successfully!",
              width: size.width * 0.4,
              backgroundColor: Constants().primaryAppColor.withOpacity(0.8)
          );
        } else {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: "Failed to Create Event!",
              width: size.width * 0.4,
              backgroundColor: Constants().primaryAppColor.withOpacity(0.8)
          );
        }
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
          child: KText(
            text: 'GALLERY',
            style: SafeGoogleFont (
              'Poppins',
              fontSize: 25*ffem,
              fontWeight: FontWeight.w600,
              height: 1.6*ffem/fem,
              color: Color(0xff05004e),
            ),
          ),
        ),


         SizedBox(height: size.height * 0.03),
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
                      KText(
                        text: "SLIDER IMAGES",
                        style :SafeGoogleFont (
                          'Poppins',
                          fontSize: 22*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6*ffem/fem,
                          color: Colors.white,
                        ),
                      ),
                      isEditSI
                          ? Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isEditSI = false;
                              });
                            },
                            child: KText(
                              text: "Apply",
                              style: SafeGoogleFont (
                                'Poppins',
                                fontSize: 20*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                          : Row(
                        children: [
                          InkWell(
                            onTap: () {
                              addImage('SI',size);
                            },
                            child: KText(
                              text: "ADD",
                              style: SafeGoogleFont (
                                'Poppins',
                                fontSize: 20*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                          SizedBox(width: width/91.06),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isEditSI = true;
                              });
                            },
                            child: KText(
                              text: "EDIT",
                              style: SafeGoogleFont (
                                'Poppins',
                                fontSize: 20*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.edit_note,
                            color: Colors.white,
                          ),
                          SizedBox(width: width/91.06),
                          InkWell(
                            onTap: () {
                              showImageGidView(context, 'SI');
                            },
                            child: KText(
                              text: "VIEW MORE",
                              style: SafeGoogleFont (
                                'Poppins',
                                fontSize: 20*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
                  stream: GalleryFireCrud.fetchSliderImages(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container();
                    } else if (snapshot.hasData) {
                      List<GalleryImageModel> allData = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allData.length,
                        itemBuilder: (ctx, i) {
                          return InkWell(
                            onTap: () {
                              showImageModel(context, allData[i].imgUrl!);
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
                                        allData[i].imgUrl!,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: width/136.6,
                                  top: height/65.1,
                                  child: InkWell(
                                    onTap: () {
                                      GalleryFireCrud.deleteImage(
                                          allData[i].id!, 'SI');
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
                                    allData[i].imgUrl!,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
         SizedBox(height: size.height * 0.08),
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
                      KText(
                        text: "PHOTO GALLERY",
                        style:SafeGoogleFont (
                          'Poppins',
                          fontSize: 20*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6*ffem/fem,
                          color: Colors.white,
                        ),
                      ),
                      isEditGI
                          ? Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isEditGI = false;
                              });
                            },
                            child: KText(
                              text: "Apply",
                              style: SafeGoogleFont (
                                'Poppins',
                                fontSize: 20*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                          : Row(
                        children: [
                          InkWell(
                            onTap: () {
                              addImage('GI',size);
                            },
                            child: KText(
                              text: "ADD",
                              style: SafeGoogleFont (
                                'Poppins',
                                fontSize: 20*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                          SizedBox(width: width/91.06),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isEditGI = true;
                              });
                            },
                            child: KText(
                              text: "EDIT",
                              style: SafeGoogleFont (
                                'Poppins',
                                fontSize: 20*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.edit_note,
                            color: Colors.white,
                          ),
                          SizedBox(width: width/91.06),
                          InkWell(
                            onTap: () {
                              showImageGidView(context, 'GI');
                            },
                            child: KText(
                              text: "VIEW MORE",
                              style:SafeGoogleFont (
                                'Poppins',
                                fontSize: 20*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.6*ffem/fem,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
                  stream: GalleryFireCrud.fetchGalleryImages(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container();
                    } else if (snapshot.hasData) {
                      List<GalleryImageModel> allData = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allData.length,
                        itemBuilder: (ctx, i) {
                          return InkWell(
                            onTap: () {
                              showImageModel(context, allData[i].imgUrl!);
                            },
                            child: isEditGI
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
                                        allData[i].imgUrl!,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: width/136.6,
                                  top: height/65.1,
                                  child: InkWell(
                                    onTap: () {
                                      GalleryFireCrud.deleteImage(
                                          allData[i].id!, 'GI');
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
                                )
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
                                    allData[i].imgUrl!,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
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
                fontWeight: FontWeight.w600,
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
              stream: collection.toUpperCase() == 'GI'
                  ? FirebaseFirestore.instance
                  .collection('GalleryImages')
                  .snapshots()
                  : FirebaseFirestore.instance
                  .collection('SliderImages')
                  .snapshots(),
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
                              text: collection.toUpperCase() == 'GI' ? 'Photo Gallery' : 'Slider Images',
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
                                  fontWeight: FontWeight.w600,
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
                              }),
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


}