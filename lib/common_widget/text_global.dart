import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textGlobalWidget(
    {required String text,
    double? fontSize,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    Color? textColor}) {
  return Text(
    text,
    style: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontFamily: GoogleFonts.openSans().fontFamily,
        color: textColor ?? const Color(0xff030303),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: fontSize ?? 16.0),
    maxLines: 3,
    textAlign: textAlign ?? TextAlign.center,
  );
}
