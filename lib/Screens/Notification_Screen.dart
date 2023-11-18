import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notification_Screen extends StatefulWidget {
  const Notification_Screen({super.key});

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return
       Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Text(
                'Notification Page',
                style:GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
            ],
          ),
        ),
      );
  }
}
