import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:hexcolor/hexcolor.dart';

class NameTitle extends StatelessWidget {
  const NameTitle({Key? key}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    return Text(
      "Genesis Packaging",
      style: TextStyle(
        fontSize: 18.sp,
        fontFamily: GoogleFonts.playfairDisplay().fontFamily,
        fontWeight: FontWeight.bold,
        color: HexColor('#922A31'),
      ),
    );
  }
}
