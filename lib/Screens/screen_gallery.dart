import 'dart:developer';


import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/Language_Model.dart';
import '../utils.dart';

class ScreenGallery extends StatefulWidget {
  const ScreenGallery({Key? key}) : super(key: key);

  @override
  State<ScreenGallery> createState() => _ScreenGalleryState();
}

class _ScreenGalleryState extends State<ScreenGallery> {
  bool batchClicked = false;
  String currentTab = "Gallery";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return FadeInRight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          currentTab != "Gallery"
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      currentTab == "Batch"
                          ? currentTab = "Gallery"
                          : currentTab == "AppSlider"
                              ? currentTab = "Gallery"
                              : currentTab = "Gallery";
                    });
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ))
              : SizedBox(height: 5,),
          SizedBox(
            height: 30,
          ),
          KText(
            text: 'Gallery',
            style: SafeGoogleFont(
              'Poppins',
              fontSize: 29 * ffem,
              fontWeight: FontWeight.w600,
              height: 1.6 * ffem / fem,
              color: Color(0xff05004e),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          currentTab == "Gallery"
              ? SingleChildScrollView(
                child: Column(
                    children: [
                      KText(
                        text: 'Sliders',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 25 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6 * ffem / fem,
                          color: Color(0xff05004e),
                        ),
                      ),
                      Divider(height: 5,thickness: 18,color: Colors.black,),
                      SizedBox(
                        height: 10,
                      ),
                      SliderRow(width, height, ffem, fem),
                      SizedBox(
                        height: 10,
                      ),
                      KText(
                        text: 'Departements',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 25 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6 * ffem / fem,
                          color: Color(0xff05004e),
                        ),
                      ),
                      SizedBox(),
                      // departementGrid(width, height, ffem, fem)
                    ],
                  ),
              )
              : currentTab == "Batch" ?  KText(
            text: 'Batch',
            style: SafeGoogleFont(
              'Poppins',
              fontSize: 25 * ffem,
              fontWeight: FontWeight.w600,
              height: 1.6 * ffem / fem,
              color: Color(0xff05004e),
            ),
          ):
          SizedBox(
            height: 30,
          ),
          
          SizedBox(height: height / 65.1),
          SizedBox(height: height / 65.1),
        ],
      ),
    );
  }

  /// To see Slider and
  SliderRow(double width, double height, double ffem, double fem) {
    return Row(
      children: [
        FileWidget(
            width: width,
            height: height,
            ffem: ffem,
            fem: fem,
            title: "App Slider",
            onPressed: () {
              setState(() {
                currentTab = "AppSlider";
              });
            }),
        FileWidget(
            width: width,
            height: height,
            ffem: ffem,
            fem: fem,
            title: "Admin Slider",
            onPressed: () {
              setState(() {
                currentTab = "AdminSlider";
              });
            }),
      ],
    );
  }

  ///For seening Departement gallery folders
  Expanded departementGrid(
      double width, double height, double ffem, double fem) {
    return Expanded(
      // Add this Expanded widget
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Department").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            log("Error: ${snapshot.error}");
            return Text("Error: ${snapshot.error}");
          }
          var documents = snapshot.data!.docs;
          log("Number of documents: ${documents.length}");
          return Container(
            width: 1000,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 30,
                mainAxisSpacing: 50,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                print("Building item at index $index");
                var data = snapshot.data!.docs[index];
                // Access the 'batch' field and handle potential null values
                String batchTitle = data['name'] ?? "No Batch";
                return FileWidget(
                  onPressed: () {
                    setState(() {
                      currentTab = "Batch";
                    });
                  },
                  width: width,
                  height: height,
                  ffem: ffem,
                  fem: fem,
                  title: batchTitle,
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// For seeing Year wise (Batch) folders
  Expanded batchGrid(double width, double height, double ffem, double fem) {
    return Expanded(
      // Add this Expanded widget
      child: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("AcademicYear").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            log("Error: ${snapshot.error}");
            return Text("Error: ${snapshot.error}");
          }
          var documents = snapshot.data!.docs;
          log("Number of documents: ${documents.length}");
          return Container(
            width: 1000,
            height: 1000,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                print("Building item at index $index");
                var data = snapshot.data!.docs[index];
                // Access the 'batch' field and handle potential null values
                String Title = data['name'] ?? "No Batch";
                return FileWidget(
                  onPressed: () {},
                  width: width,
                  height: height,
                  ffem: ffem,
                  fem: fem,
                  title: Title,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class FileWidget extends StatelessWidget {
  const FileWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.ffem,
    required this.fem,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final double width;
  final double height;
  final double ffem;
  final double fem;
  final String title;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            width: width * 0.1,
            height: height * 0.1,
            child: Image.asset("assets/images/file png re edit.png"),
          ),
        ),
        KText(
          text: title,
          style: SafeGoogleFont(
            'Poppins',
            fontSize: 16 * ffem,
            fontWeight: FontWeight.w600,
            height: 1.6 * ffem / fem,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
