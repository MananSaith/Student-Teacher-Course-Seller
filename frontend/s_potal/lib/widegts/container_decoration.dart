import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
containerDecorationWidget({required Color color,Color? bgColor, double? radius} ){
return BoxDecoration(
    border: Border.all(
      color: color,
      width: 0.5,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(radius??20),
    color: bgColor
);
}
// boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10,
//                 offset: Offset(0, 5),
//               ),
//             ],