
import 'package:alumni_management_admin/Constant_.dart';
import 'package:alumni_management_admin/PieChart_all_department.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../Models/Language_Model.dart';
import '../Testinf_screen.dart';
import '../utils.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class Job_Reports extends StatefulWidget {
  const Job_Reports({super.key});

  @override
  State<Job_Reports> createState() => _Job_ReportsState();
}

class _Job_ReportsState extends State<Job_Reports> {

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
  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];
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
  final ScrollController _horizontal = ScrollController();
  final List<BarChartData> chartData = [];
  final List<OwnBusinessBarChartData> OwnBusinesschartData = [];

  @override
  void initState() {
    getacademicAndDepartmentDataFunc();
    getYears(1950);
    // TODO: implement initState
    super.initState();
  }
  List<lineData>LineDataList=[

  ];
  List<lineData>LineDataList2=[
  ];
  List<lineData>LineDataList3=[
  ];

  @override
  Widget build(BuildContext context) {
    final List<Color> columnColors = chartData.map((data) => data.color).toList();
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.only(top:height/26.04),
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
                    text: "Alumni Tracking",
                    style: SafeGoogleFont('Nunito',
                      fontSize: width / 82.538,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff030229),),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.85,
              width: width/1.28,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(
                      width:600,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          isVisible: true
                        ),
                        primaryYAxis: NumericAxis(
                          maximum: 100,
                          minimum: 10
                        ),
                        series: <CartesianSeries>[
                          SplineAreaSeries <lineData, int>(
                            color: Colors.blue.withOpacity(0.5),
                            splineType:SplineType.clamped ,
                            dataSource: LineDataList,
                            xValueMapper: (lineData data, _) => data.x,
                            yValueMapper: (lineData data, _) => data.y,
                          ),
                        ],
                      ),
                    ),
                   // Testing_screen(CurrentYearValue: currentBatchDYear,departmentDataList: departmentDataList),
                   // LineChartSample2(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(8),
                        elevation: 2,
                        child: Container(
                          height:120,
                          width:1160,
                          decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Select the Year",style:
                              SafeGoogleFont('Nunito',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black
                              ),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SingleChildScrollView(
                                    controller: _horizontal,
                                    child: SizedBox(
                                      height: 50,
                                      width: 1000,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(right: 20),
                                            child: GestureDetector(
                                              onTap: () {
                                                scrollToPreviousYear();
                                              },
                                              child: CircleAvatar(
                                                child: Icon(Icons.arrow_back),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 880,
                                            child: Scrollbar(
                                              child: ListView.builder(
                                                controller: _horizontal,
                                                reverse: false,
                                                scrollDirection: Axis.horizontal,
                                                itemCount: dateList.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        scrollToYearWithAnimation(index);
                                                        setState(() {
                                                          currentBatchDYear = dateList[index];
                                                        });
                                                        print(currentBatchDYear);
                                                        print('Current Year ++++++++++++++++++++++++++++');
                                                        workingStatusAlumniFunc();
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            color: currentBatchDYear == dateList[index]
                                                                ? Constants().primaryAppColor
                                                                : Colors.white,
                                                            border: Border.all(
                                                              color:  currentBatchDYear == dateList[index]
                                                                  ?Colors.white:Constants().primaryAppColor,
                                                            )
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            dateList[index].toString(),
                                                            style: SafeGoogleFont('Nunito',
                                                              color: currentBatchDYear == dateList[index]
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: GestureDetector(
                                              onTap: () {
                                                scrollToNextYear();
                                              },
                                              child: CircleAvatar(
                                                foregroundColor: Colors.red,
                                                child: Icon(Icons.arrow_forward),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height:5),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Material(
                            elevation: 5,
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 250,
                                width: 550,
                                child:  Alldepartment(
                                  derpartMentList:departmentDataList,
                                  departviseWorkingList: workingPersonListData,
                                  TotalAlumniUsers: TotalAlumniUserCount,
                                )),
                          ),
                          SizedBox(width: 10,),

                          Material(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffffffff),
                            elevation: 5,
                            child: Container(
                              height: 250,
                              width: 450,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffffffff),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      height:40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Constants().primaryAppColor
                                      ),
                                      child: Center(child: Text("Total Alumna's : $TotalAlumniUserCount",style: SafeGoogleFont('Nunito',fontWeight: FontWeight.w700,color: Colors.white),))),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          CircularPercentIndicator(
                                            radius: 55.0,
                                            lineWidth: 18.0,
                                            curve: Curves.easeIn,
                                            animation: true,
                                            animationDuration: 1500,
                                            animateFromLastPercent: true,
                                            percent: workingAlumniPercentage,
                                            center: Text("${(workingAlumniPercentage*100).toStringAsFixed(0)} %"),
                                            progressColor: Colors.green,
                                            backgroundColor: Colors.grey,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child: Material(
                                              elevation: 5,
                                              borderRadius: BorderRadius.circular(50),
                                              color: Colors.green,
                                              child: Container(
                                                height: 40,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    color: Colors.green
                                                ),
                                                child:  Center(child: Text("Working",style: SafeGoogleFont('Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white))),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          CircularPercentIndicator(
                                            radius: 55.0,
                                            lineWidth: 18.0,
                                            curve: Curves.easeIn,
                                            animation: true,
                                            animationDuration: 1500,
                                            animateFromLastPercent: true,
                                            percent: notworkingAlumniPercentage,
                                            center: Text("${(notworkingAlumniPercentage*100).toStringAsFixed(0)} %"),
                                            progressColor: Colors.red,
                                            backgroundColor: Colors.grey,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child: Material(
                                              elevation: 5,
                                              borderRadius: BorderRadius.circular(50),
                                              color: Colors.green,
                                              child: Container(
                                                height: 40,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    color: Colors.red
                                                ),
                                                child:  Center(child: Text("Not Working",style: SafeGoogleFont('Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white))),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          CircularPercentIndicator(
                                            radius: 55.0,
                                            lineWidth: 18.0,
                                            curve: Curves.easeIn,
                                            animation: true,
                                            animationDuration: 1500,
                                            animateFromLastPercent: true,
                                            percent: ownBusinessAlumniPercentage,
                                            center: Text("${(ownBusinessAlumniPercentage*100).toStringAsFixed(0)} %"),
                                            progressColor: Color(0xffEABE3B),
                                            backgroundColor: Colors.grey,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child: Material(
                                              elevation: 5,
                                              borderRadius: BorderRadius.circular(50),
                                              color: Color(0xffEABE3B),
                                              child: Container(
                                                height: 40,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    color: Color(0xffEABE3B),
                                                ),
                                                child:  Center(child: Text("Own Business",style: SafeGoogleFont('Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white
                                                ),)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          /// all Department Working Person
                          SizedBox(
                              height: 400,
                              width: 1200,
                              child:  SfCartesianChart(
                                  primaryXAxis: CategoryAxis(
                                    majorGridLines: MajorGridLines(width: 0),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    minimum: 0,
                                    maximum: 10,
                                    majorGridLines: MajorGridLines(width: 0),
                                    minorGridLines: MinorGridLines(width: 0),
                                  ),
                                  series: <CartesianSeries>[
                                    ColumnSeries<BarChartData, String>(
                                      dataSource: chartData,
                                      xValueMapper: (BarChartData data, _) => data.x,
                                      yValueMapper: (BarChartData data, _) => data.y,
                                      sortingOrder: SortingOrder.ascending,
                                      pointColorMapper: (BarChartData data, _) => data.color,
                                      // Sorting based on the specified field
                                      sortFieldValueMapper: (BarChartData data, _) => data.x,
                                      width:0.15,
                                    )
                                  ]
                              )
                          ),


                          ///Working Person depart fish
                          SizedBox(
                              height: 400,
                              width: 1200,
                              child:
                              SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: 10,
                                  majorGridLines: MajorGridLines(width: 0), // Remove major grid lines
                                  minorGridLines: MinorGridLines(width: 0),
                                ),
                                series: <CartesianSeries>[
                                  ColumnSeries<OwnBusinessBarChartData, String>(
                                    dataSource: OwnBusinesschartData,
                                    xValueMapper: (OwnBusinessBarChartData data, _) => data.x,
                                    yValueMapper: (OwnBusinessBarChartData data, _) => data.y,
                                    sortingOrder: SortingOrder.ascending,
                                    pointColorMapper: (OwnBusinessBarChartData data, _) => data.color,
                                    sortFieldValueMapper: (OwnBusinessBarChartData data, _) => data.x,
                                    width:0.15,
                                  ),
                                ],
                              )

                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }





  scrollToYear(int index) {
    _horizontal.animateTo(
      index * 100.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  scrollToNextYear() {
    final nextIndex = dateList.indexOf(currentBatchDYear) + 1;
    if (nextIndex < dateList.length) {
      scrollToYear(nextIndex);
      setState(() {
        currentBatchDYear = dateList[nextIndex];
      });
    }
  }

  scrollToPreviousYear() {
    final previousIndex = dateList.indexOf(currentBatchDYear) - 1;
    if (previousIndex >= 0) {
      scrollToYear(previousIndex);
      setState(() {
        currentBatchDYear = dateList[previousIndex];
      });
    }

  }

  void scrollToYearWithAnimation(int index) {
    _horizontal.animateTo(
      index * (80 + 2 * 8), // Adjust this value based on your item size and padding
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }



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
    workingStatusAlumniFunc();

  }

  workingStatusAlumniFunc()async{
    setState(() {
      TotalAlumniUserCount=0;
      workingAlumniPercentage=0;
      notworkingAlumniPercentage=0;
      ownBusinessAlumniPercentage=0;
      workingPersonListData.clear();
      alumniWorkingCount=0;
      chartData.clear();
      OwnBusinesschartData.clear();
    });
    int value=0;
    int value2=0;
    int value3=0;

    print(departmentDataList);
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
      else{
        if(UserData.docs[x]['workingStatus']=="Yes"){
          print("1111111111111--------------YEs");
          if(departmentDataList.contains(UserData.docs[x]['subjectStream'])){
            value=value+1;
            LineDataList.add(lineData(int.parse(UserData.docs[x]['yearofpassed']), double.parse(((value/TotalAlumniUserCount)).toString()))
            );
          }

        }
        if(UserData.docs[x]['workingStatus']=="No"){
          print("2222222222222--------------No");
          if(departmentDataList.contains(UserData.docs[x]['subjectStream'])){
            value2=value2+1;
            LineDataList2.add(
                lineData(int.parse(UserData.docs[x]['yearofpassed']), double.parse(((value2/TotalAlumniUserCount)*100).toString()))
            );
          }
        }
        if(UserData.docs[x]['workingStatus']=="Own Business"){
          print("3333333333333--------------Own Business");
          if(departmentDataList.contains(UserData.docs[x]['subjectStream'])){
            value3=value3+1;
            LineDataList3.add(
                lineData(int.parse(UserData.docs[x]['yearofpassed']), double.parse(((value3/TotalAlumniUserCount)*100).toString()))
            );
          }
        }
      }
    }

    print("User over all working Status List++++++++++++++++++++++++++++++++++++++++++++");
    print("total Alumni $TotalAlumniUserCount");
    print(currentBatchDYear);

    int CountValue=0;
    int CountValue2=0;

    int workingStatusYes=0;
    int workingStatusNO=0;
    int workingStatusOwnBus=0;


    workingPersonListData.forEach((element) {

      if(element.workingStatus=="Yes"){
        workingStatusYes=workingStatusYes+1;
        print(element.workingStatus);
        setState(() {
          workingAlumniPercentage= workingStatusYes/TotalAlumniUserCount;
        });
        print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        print(departmentDataList);
        print(element.department);
        print("----------------------------------------------------------------------");
        if(departmentDataList.contains(element.department)){
          CountValue=CountValue+1;
          print('Department++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
          chartData.add(BarChartData.randomColor(element.department.toString(), CountValue / TotalAlumniUserCount));

        }
      }

      if(element.workingStatus=="No"){
        workingStatusNO=workingStatusNO+1;
        setState(() {
          notworkingAlumniPercentage= (TotalAlumniUserCount-workingStatusNO)/TotalAlumniUserCount;
        });
      }

      if(element.workingStatus=="Own Business"){
        workingStatusOwnBus=workingStatusOwnBus+1;
        ownBusinessAlumniPercentage= (workingStatusOwnBus/TotalAlumniUserCount);
      }


      if(departmentDataList.contains(element.department)){
        CountValue2=CountValue2+1;
        print('Department++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
        OwnBusinesschartData.add(OwnBusinessBarChartData.randomColor(element.workingStatus.toString(), CountValue2 / TotalAlumniUserCount));

        print(element.batch.toString());
        print("Batch+++++++++++++++++++++++++++++++++++++++++");
        print("Working   Status++++++++++++++++++++++++++++++++++++++");

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


class BarChartData {
  BarChartData(this.x, this.y,this.color);
  final String x;
  final double? y;
  final Color color;
  factory BarChartData.randomColor(String x, double? y) {
    // Generate a random color
    final randomColor = Color(Random().nextInt(0xFFFFFFFF) | 0xFF000000);
    return BarChartData(x, y, randomColor);
  }
}

class OwnBusinessBarChartData {
  OwnBusinessBarChartData(this.x, this.y,this.color);
  final String x;
  final double? y;
  final Color color;
  factory OwnBusinessBarChartData.randomColor(String x, double? y) {
    // Generate a random color
    final randomColor = Color(Random().nextInt(0xFFFFFFFF) | 0xFF000000);
    return OwnBusinessBarChartData(x, y, randomColor);
  }
}



