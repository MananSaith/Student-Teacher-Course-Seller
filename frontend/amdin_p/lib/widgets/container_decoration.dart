import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
containerDecorationWidget({required Color color,Color? bgColor} ){
return BoxDecoration(
    border: Border.all(
      color: color,
      width: 0.5,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(20),
    color: bgColor
);
}