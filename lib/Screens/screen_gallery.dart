import 'dart:developer';


import 'package:alumni_management_admin/Constant_.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Models/Language_Model.dart';
import '../utils.dart';
import 'dart:html' as html;

class ScreenGallery extends StatefulWidget {
  const ScreenGallery({Key? key}) : super(key: key);

  @override
  State<ScreenGallery> createState() => _ScreenGalleryState();
}

class _ScreenGalleryState extends State<ScreenGallery> {
  bool batchClicked = false;
  String currentTab = "Gallery";
  String currentTab2 = "";


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

    var snapshot = await FirebaseStorage.instance.ref().child('Photo').child("${file.name}").putBlob(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();




      FirebaseFirestore.instance.collection(collection).doc().set({
        "imgUrl": downloadUrl,
        "timestamp": DateTime.now().millisecondsSinceEpoch
      });


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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return FadeInRight(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0,left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // with back button
            Row(
              children: [
                 AnimatedContainer(
                  duration: const Duration(milliseconds: 330),
                  height:  35 ,width:currentTab != "Gallery"
                     ?  25 : 0,
                      child: currentTab != "Gallery" ? InkWell(
                        onTap: (){
                          setState(() {
                            if(currentTab2=="") {
                              currentTab == "Batch"
                                  ? currentTab = "Gallery"
                                  : currentTab == "AppSlider"
                                  ? currentTab = "Gallery"
                                  : currentTab = "Gallery";
                            }
                            else{
                              currentTab2="";
                            }
                          });
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 29 * ffem,
                        ),
                      ) : const SizedBox()
                    ) ,
                Container(
                  height: 30,
                  child: KText(
                    // target (gallery)
                    text: 'Gallery',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 29 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.6 * ffem / fem,
                      color: const Color(0xff05004e),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            currentTab == "Gallery"
                ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Slooders',
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 25 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.6 * ffem / fem,
                            color: const Color(0xff05004e),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: 800,
                            child: const Divider(height: 1,thickness: 1,color: Colors.black,)),
                        const SizedBox(
                          height: 20,
                        ),
                        // Slider (App Slider, Admin Slider)
                        SliderRow(width, height, ffem, fem),
                        const SizedBox(
                          height: 10,
                        ),
                        KText(
                          // Target (Department)
                          text: 'Departments',
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 25 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.6 * ffem / fem,
                            color: const Color(0xff05004e),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: 800,
                            child: const Divider(height: 1,thickness: 1,color: Colors.black,)),
                        const SizedBox(
                          height: 20,
                        ),
                        // works
                        // SliderRow(width, height, ffem, fem),
                        // Commenting here to check
                        StreamBuilder(stream: FirebaseFirestore.instance.collection("Department").snapshots(),
                            builder: (context,snapshot){
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                print("Error: ${snapshot.error}");
                                return Text("Error: ${snapshot.error}");
                              }
                              var documents = snapshot.data!.docs;
                              print("Number of documents: ${documents.length}");
                          return Container(
                            width: 1000,
                            height: 358,
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                crossAxisSpacing: 30,
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
                                      //currentTab = data['name'];
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
                        })
                      ],
                    ),
                ) :
            currentTab == "AppSlider" || currentTab == "AdminSlider" ?
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      KText(
                        text: 'Sliders',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 25 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6 * ffem / fem,
                          color: const Color(0xff05004e),
                        ),
                      ),

                      const SizedBox(
                        width: 600,

                      ),
                      InkWell(
                        onTap: (){

                          if(currentTab=="AppSlider") {
                            if(currentTab2=="Images") {
                              addImage("SliderImages", size);
                            }
                          }
                          else if(currentTab=="AdminSlider"){
                            if(currentTab2=="Images") {
                              addImage("SliderImagesAdmin", size);
                            }
                          }
                        },
                        child: AnimatedContainer(duration: const Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: currentTab2 == "" ? 0 : height / 20.6,
                          width: currentTab2 == "" ? 0 : width/10.9714,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                KText(
                                  text: currentTab2 == "Images" ? " Add Image" : "Add Videos",
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
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 800,
                      child: const Divider(height: 1,thickness: 1,color: Colors.black,)),
                  const SizedBox(
                    height: 20,
                  ),
                  currentTab2 == "" ?
                  SliderRow2(width, height, ffem, fem) :
                  currentTab == "AppSlider" ? currentTab2 == "Images" ? SizedBox(
                    //appsliderimages

                    child: StreamBuilder(stream: FirebaseFirestore.instance.collection("SliderImages").orderBy("timestamp").snapshots(),
                        builder: (context,snapshot){
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            print("Error: ${snapshot.error}");
                            return Text("Error: ${snapshot.error}");
                          }
                          var documents = snapshot.data!.docs;
                          print("Number of documents: ${documents.length}");
                          return Container(
                            width: 1000,
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                crossAxisSpacing: 30,
                              ),
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                print("Building item at index $index");
                                var data = snapshot.data!.docs[index];
                                // Access the 'batch' field and handle potential null values
                                return   InkWell(
                                  onTap: (){
                                  },
                                  child: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(data["imgUrl"],fit: BoxFit.cover,)),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                     ) : const SizedBox(
                    //appslidervideos
                  ) : currentTab2 == "Images" ? SizedBox(
                    //appsliderimages

                    child: StreamBuilder(stream: FirebaseFirestore.instance.collection("SliderImagesAdmin").orderBy("timestamp").snapshots(),
                        builder: (context,snapshot){
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            print("Error: ${snapshot.error}");
                            return Text("Error: ${snapshot.error}");
                          }
                          var documents = snapshot.data!.docs;
                          print("Number of documents: ${documents.length}");
                          return Container(
                            width: 1000,
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                crossAxisSpacing: 30,

                              ),
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                print("Building item at index $index");
                                var data = snapshot.data!.docs[index];
                                // Access the 'batch' field and handle potential null values
                                return   InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30)

                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(data["imgUrl"],fit: BoxFit.cover,)),
                                  ),
                                );
                              },
                            ),
                          );


                        }),
                  ) : const SizedBox(

                    //adminlidervidoes
                  ) ,
                  const SizedBox(
                    height: 10,
                  ),


                ],
              ),
            ) :
            const SizedBox()

          ],
        ),
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
  SliderRow2(double width, double height, double ffem, double fem) {
    return Row(
      children: [
        FileWidget(
            width: width,
            height: height,
            ffem: ffem,
            fem: fem,
            title: "Images",
            onPressed: () {
              setState(() {
                currentTab2 = "Images";
              });
            }),
        FileWidget(
            width: width,
            height: height,
            ffem: ffem,
            fem: fem,
            title: "Videos",
            onPressed: () {
              setState(() {
                currentTab2 = "Videos";
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
            return const Center(child: CircularProgressIndicator());
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
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
            return const Center(child: CircularProgressIndicator());
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
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
            child: Image.asset("assets/fileiconfinal.png"),
          ),
        ),
        const SizedBox(height: 10,),
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
