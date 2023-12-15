
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Job_Reports extends StatefulWidget {
  const Job_Reports({super.key});

  @override
  State<Job_Reports> createState() => _Job_ReportsState();
}

class _Job_ReportsState extends State<Job_Reports> {




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.only(top:height/26.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Job Reports',
            style:GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: width / 82.538,
            ),
          ),
          FadeInRight(
            child: SizedBox(
              width: width / 1.26,
              height: height/1.23166,

            ),
          )
        ],
      ),
    );
  }
}
