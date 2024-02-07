import 'dart:convert';


import 'package:alumni_management_admin/common_widgets/developer_card_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../Constant_.dart';
import '../Models/Language_Model.dart';
import '../utils.dart';

class Com_Notification_Screen extends StatefulWidget {
  const Com_Notification_Screen({super.key});

  @override
  State<Com_Notification_Screen> createState() =>
      _Com_Notification_ScreenState();
}

class _Com_Notification_ScreenState extends State<Com_Notification_Screen> {
  TextEditingController departmentcon = TextEditingController(text:'Select Department');
  TextEditingController yearcon = TextEditingController(text:'Select Year');

  String currentTab = 'ADD';
  bool isUsers = true;
  String Uservalue="All";
  List dropDownApplyedvalue=[];
  List<bool> Selected = List.generate(100, (index) => false);
  List<String> notifylist=[
    "All",
    "Batch",
    "Department",
    "Department/Batch",
    "Gender"
  ];
  List sendList=[];
  List StreamData=[];
  List <String> departmentDataList=[];
  List <String> yearDataList=[];

  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ///Department Fetch Function
  dropDowndataFetchFunc()async{
    setState(() {
      departmentDataList.clear();
      yearDataList.clear();
    });
    setState(() {
      departmentDataList.add('Select Department');
      yearDataList.add('Select Year');
    });
    var departmentdata=await cf.FirebaseFirestore.instance.collection("Department").orderBy("name").get();
    var acadamicYeardata=await cf.FirebaseFirestore.instance.collection("AcademicYear").orderBy("name").get();
    for(int x=0;x<departmentdata.docs.length;x++){
      setState((){
        departmentDataList.add(departmentdata.docs[x]['name'].toString());
      });
    }
    for(int y=0;y<acadamicYeardata.docs.length;y++){
      setState((){
        yearDataList.add(acadamicYeardata.docs[y]['name'].toString());
      });
    }
    print("department Data List $departmentDataList");
    print("Year Data List $yearDataList");
  }

