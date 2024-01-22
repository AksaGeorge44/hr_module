import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyFonts {

  static TextStyle lato({required double fontSize, required FontWeight fontWeight, required Color color}) {
    return GoogleFonts.lato(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle roboto({ required double fontSize, required FontWeight fontWeight, required Color color}) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

}
