import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Reports_Screen extends StatefulWidget {
  const Reports_Screen({super.key});

  @override
  State<Reports_Screen> createState() => _Reports_ScreenState();
}

class _Reports_ScreenState extends State<Reports_Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Reports',
          style:GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20
          ),
        ),
      ],
    );
  }
}
