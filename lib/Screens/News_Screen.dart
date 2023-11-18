import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class News_Screen extends StatefulWidget {
  const News_Screen({super.key});

  @override
  State<News_Screen> createState() => _News_ScreenState();
}

class _News_ScreenState extends State<News_Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'News',
          style:GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20
          ),
        ),
      ],
    );
  }
}
