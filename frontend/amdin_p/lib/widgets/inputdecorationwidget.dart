import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/colorclass.dart';
import 'text_field_border.dart';

 inputDecorationWidget({required String text,Color? bdcolor,Icon? prefixIcon}) {
  return InputDecoration(
      fillColor: bdcolor,
      filled: true,
      hintText:text,
      prefixIcon: prefixIcon, 
      border:         borderWidget ,
      enabledBorder:  borderWidget ,
      focusedBorder:  borderWidget ,
      hintStyle: GoogleFonts.poppins(
          fontSize:15,
          color: MyColors.hintInput
      )
  );
}
