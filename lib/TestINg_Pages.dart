
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'Constant_.dart';
import 'PieChart_all_department.dart';

class TestINg_Pages extends StatefulWidget {
  const TestINg_Pages({super.key});

  @override
  State<TestINg_Pages> createState() => _TestINg_PagesState();
}

class _TestINg_PagesState extends State<TestINg_Pages> {

  // Data for the pie chart


  List<String> name =["sd"];
  List<double> vl =[0];


  late Map<String, double> dataMap={};

   Map<String, double> dataMap2={
     "Computer":20.00,
     "Computer":40.00,
     "Computer":60.00,
     "Computer":80.00,
     "Computer":90.00,
   };

  /*setval(){
    for(int i=0;i<name.length;i++){
      dataMap = {
        name[i]:vl[i]
      };
    }
    print(dataMap);
  */


  // Colors for each segment
  // of the pie chart
  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];

  // List of gradients for the
  // background of the pie chart
  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  GlobalKey _key = GlobalKey();
  ScrollController _scrollController=ScrollController();

  final ScrollController _horizontal = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pie Chart example"),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),

        child: Column(
          children: [

            Scrollbar(
              controller: _horizontal,
              thumbVisibility: true,
              trackVisibility: true,
              notificationPredicate: (notif) => notif.depth == 1,
              child: SingleChildScrollView(
                controller: _horizontal,
                physics: ScrollPhysics(),
                child: SizedBox(
                  height: 50,
                  width: 1200,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dateList.length,
                    itemBuilder:
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(

                        onTap: (){

                          if(currentBatchDYear>dateList[index]){
                            _scrollController.animateTo(
                                _scrollController.position.pixels-index*10,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut);
                          }
                          else{
                            _scrollController.animateTo(
                                _scrollController.position.pixels+index*10,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut);
                          }

                          print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
                          setState(() {
                            currentBatchDYear=dateList[index];
                          });
                          print(currentBatchDYear);
                          print('Current Year ++++++++++++++++++++++++++++');
                          workingStatusAlumniFunc();
                        },
                        child: Container(
                            height: 20,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:
                              currentBatchDYear==dateList[index]?
                              Constants().primaryAppColor:Colors.red
                            ),

                            child: Center(child: Text(dateList[index].toString()))),
                      ),
                    );
                  },),
                ),
              ),
            ),
        
            Row(
              children: [
        
                Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 50.0,
                      lineWidth: 15.0,
                      curve: Curves.easeIn,
                      animation: true,
                      animationDuration: 1500,
                      animateFromLastPercent: true,
                      percent: workingAlumniPercentage,
                      center: Text("${(workingAlumniPercentage*100).toStringAsFixed(0)} %"),
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey,
                    ),
                    Container(
                      height: 50,
                      width: 120,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.green
                      ),
                      child: Center(child: Text("Working")),
                    )
                  ],
                ),
        
                Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 50.0,
                      lineWidth: 15.0,
                      curve: Curves.easeIn,
                      animation: true,
                      animationDuration: 1500,
                      animateFromLastPercent: true,
                      percent: notworkingAlumniPercentage,
                      center: Text("${(notworkingAlumniPercentage*100).toStringAsFixed(0)} %"),
                      progressColor: Colors.red,
                      backgroundColor: Colors.grey,
                    ),
                    Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.green
                      ),
                      child: Center(child: const Text("Not Working")),
                    )
                  ],
                ),

                Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 50.0,
                      lineWidth: 15.0,
                      curve: Curves.easeIn,
                      animation: true,
                      animationDuration: 1500,
                      animateFromLastPercent: true,
                      percent: ownBusinessAlumniPercentage,
                      center: Text("${(ownBusinessAlumniPercentage*100).toStringAsFixed(0)} %"),
                      progressColor: Colors.yellow,
                      backgroundColor: Colors.grey,
                    ),
                    Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.yellow
                      ),
                      child: const Center(child: Text("Own Business")),
                    )
                  ],
                ),

              ],
            ),
        
        Text(TotalAlumniUserCount.toString()),
        Text(dataMap.toString()),

           /* SizedBox(
              height: 500,
              width: 500,
              child: Center(
                child:
                PieChart(
                  // Pass in the data for
                  // the pie chartR
                  dataMap: dataMap,
                  // Set the colors for the
                  // pie chart segments
                  colorList: colorList,
                  // Set the radius of the pie chart
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  // Set the center text of the pie chart
                //  centerText: "Budget",
                  // Set the width of the
                  // ring around the pie chart
                  ringStrokeWidth: 24,
                  // Set the animation duration of the pie chart
                  animationDuration: const Duration(seconds: 3),
                  // Set the options for the chart values (e.g. show percentages, etc.)
                  chartValuesOptions: const ChartValuesOptions(
                      showChartValues: true,
                      showChartValuesOutside: true,
                      showChartValuesInPercentage: true,
                      showChartValueBackground: false),
                  // Set the options for the legend of the pie chart
                  legendOptions: const LegendOptions(
                      showLegends: true,
                      legendShape: BoxShape.rectangle,
                      legendTextStyle: TextStyle(fontSize: 15),
                      legendPosition: LegendPosition.bottom,
                      showLegendsInRow: true),
                  // Set the list of gradients for
                  // the background of the pie chart
                  gradientList: gradientList,
                ),
              ),
            ),*/
            SizedBox(
                height: 500,
                width: 500,
                child:  Alldepartment(derpartMentList:departmentDataList))





          ],
        ),
      ),
    );
  }
  


  @override
  void initState() {
    getacademicAndDepartmentDataFunc();
    getYears(1950);
    workingStatusAlumniFunc();
    // TODO: implement initState
    super.initState();
  }

  List academicDataList=[];
  List departmentDataList=[];
  List dateList=[];

  List<workingPerson> workingPersonListData=[];

  int TotalAlumniUserCount=0;
  int alumniWorkingCount=0;
  var currentBatchDYear=DateTime.now().year-1;

  double workingAlumniPercentage=0;
  double notworkingAlumniPercentage=0;
  double ownBusinessAlumniPercentage=0;




  getacademicAndDepartmentDataFunc()async{
    setState(() {
      academicDataList.clear();
      departmentDataList.clear();
    });
    var academictData=await FirebaseFirestore.instance.collection("AcademicYear").orderBy("name").get();
    for(int i=0;i<academictData.docs.length;i++){
      setState(() {
        academicDataList.add(academictData.docs[i]['name']);
      });
    }
    var departmentData=await FirebaseFirestore.instance.collection("Department").orderBy("name").get();
    for(int j=0;j<departmentData.docs.length;j++){
      setState(() {
        departmentDataList.add(departmentData.docs[j]['name']);
      });
    }

  }


  workingStatusAlumniFunc()async{
    setState(() {
      TotalAlumniUserCount=0;
    });

    var UserData= await  FirebaseFirestore.instance.collection('Users').orderBy("timestamp").get();
    setState(() {
      TotalAlumniUserCount=UserData.docs.length;
    });
    for(int x=0;x<UserData.docs.length;x++){
      if(int.parse(UserData.docs[x]['yearofpassed'].toString())==currentBatchDYear){
        setState(() {
          alumniWorkingCount=alumniWorkingCount+1;
          workingPersonListData.add(
              workingPerson(
                batch: UserData.docs[x]['yearofpassed'].toString(),
                department:UserData.docs[x]['subjectStream'].toString() ,
                workingAlumniCount:alumniWorkingCount,
                workingStatus:UserData.docs[x]['workingStatus'].toString() ,
              )
          );

        });
      }
    }

    print("User over all working Status List++++++++++++++++++++++++++++++++++++++++++++");
    print("total Alumni $TotalAlumniUserCount");
    print(currentBatchDYear);
    workingPersonListData.forEach((element) {

      if(element.workingStatus=="Yes"){
        print(element.workingStatus);
        setState(() {
          workingAlumniPercentage= workingPersonListData.length/TotalAlumniUserCount;
        });
        dataMap[element.department.toString()] = double.parse(((workingPersonListData.length/TotalAlumniUserCount*100).toString()));

      }
      if(element.workingStatus=="Own Business"){
        ownBusinessAlumniPercentage= workingPersonListData.length/TotalAlumniUserCount;
      }
        setState(() {
          notworkingAlumniPercentage= (TotalAlumniUserCount-workingPersonListData.length)/TotalAlumniUserCount;
        });

      print(element.workingStatus);
      print(element.workingAlumniCount);
      print(element.department);
      print(element.batch);
    });

    print("percnetage in workign Status +++++++++++++++++++++++++++++++++++++++");
    print("$TotalAlumniUserCount %");
    print("$notworkingAlumniPercentage %");
    print("$workingAlumniPercentage %");
    print(dataMap);
    print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");







  }

  getYears(int year) {
    int currentYear = DateTime.now().year;

    List<int> yearsTilPresent = [];

    while (year <= currentYear) {
      yearsTilPresent.add(year);
      year++;
    }
    setState(() {
      dateList=yearsTilPresent;
    });

  }

}




class ChartData {
  ChartData(this.x, this.y, this.color22);
  final String x;
  final double y;
  final Color color22;
  }


  class workingPerson{

  String? department;
  String ?batch;
  String ?workingStatus;
  int ?workingAlumniCount;
  workingPerson({this.batch,this.department,this.workingStatus,this.workingAlumniCount});

  }


class DataModel {
  String category;
  double value;

  DataModel({required this.category, required this.value});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      category: json['category'],
      value: json['value'].toDouble(),
    );
  }
}



