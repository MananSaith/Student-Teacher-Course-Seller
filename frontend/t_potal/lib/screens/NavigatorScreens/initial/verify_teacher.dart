import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_potal/constant/colorclass.dart';
import 'package:t_potal/constant/font_weight.dart';
import 'package:t_potal/controllers/Utils_Controller/wrapper.dart';
import 'package:t_potal/widegts/textwidget.dart';

import '../../../controllers/techerDataFromNode/teacherInfo/teacher_crud.dart';
import 'navigator_screen.dart';

class VerifyTeacher extends StatefulWidget {
  const VerifyTeacher({super.key});

  @override
  State<VerifyTeacher> createState() => _VerifyTeacherState();
}

class _VerifyTeacherState extends State<VerifyTeacher> {
  final TeacherCrud teacherCrudController = Get.put(TeacherCrud());
  final currentUid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    teacherCrudController.getUserById(uid: currentUid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgPallet,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        title: TextWidget(
          text: "Verification Runing",
          fSize: 16,
          fWeight: MyFontWeight.bold,
          textColor: MyColors.white,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: MyColors.white),
            onPressed: () {
              Get.offAll(() => const Wrapper());
            },
          ),
        ],
      ),
      body:Obx(() {
                  if (teacherCrudController.selectedTeacher.value?.verify == true) {
                    // Navigate when `verify` is true
                    Future.microtask(() => Get.offAll(() => const NavigatorScreen()));
                    return const SizedBox(); // Return an empty widget as a placeholder
                  } else {
                    return const Center(child: Text("Verification Pending")); // Or any widget to display if not verified
                  }
                }),
      
    );
  }
}

