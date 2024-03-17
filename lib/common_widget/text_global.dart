import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textGlobalWidget(
    {required String text, double? fontSize, FontWeight? fontWeight}) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: GoogleFonts.openSans().fontFamily,
        color: const Color(0xff030303),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: fontSize ?? 16.0),
    textAlign: TextAlign.center,
  );
}
