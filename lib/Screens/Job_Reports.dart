import 'package:alumni_management_admin/Constant_.dart';
import 'package:alumni_management_admin/PieChart_all_department.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Models/Language_Model.dart';
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
  List<lineData>LineDataList=[];
  List<lineData>LineDataList2=[];
  List<lineData>LineDataList3=[];

  List<AreLineData> areaLineYesList=[];
  List<AreLineData> areaLineNoList=[];
  List<AreLineData> areaLineOwnList=[];

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
                bottom: height/65.1
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
              height: size.height * 0.8,
              width: width/1.2,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        /// line graph  container
                        Material(
                          elevation:3,
                          borderRadius: BorderRadius.circular(5),
                          child: SizedBox(
                            width:600,
                            height:450,
                            child:
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: LineChart(
                                curve: Curves.linear,
                                createLineChartData(areaLineYesList,areaLineNoList,areaLineOwnList),
                                duration: Duration(milliseconds: 250),
                              ),
                            ),
                          ),
                        ),

                        ///Working Person depart fish
                        Material(
                          elevation:3,

                          borderRadius: BorderRadius.circular(5),
                          child: SizedBox(
                              height:450,
                              width: 600,
                              child:
                              SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  title: AxisTitle(textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w600),text: "Over all Department Working Status"),
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w600),text: "Percentage"),
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
                        ),
                      ],
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
                          width:1240,
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
                                      width: 1150,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(right: 30),
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
                                            width: 1010,
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
                                            padding: const EdgeInsets.only(left: 30),
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
                                height: 300,
                                width: 650,
                                child:  Alldepartment(
                                  derpartMentList:departmentDataList,
                                  departviseWorkingList: workingPersonListData,
                                  TotalAlumniUsers: TotalAlumniUserCount,
                                )),
                          ),

                          const SizedBox(width: 10,),

                          Material(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffffffff),
                            elevation: 5,
                            child: Container(
                              height: 300,
                              width: 510,
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
                                            radius: 60.0,
                                            lineWidth: 20,
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
                                            padding: const EdgeInsets.only(top:20),
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
                                            radius: 60.0,
                                            lineWidth: 20,
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
                                            padding: const EdgeInsets.only(top:20),
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
                                            radius: 60.0,
                                            lineWidth: 20,
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
                                            padding: const EdgeInsets.only(top:20),
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
                      child: Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 5,
                        child: SizedBox(
                            height: 400,
                            width: 1230,
                            child:  SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  title:AxisTitle(text: "Department",textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w600)) ,
                                  majorGridLines: const MajorGridLines(width: 0),
                                ),
                                primaryYAxis: NumericAxis(
                                  title:AxisTitle(text: "Percentage",textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w600)) ,
                                  minimum: 0,
                                  maximum: 10,
                                  borderWidth: 0,
                                  borderColor: Constants().primaryAppColor,
                                  majorGridLines: const MajorGridLines(width: 0),
                                  minorGridLines: const MinorGridLines(width: 0),
                                ),
                                series: <CartesianSeries>[
                                  ColumnSeries<BarChartData, String>(
                                    borderColor: Constants().primaryAppColor,
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

    int yesValue=0;
    int noValue=0;
    int ownsValue=0;

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
      if(UserData.docs[x]['workingStatus']=="Yes"){
        yesValue=yesValue+1;
        print("Non Condition Function Yes()");
        areaLineYesList.add(AreLineData(int.parse(UserData.docs[x]['yearofpassed'].toString()), double.parse(((yesValue/TotalAlumniUserCount)).toString())));

      }
      if(UserData.docs[x]['workingStatus']=="No"){
        noValue=noValue+1;
        print("Non Condition Function No()");
        areaLineYesList.add(AreLineData(int.parse(UserData.docs[x]['yearofpassed'].toString()), double.parse(((noValue/TotalAlumniUserCount)).toString())));

      }
      if(UserData.docs[x]['workingStatus']=="Own Business"){
        ownsValue=ownsValue+1;
        print("Non Condition Function Own Business()");
        areaLineYesList.add(AreLineData(int.parse(UserData.docs[x]['yearofpassed'].toString()), double.parse(((ownsValue/TotalAlumniUserCount)).toString())));

      }
      else{
        if(UserData.docs[x]['workingStatus']=="Yes"){
          print("1111111111111--------------YEs");
          if(departmentDataList.contains(UserData.docs[x]['subjectStream'])){
            value=value+1;
            LineDataList.add(lineData(int.parse(UserData.docs[x]['yearofpassed']), double.parse(((value/TotalAlumniUserCount)).toString())));
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
    print(areaLineYesList);
    print(LineDataList);
    print(LineDataList2);
    print(LineDataList3);
    print("Smooth Line graphh---------------------------------------------------");





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


  LineChartData createLineChartData(
      List<AreLineData> lineDataList, List<AreLineData> lineDataList2,
      List<AreLineData> lineDataList3,) {
    return LineChartData(
      lineTouchData: lineTouchData1,
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          color: Colors.orange,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: lineDataList.map((data) => FlSpot(data.year.toDouble(), data.percentage)).toList(),

        ),
        LineChartBarData(
          isCurved: true,
          color: Colors.pink,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: lineDataList2.map((data) => FlSpot(data.year.toDouble(), data.percentage)).toList(),

        ),
        LineChartBarData(
          isCurved: true,
          color: Colors.green,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: lineDataList3.map((data) => FlSpot(data.year.toDouble(), data.percentage)).toList(),

        ),
      ],
      titlesData:  titlesData1,
      borderData: borderData,
      gridData: gridData,
      minX: 0,
      maxX: 14,
      maxY: 10,
      minY: 0,
    );
  }



  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom:
      BorderSide(color: Constants().primaryAppColor, width: 1),
      left:  BorderSide(color: Constants().primaryAppColor, width: 1),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      axisNameWidget: Text("Years",style: GoogleFonts.nunito(fontWeight: FontWeight.w600),),
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      axisNameWidget: Text("Percentage",style: GoogleFonts.nunito(fontWeight: FontWeight.w600),),
      sideTitles: leftTitles(),
    ),
  );
  FlGridData get gridData => const FlGridData(show: false);
  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );
  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );
  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 30,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = GoogleFonts.nunito(
      fontWeight: FontWeight.bold,
    );

    String text;
    switch (value.toInt()) {
      case 1:
        text = '10';
        break;
      case 2:
        text = '20';
        break;
      case 3:
        text = '30';
        break;
      case 4:
        text = '40';
        break;
      case 5:
        text = '50';
        break;
      case 6:
        text = '60';
        break;
      case 7:
        text = '70';
        break;
      case 8:
        text = '80';
        break;
      case 9:
        text = '90';
        break;
      case 10:
        text = '100';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }
  Widget bottomTitleWidgets(double value, TitleMeta meta,) {
     var style = GoogleFonts.nunito(
      fontWeight: FontWeight.bold,
    );

     Widget text = const Text('');


     int localvalue=0;

     while(academicDataList.length>localvalue){
       text = Text(
         academicDataList[localvalue].toString(),
         style: style,
       );
       localvalue=localvalue+1;

     }
     /*for (int i = 0; i < academicDataList.length; i++) {
       text = Text(
         academicDataList[i].toString(),
         style: style,
       );
       print("valueeeeeeeeeeee+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
       print("printing the value of $i");
       print(academicDataList.length);
       print("length of list Completed11111111111111111111_______________________________________________");
       if (i== academicDataList.length-1) {

         print("length of list Completed22222222222222222222222222222222222222_______________________________________________");
         break;
       }
     }*/
     return SideTitleWidget(
       axisSide: meta.axisSide,
       space: 10,
       child: text,
     );
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

class lineData {
  lineData(this.x, this.y);
  final int x;
  final double? y;
}

class AreLineData {
  final int year;
  final double percentage;

  AreLineData(this.year, this.percentage);
}


