
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/Language_Model.dart';
import '../utils.dart';

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
            )


          ],
        ),
      ),
    );
  }
}
