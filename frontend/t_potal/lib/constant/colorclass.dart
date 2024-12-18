import 'package:flutter/material.dart';

class MyColors{
   static Color appThemColor = const Color.fromARGB(95, 14, 55, 109);
   static Color hintInput = const Color(0xFFA5A5A5); 
   static Color black = const Color(0xFF000000);
   static Color verify = const Color(0xFF4A4A4A);
   static Color divider = const Color(0xFFB0B0B0);
   static Color search = const Color(0xFFFBFBFB);
   static Color white = const Color (0xFFFFFFFF);
   static Color offWhite = const Color (0xFFFFFFe4);
   static Color cream = const Color (0xFFFFFdd0);
   static Color blackTransparent = const Color (0x4C000000);
   static Color camelTransparent =const Color.fromARGB(105, 255, 156, 7);
   static Color lowWhite = const Color (0x5FFFFFFF);
   static Color blue = const Color.fromARGB(255, 0, 60, 255);
   static Color camel =const Color.fromARGB(255, 255, 156, 7);
   static Color red =const Color.fromARGB(255, 255, 0, 0);
   static Color green =const Color.fromARGB(255, 0, 156, 0);
  //  // color pallets
  //  static Color primaryPallet =const Color.fromARGB(255,240, 168, 208);
  //  static Color secondaryPallet =const Color.fromARGB(255,247, 181, 202);
  //  static Color thirdPallet =const Color.fromARGB(255,255, 198, 198);
  //  static Color bgPallet =const Color.fromARGB(255,255, 235, 212);
  //  static Color scaffoldBack =const Color.fromARGB(255,247, 247, 248);
  
  //prepilly
  // color pallets 
   static Color primaryPallet =const Color.fromARGB(255,2, 21, 38);
   static Color secondaryPallet =const Color.fromARGB(255,3, 52, 110);
   static Color thirdPallet =const Color.fromARGB(255,110, 172, 218);
   static Color bgPallet =const Color.fromARGB(255,226, 226, 182);
   static Color transparentBgPallet =const Color.fromARGB(70,226, 226, 182);
   static Color scaffoldBack =const Color.fromARGB(255,247, 247, 248);

  

   static LinearGradient loginPageBackGround = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [primaryPallet, black], // Define your gradient colors here
   );

}