import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reports_Screen extends StatefulWidget {
  const Reports_Screen({super.key});

  @override
  State<Reports_Screen> createState() => _Reports_ScreenState();
}

class _Reports_ScreenState extends State<Reports_Screen> {
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
            Text(
              'Reports',
              style:GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                fontSize: width / 82.538,
              ),
            ),
          SizedBox(
            width: width / 1.26,
            height: height/1.23166,

          )
          ],
        ),
      ),
    );
  }
}
