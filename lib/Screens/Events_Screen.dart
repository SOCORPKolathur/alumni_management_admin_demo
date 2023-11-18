import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Events_Screen extends StatefulWidget {
  const Events_Screen({super.key});

  @override
  State<Events_Screen> createState() => _Events_ScreenState();
}

class _Events_ScreenState extends State<Events_Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Events',
          style:GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20
          ),
        ),
      ],
    );
  }
}
