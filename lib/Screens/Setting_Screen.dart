import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Setting_Screen extends StatefulWidget {
  const Setting_Screen({super.key});

  @override
  State<Setting_Screen> createState() => _Setting_ScreenState();
}

class _Setting_ScreenState extends State<Setting_Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Settings',
          style:GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20
          ),
        ),
      ],
    );
  }
}