  @override
  void initState() {

    dropDowndataFetchFunc();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height/81.375, horizontal: width/170.75),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: FadeInRight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: width/170.75,
                  left: width/170.75,
                top: height/54.25
                ),
                child: Row(
                  children: [
                    KText(
                      text: "NOTIFICATIONS",
                      style: SafeGoogleFont('Nunito',
                        fontSize: width / 82.538,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff030229),),
                    ),

                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top:height/65.1,bottom: height/65.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Padding(
                      padding:  EdgeInsets.only(left:width/1.39),
                      child: InkWell(
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
                            width: width/9.9714,
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
                              EdgeInsets.symmetric(horizontal: width / 227.66),
                              child: Center(
                                child: KText(
                                  text: currentTab.toUpperCase() == "VIEW"
                                      ? "Send Notification"
                                      : "View Notifications",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: width / 105.07,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(height:height/55.1),
              currentTab.toUpperCase() == "ADD"
                  ? Container(
                                  margin: EdgeInsets.only(left: width/68.3),
                    height: size.height * 0.85,
                     width: width/1.28,
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
                          Container(
                            color: Colors.white,
                            height: size.height * 0.08,
                            width: width/1.3837,

                            child: Row(
                              children: [
                                const Icon(Icons.message),
                                SizedBox(width: width / 136.6),
                                KText(
                                  text: "Send Notification",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    fontSize: width/68.3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: width / 1.2418,

                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            padding: EdgeInsets.only(
                             // top:height / 72.55 ,
                                bottom: height / 42.55,
                                left: width / 68.3,
                              right: width / 68.3
                             ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding: EdgeInsets.only(left: width / 54.64),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: height / 13.02,
                                            width: width / 2.464,

                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                Text("Please Select : ",style:  SafeGoogleFont (
                                                  'Poppins',
                                                )),

                                                Container(
                                                  height: height / 13.02,
                                                  width: width / 6.464,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: Colors.grey.shade300
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButtonFormField2<String>(

                                                      hint: KText(
                                                          text:'Select',
                                                          style:  SafeGoogleFont (
                                                            'Poppins',
                                                          )
                                                      ),
                                                      items: notifylist.map((String item) => DropdownMenuItem<String>(
                                                        value: item,
                                                        child: KText(
                                                            text: item,
                                                            style:  SafeGoogleFont (
                                                              'Poppins',
                                                            )
                                                        ),
                                                      ))
                                                          .toList(),
                                                      value: Uservalue,
                                                      onChanged: (String? value) {
                                                        setState(() {
                                                          Uservalue = value!;
                                                        });
                                                        dropdownSelectStreamData();
                                                      },
                                                      buttonStyleData:  const ButtonStyleData(
                                                      ),decoration: const InputDecoration(
                                                        border: InputBorder.none
                                                    ),

                                                    ),
                                                  ),
                                                ),


                                                Padding(
                                                  padding:  EdgeInsets.only(left:width/27.32),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      print("Apply Button-------------------------------------------------------");
                                                      getStreamDatafunction();
                                                    },
                                                    child: Container(
                                                      height: height / 16.6,
                                                      decoration: BoxDecoration(
                                                        color: Constants().primaryAppColor,
                                                        borderRadius:
                                                        BorderRadius.circular(8),
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
                                                            horizontal: width /60.6),
                                                        child: Center(
                                                          child: KText(
                                                            text: "Apply",
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              color: Colors.white,
                                                              fontSize: width / 106.6,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            height:height/5.0,
                                            width: width/1.536,
                                            color: Colors.white,
                                            child: SingleChildScrollView(
                                              physics: const ScrollPhysics(),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                   padding: EdgeInsets.symmetric(
                                                     vertical: height/92.375,
                                                     horizontal: width/192
                                                   ),
                                                    child:
                                                        Uservalue == "Department/Batch"?Row(
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
                                                                SizedBox(height: height / 108.5),
                                                                Material(
                                                                  borderRadius: BorderRadius.circular(3),
                                                                  color: Color(0xffDDDEEE),
                                                                  elevation: 5,
                                                                  child:
                                                                  SizedBox(
                                                                    height: height / 16.02,
                                                                    width: width / 7.0,
                                                                    child: DropdownButtonHideUnderline(
                                                                      child:
                                                                      DropdownButtonFormField2<
                                                                          String>(
                                                                        isExpanded:true,
                                                                        hint: Text(
                                                                          'Select Department',
                                                                          style:
                                                                          SafeGoogleFont(
                                                                            'Nunito',
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
                                                                                ),
                                                                              ),
                                                                            )).toList(),
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
                                                                SizedBox(height: height / 108.5),
                                                                Material(
                                                                  borderRadius: BorderRadius.circular(3),
                                                                  color: Color(0xffDDDEEE),
                                                                  elevation: 5,
                                                                  child: SizedBox(
                                                                    height: height / 16.02,
                                                                    width: width / 7.0,
                                                                    child: DropdownButtonHideUnderline(
                                                                      child:
                                                                      DropdownButtonFormField2<
                                                                          String>(
                                                                        isExpanded:true,
                                                                        hint: Text(
                                                                          'Select Year',
                                                                          style:
                                                                          SafeGoogleFont(
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
                                                                            )).toList(),
                                                                        value:
                                                                        yearcon.text,
                                                                        onChanged:
                                                                            (String? value) {
                                                                          setState(() {
                                                                            yearcon.text =
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
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ):

                                                    Uservalue=="All"?
                                                    Row(
                                                      children: [

                                                        Checkbox(
                                                          value: isUsers,
                                                          onChanged: (val) {
                                                            setState(() {
                                                              isUsers = val!;
                                                            });
                                                            print("Users Alll000000000000000000000000000000000000000000000000");
                                                            print(isUsers);
                                                          },
                                                        ),
                                                        SizedBox(width: width / 136.6),
                                                        const Text("Users")
                                                      ],
                                                    ):
                                                    SizedBox(
                                                      child: GridView.builder(
                                                        itemCount: StreamData.length,
                                                          physics: const ScrollPhysics(),
                                                          shrinkWrap: true,
                                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 5,
                                                            childAspectRatio: 110/50,
                                                          ),
                                                          itemBuilder: (context, index) {
                                                            return SizedBox(
                                                              height:height/18.475,
                                                              width:width/10.24,
                                                              child: Row(
                                                                children: [

                                                                  Checkbox(
                                                                    value: Selected[index],
                                                                    onChanged: (val) {
                                                                      setState(() {
                                                                        Selected[index] = !Selected[index];
                                                                      });
                                                                      if(Selected[index]==true){
                                                                        setState(() {
                                                                          dropDownApplyedvalue.add(StreamData[index]);
                                                                        });
                                                                        print("if Funcion------------------------------------");
                                                                        print(StreamData[index]);
                                                                        print(Selected[index]);
                                                                        print(dropDownApplyedvalue);
                                                                      }
                                                                      else{
                                                                       setState(() {
                                                                         dropDownApplyedvalue.remove(StreamData[index]);
                                                                       });
                                                                       print("Else Funcion------------------------------------");
                                                                       print(StreamData[index]);
                                                                       print(Selected[index]);
                                                                       print(dropDownApplyedvalue);
                                                                      }
                                                                    },
                                                                  ),
                                                                  SizedBox(width: width / 136.6),
                                                                  SizedBox(
                                                                    width:width/12.8,
                                                                    child: Text(StreamData[index],style: TextStyle(
                                                                      overflow: TextOverflow.ellipsis
                                                                    ),),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          },),
                                                    )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),




                                SizedBox(height: height / 65.1),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: "Subject",
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          color: Colors.black,
                                          fontSize: width / 105.07,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height:height/73.9),
                                      Container(
                                        decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                            borderRadius: BorderRadius.circular(3)),
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(
                                            horizontal: width/192,
                                            vertical: height/92.375
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none
                                            ),
                                            style: TextStyle(
                                                fontSize: width / 113.83),
                                            controller: subjectController,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: height / 21.7),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: "Description",
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        color: Colors.black,
                                        fontSize: width / 105.07,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height:height/73.9),
                                    Container(
                                        width: double.infinity,
                                        height:height/7.78,
                                        decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                            borderRadius: BorderRadius.circular(3)),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize: width / 113.83),
                                          controller:
                                          descriptionController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only(
                                                  left:
                                                  width / 91.06,
                                                  top: height /
                                                      162.75,
                                                  bottom: height /
                                                      162.75)),
                                          maxLines: null,
                                        )),
                                  ],
                                ),
                                SizedBox(height: height / 65.1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    GestureDetector(
                                      onTap: () async {
                                        print("Send Buton-----------------------------------------------");
                                        setTheData();
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
                                            child:Row(
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.send,
                                                    color: Colors.white),
                                                SizedBox(width: width /273.2),
                                                KText(
                                                  text: "SEND",
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    color: Colors.white,
                                                    fontSize: width /136.6,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : currentTab.toUpperCase() == "VIEW"
                      ? Container(
                        margin: EdgeInsets.only(left: width/68.3),
                        height: size.height * 0.85,
                       width: width/1.28,
                        color: Colors.white,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Notification').orderBy("timestamp")
                                .snapshots(),
                            builder: (ctx, snapshot) {
                              if (snapshot.hasError) {
                                return Container();
                              } else if (snapshot.hasData) {
                                List notifications = snapshot.data!.docs;
                                return Container(
                                  width: width / 1.2418,
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

                                    children: [
                                      Container(
                                        color: Colors.white,
                                        height: size.height * 0.1,
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
                                                text: "Notifications (${notifications.length})",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  fontSize: width / 68.3,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.75,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            )),
                                        padding: EdgeInsets.symmetric(
                                            vertical: height / 32.55,
                                            horizontal: width / 68.3),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: width / 17.075,
                                                    child: KText(
                                                      text: "No.",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize: width / 105.07,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width / 12.418,
                                                    child: KText(
                                                      text: "Date",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize: width / 113.83,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width / 12.418,
                                                    child: KText(
                                                      text: "Time",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize: width / 113.83,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width / 6.83,
                                                    child: KText(
                                                      text: "Subject",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize: width / 105.07,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width / 6.83,
                                                    child: KText(
                                                      text: "Content",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize: width / 105.07,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width/7.68,
                                                    child: KText(
                                                      text: "Msg Type",
                                                      style: SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize: width / 105.07,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: height / 65.1),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: notifications.length,
                                                itemBuilder: (ctx, i) {
                                                  return Container(
                                                    height: height / 10.85,
                                                    width: double.infinity,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                        top: BorderSide(
                                                          color: Color(0xfff1f1f1),
                                                          width: 0.5,
                                                        ),
                                                        bottom: BorderSide(
                                                          color: Color(0xfff1f1f1),
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: width / 17.075,
                                                          child: KText(
                                                            text:
                                                                (i + 1).toString(),
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize:
                                                                  width / 105.07,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width / 12.418,
                                                          child: KText(
                                                            text: notifications[i]['date'],
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize:
                                                                  width / 105.07,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width / 12.418,
                                                          child: KText(
                                                            text: notifications[i]['time'],
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize:
                                                                  width / 105.07,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width / 6.83,
                                                          child: KText(
                                                            text: notifications[i]['title'],
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize:
                                                                  width / 105.07,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width / 6.83,
                                                          child: KText(
                                                            text: notifications[i]
                                                                ["description"],
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize:
                                                                  width / 105.07,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width/7.68,
                                                          child: KText(
                                                            text: notifications[i]['msgType'].toString(),
                                                            style: SafeGoogleFont(
                                                              'Nunito',
                                                              fontSize:
                                                                  width / 105.07,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                      )
                      : Container(),
              SizedBox(height: height / 65.1),
              DeveloperCardWidget(),
              SizedBox(height: height / 65.1),
            ],
          ),
        ),
      ),
    );
  }


  dropdownSelectStreamData() async {
    setState(() {
      StreamData.clear();
      sendList.clear();
    });
    if(Uservalue=="All"){
      setState(() {
        isUsers=true;
      });
    }
    else if(Uservalue=="Batch"){
      var Data=await FirebaseFirestore.instance.collection("AcademicYear").orderBy("timestamp").get();
      for(int i=0;i<Data.docs.length;i++){
        setState(() {
          StreamData.add(Data.docs[i]['name']);
        });
      }
    }
    else if(Uservalue=="Department"){
      var Data=await FirebaseFirestore.instance.collection("Department").orderBy("timestamp").get();
      for(int i=0;i<Data.docs.length;i++){
        setState(() {
          StreamData.add(Data.docs[i]['name']);
        });
      }
    }
    else if(Uservalue=="Gender"){
      setState(() {
        StreamData.add("Male");
        StreamData.add("Female");
      });
    }
    else if (Uservalue == "Batch/Department") {
      print("Batch/Department Entered--------------------------------------------");
      print(dropDownApplyedvalue);

      var UserData = await FirebaseFirestore.instance.collection("Users").get();
      for (int x = 0; x < UserData.docs.length; x++) {
        var user = UserData.docs[x];
        if (dropDownApplyedvalue.contains(user['yearofpassed']) &&
            dropDownApplyedvalue.contains(user['subjectStream'])) {
          print(dropDownApplyedvalue);
          setState(() {
            sendList.add(user['Token']);
          });
          print(sendList);
          print("Send List_______________________________________");
        }
      }
    }


  }


  /// Apply button function
  getStreamDatafunction()async{
    setState(() {
      sendList.clear();
    });

    print("Submitted data Entered--------------------------------------------");
    print(Uservalue);
    if(Uservalue=="All"){
      print("Alllllllllllllll Enteredddddddddddddddddddddddddddddddddddddddd");
      var UserData=await FirebaseFirestore.instance.collection("Users").get();
      for(int x=0;x<UserData.docs.length;x++){

        setState(() {
          sendList.add(UserData.docs[x]['Token']);
        });
        print(sendList);
        print("Sned List___________________________________________________");
      }
    }
    else if(Uservalue=="Batch"){
      print("Batch Entered--------------------------------------------");
      print(dropDownApplyedvalue);
      var UserData=await FirebaseFirestore.instance.collection("Users").get();
      for(int x=0;x<UserData.docs.length;x++){
        if(dropDownApplyedvalue.contains(UserData.docs[x]['yearofpassed'])){
          print(dropDownApplyedvalue);
          setState(() {
            sendList.add(UserData.docs[x]['Token']);
          });
          print(sendList);
          print("Sned List___________________________________________________");
        }

      }
    }
    else if(Uservalue=="Department"){
      print("Department Entered--------------------------------------------");
      print(dropDownApplyedvalue);
      var UserData=await FirebaseFirestore.instance.collection("Users").get();
      for(int x=0;x<UserData.docs.length;x++){
        if(dropDownApplyedvalue.contains(UserData.docs[x]['subjectStream'])){
          print(dropDownApplyedvalue);
          setState(() {
            sendList.add(UserData.docs[x]['Token']);
          });
          print(sendList);
          print("Sned List___________________________________________________");
        }
      }
    }
    else if (Uservalue == "Batch/Department") {
      print("Batch/Department Entered--------------------------------------------");
      print(dropDownApplyedvalue);

      var UserData = await FirebaseFirestore.instance.collection("Users").get();
      for (int x = 0; x < UserData.docs.length; x++) {
        var user = UserData.docs[x];
        if (dropDownApplyedvalue.contains(user['yearofpassed']) &&
            dropDownApplyedvalue.contains(user['subjectStream'])) {
          print(dropDownApplyedvalue);
          setState(() {
            sendList.add(user['Token']);
          });
          print(sendList);
          print("Send List_______________________________________");
        }
      }
    }
    else if(Uservalue=="Gender"){

      print("Gender Entered--------------------------------------------");
      print(dropDownApplyedvalue);
        var UserData=await FirebaseFirestore.instance.collection("Users").get();
        for(int x=0;x<UserData.docs.length;x++){
          if(dropDownApplyedvalue.contains(UserData.docs[x]['Gender'])){
            print(dropDownApplyedvalue);
            setState(() {
              sendList.add(UserData.docs[x]['Token']);
            });
            print(sendList);
            print("Sned List___________________________________________________");
          }
        }

    }
  }

  /// Submit button functions
  setTheData() async {

    print("Submitted Enter00000000000000000000000000000000000000000000000000");
    print(sendList.length);
    print(sendList);

    if(sendList.isNotEmpty){
      var UserData=await FirebaseFirestore.instance.collection("Users").get();
      for(int x=0;x<UserData.docs.length;x++){
        if(sendList.contains(UserData.docs[x]['Token'].toString())){
          print(UserData.docs[x]['Token'].toString());
          print(sendList);
          print("Document Create Function Enter Successsss");
          FirebaseFirestore.instance.collection("Notification").doc().set({
            "title":subjectController.text,
            "description":descriptionController.text,
             "msgType":Uservalue,
            "date":"${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
            "time":DateFormat("hh:mm a").format(DateTime.now()),
            "timestamp":DateTime.now().millisecondsSinceEpoch
          });
          sendPushMessage(token: sendList[x],body: descriptionController.text,title: subjectController.text);
        }
      }

    }
    else{
      print("Error");
    }



  }

  void sendPushMessage({required String token, required String body, required String title}) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=AAAAMbpijGg:APA91bGJh2qke8JHGkBaJvJ5-mSnllb0aAIi-lF2YKt9MejKB-m51-SQZJR2u3tYdC9UsOB0ps_G6n29EuZPGFW5xAp4lHQDFWi11TFSDn65VyXYyFY0c-SzXuwk2fE31ADp9MdryFBB',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );

    } catch (e) {
      print("error push notification");
    }

    setState(() {
      sendList.clear();
      dropDownApplyedvalue.clear();
      descriptionController.clear();
      subjectController.clear();
      Uservalue="All";
       currentTab = 'ADD';
      isUsers = true;
      StreamData.clear();
    });
    for(int i=0;i< Selected.length;i++){
      setState(() {
        Selected[i]=false;
      });
    }

  }


}
