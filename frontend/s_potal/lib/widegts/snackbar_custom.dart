import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar({
  required String title,
  required String message,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
  Color backgroundColor = Colors.blue,
  Color textColor = Colors.white,
  Duration duration = const Duration(seconds: 3),
  IconData? icon,
}) {
  Get.snackbar(
    title, 
    message,
    snackPosition: snackPosition,
    backgroundColor: backgroundColor,
    colorText: textColor,
    duration: duration,
    margin: const EdgeInsets.all(10),
    icon: icon != null ? Icon(icon, color: textColor) : null,
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 8,
    isDismissible: true,
    forwardAnimationCurve: Curves.easeInOut,
  );
}
