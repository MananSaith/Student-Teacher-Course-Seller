import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/colorclass.dart';
import '../../../constant/font_weight.dart';
import '../../../constant/string_constant.dart';
import '../../../controllers/techerDataFromNode/teacherInfo/teacher_crud.dart';
import '../../../widegts/textwidget.dart';

class EarnScreen extends StatefulWidget {
  const EarnScreen({super.key});

  @override
  State<EarnScreen> createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  final TeacherCrud teacherCrudController = Get.put(TeacherCrud());

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    teacherCrudController.getUserById(uid: currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    double earningsInDouble =
        (teacherCrudController.selectedTeacher.value?.earn ?? 0).toDouble();

    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        centerTitle: false,
        title: TextWidget(
          text: MyText.earning,
          fSize: 25,
          fWeight: MyFontWeight.bold,
          textColor: MyColors.white,
        ),
      ),
      body: Center(
        child: Container(
          width: width * 0.8,
          height: height * 0.25,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.attach_money, // Or Icons.monetization_on
                size: 40,
                color: MyColors.camel,
              ),
              SizedBox(height: height * 0.025),
              TextWidget(
                text: '\$${earningsInDouble.toStringAsFixed(2)}',
                fSize: 25,
                textColor: MyColors.white,
                fWeight: MyFontWeight.bold,
              ),
              SizedBox(height: height * 0.015),
              TextWidget(
                text: MyText.totalEarning,
                fSize: 15,
                textColor: MyColors.white,
                fWeight: MyFontWeight.regular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
