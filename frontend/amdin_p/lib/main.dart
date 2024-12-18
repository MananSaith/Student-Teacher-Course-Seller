import 'package:amdin_p/constant/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constant/colorclass.dart';
import 'screens/LoginScreens/get_start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyText.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryPallet),
        useMaterial3: true,
      ),
      home:const GetStartScreen(),
    );
  }
}
