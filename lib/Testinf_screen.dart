
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Testing_screen extends StatefulWidget {
  const Testing_screen({super.key});

  @override
  State<Testing_screen> createState() => _Testing_screenState();
}

class _Testing_screenState extends State<Testing_screen> {



  final List<LineData> lineDataList = [
    LineData(2010, 20),
    LineData(2011, 40),
    LineData(2012, 60),
    LineData(2013, 80),
    LineData(2014, 100),
  ];

  LineChartData createLineChartData(List<LineData> lineDataList) {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: lineDataList.map((data) => FlSpot(data.year.toDouble(), data.percentage)).toList(),
          isCurved: true,
          color: Colors.blue,
          belowBarData: BarAreaData(show: false),
        ),
      ],
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles:SideTitles(showTitles: true) ),
        bottomTitles: AxisTitles(sideTitles:SideTitles(showTitles: true) ),
      ),
      borderData: FlBorderData(show: true),
      gridData: FlGridData(show: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Smooth Line and Area Graph'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
        LineChart(
          createLineChartData(lineDataList),
          duration: Duration(milliseconds: 250),
        ),
      ),
    );

  }






  }
class LineData {
  final int year;
  final double percentage;

  LineData(this.year, this.percentage);
}
