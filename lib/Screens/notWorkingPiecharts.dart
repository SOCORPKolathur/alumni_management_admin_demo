
import 'package:alumni_management_admin/Screens/Job_Reports.dart';
import 'package:alumni_management_admin/utils.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../PieChart_all_department.dart';

class notWorkingPiecharts extends StatefulWidget {
  List? derpartMentList;
  List<workingPerson> ?departviseWorkingList;
  int ?TotalAlumniUsers;
  notWorkingPiecharts({this.derpartMentList,this.departviseWorkingList,this.TotalAlumniUsers});

  @override
  State<notWorkingPiecharts> createState() => _notWorkingPiechartsState();
}

class _notWorkingPiechartsState extends State<notWorkingPiecharts> {

  int touchedIndex= 0;

  List colors=[
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.grey,
    Colors.cyan,
    Colors.teal,
    Colors.indigo,
    Colors.amber,
    Colors.lime,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.blueGrey,
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.yellowAccent,
  ];

  @override
  void initState() {
    textingFunction();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height/2.17,
      width: width/2.483,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(
            width: width/5.253846153846154,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {

                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            ),
          ),


          SizedBox(
            width: width/5.939130434782609,
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:widget.derpartMentList!.length,
                    itemBuilder: (context, index) {
                      return  Indicator(
                        color: colors[index],
                        text: widget.derpartMentList![index].toString(),
                        isSquare: true,
                      );
                    },),


                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  var departmentColor;
  var indicatorColor;
  List<String> hexColorCodes = [
    '#FF5733', '#33FF57', '#5733FF', '#FFFF33', '#FFFF36',
  ];


  Color color(int index) {
    Set<Color> usedColors = Set<Color>();
    indicatorColor = hexColorCodes[index % hexColorCodes.length];
    Color color = Color(int.parse(indicatorColor.replaceAll("#", "0xFF")));

    while (usedColors.contains(color)) {
      indicatorColor = hexColorCodes[(index + 1) % hexColorCodes.length];
      color = Color(int.parse(indicatorColor.replaceAll("#", "0xFF")));
    }

    usedColors.add(color);
    if (color.computeLuminance() < 0.5) {
      color = color.withOpacity(0.7);
    }
    return color;
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.derpartMentList!.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 10.0;
      final radius = isTouched ? 60.0 : 50.0;

      Map<String, int> departmentCountMap = {};
      for (int j = 0; j < widget.departviseWorkingList!.length; j++) {
        if (widget.departviseWorkingList![j].department!.contains(widget.derpartMentList![i])) {
          if (widget.departviseWorkingList![j].workingStatus == "No") {
            final currentDepartment = widget.derpartMentList![i];
            departmentCountMap[currentDepartment] = (departmentCountMap[currentDepartment] ?? 0) + 1;
          }
        }
      }

      final department = widget.derpartMentList![i];
      final countForDepartment = departmentCountMap[department] ?? 0;

      // Generate a list of hexadecimal color codes


      // Get the color for the current department
      departmentColor = hexColorCodes[i % hexColorCodes.length];

      print(countForDepartment);


      print(countForDepartment);
      print(department);
      return PieChartSectionData(
        color: colors[i],
        value: (countForDepartment) / int.parse(widget.TotalAlumniUsers.toString()),
        title: '${((countForDepartment) / int.parse(widget.TotalAlumniUsers.toString()) * 100).toStringAsFixed(2)} %',
        radius: radius,
        titleStyle: SafeGoogleFont('Nunito',
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: AppColors.mainTextColor1,
        ),
      );
    });
  }

  textingFunction(){
    print("Not Working++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    for(int i=0;i<widget.departviseWorkingList!.length;i++){
      print("Working Status List value++++++++++++++++++++++++++++++++++++${widget.departviseWorkingList![i]}");

    }
    for(int j=0;j<widget.derpartMentList!.length;j++){
      print("Working Status List value++++++++++++++++++++++++++++++++++++${widget.derpartMentList![j]}");

    }

  }


}
class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}