
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class TestINg_Pages extends StatefulWidget {
  const TestINg_Pages({super.key});

  @override
  State<TestINg_Pages> createState() => _TestINg_PagesState();
}

class _TestINg_PagesState extends State<TestINg_Pages> {

  // Data for the pie chart
  Map<String, double> dataMap = {
    "Food Items": 30.47,
    "Clothes": 17.70,
    "Technology": 4.25,
    "Cosmetics": 3.51,
    "Other": 2.83,
  };

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pie Chart example"),
      ),
      body: SingleChildScrollView(

        child: Column(
          children: [
        
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
                      child: Center(child: Text("Working Alumni")),
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
                      child: Center(child: const Text("Not Working Alumni")),
                    )
                  ],
                ),

                SimpleCircularProgressBar(
                 // valueNotifier: valueNotifier,
                  mergeMode: true,
                  onGetText: (double value) {
                    TextStyle centerTextStyle = TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent.withOpacity(value * 0.01),
                    );

                    return Text(
                      '${value.toInt()}',
                      style: centerTextStyle,
                    );
                  },
                ),

              ],
            ),
        
        
            SizedBox(
              height: 500,
              width: 500,
              child: Center(
                child: PieChart(
                  // Pass in the data for
                  // the pie chart
                  dataMap: dataMap,
                  // Set the colors for the
                  // pie chart segments
                  colorList: colorList,
                  // Set the radius of the pie chart
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  // Set the center text of the pie chart
                  centerText: "Budget",
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
            ),
          ],
        ),
      ),
    );
  }
  


  @override
  void initState() {
    getacademicAndDepartmentDataFunc();
    // TODO: implement initState
    super.initState();
  }

  List academicDataList=[];
  List departmentDataList=[];

  List<workingPerson> workingPersonListData=[];

  int TotalAlumniUserCount=0;
  int alumniWorkingCount=0;
  var currentBatchDYear=DateTime.now().year-1;

  double workingAlumniPercentage=0;
  double notworkingAlumniPercentage=0;

  getacademicAndDepartmentDataFunc()async{
    setState(() {
      academicDataList.clear();
      departmentDataList.clear();
      TotalAlumniUserCount=0;
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
    print("Department List And academic Year List++++++++++++++++++++++++++++++++++++++++++");
    print(academicDataList);
    print(departmentDataList);
    workingStatusAlumniFunc();
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
        setState(() {
          workingAlumniPercentage= workingPersonListData.length/TotalAlumniUserCount;
        });
      }
      else{
        setState(() {
          notworkingAlumniPercentage= workingPersonListData.length/TotalAlumniUserCount;
        });
      }

      print(element.workingStatus);
      print(element.workingAlumniCount);
      print(element.department);
      print(element.batch);
    });

    print("percnetage in workign Status +++++++++++++++++++++++++++++++++++++++");
    print("$TotalAlumniUserCount %");
    print("$notworkingAlumniPercentage %");
    print("$workingAlumniPercentage %");




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
