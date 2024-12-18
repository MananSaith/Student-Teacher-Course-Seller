import 'package:amdin_p/constant/font_weight.dart';
import 'package:amdin_p/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:get/get.dart';

import '../../constant/colorclass.dart';
import '../../controller/techerDataFromNode/teacher_crud.dart';
import '../../controller/techerDataFromNode/teacher_json.dart';
import '../../widgets/container_decoration.dart';
import 'homescreen.dart';

Widget containedTabBarView({required BuildContext context}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  final TeacherCrud teacherCrudController = Get.put(TeacherCrud());

  return Container(
    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
    width: width,
    height: height,
    child: FutureBuilder<List<TeacherJson>>(
      future: teacherCrudController
          .fetchTeachersAsync(), // Call your API function here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data available"));
        } else {
          // Assuming snapshot.data contains a list of teachers
          final teachers = snapshot.data;

          return ContainedTabBarView(
            tabs: [
              TextWidget(
                text: "Requests",
                fSize: 15,
                fWeight: MyFontWeight.bold,
              ),
              TextWidget(
                text: "Accepted",
                fSize: 15,
                fWeight: MyFontWeight.bold,
              )
            ],
            views: [
              ListView.builder(
                itemCount: teachers!.length,
                itemBuilder: (context, index) {
                  final teacher = teachers[index];
                  if (!teacher.verify) {
                    return teacherListTile(teacher: teacher);
                  }
                  return const SizedBox();
                },
              ),
              ListView.builder(
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  final teacher = teachers[index];
                  if (teacher.verify) {
                    return teacherListTile(teacher: teacher);
                  }
                  return const SizedBox();
                },
              ),
            ],
            onChange: (index) {
              // Handle tab changes if needed
            },
          );
        }
      },
    ),
  );
}

teacherListTile({required TeacherJson teacher}) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: containerDecorationWidget(
        color: MyColors.secondaryPallet, bgColor: MyColors.secondaryPallet),
    child: ListTile(
      title: TextWidget(
        text: teacher.name,
        fSize: 15,
        fWeight: FontWeight.bold,
        textColor: Colors.white,
      ),
      subtitle: TextWidget(
        text: teacher.email,
        fSize: 12,
        fWeight: MyFontWeight.small,
        textColor: Colors.white,
      ),
      trailing: Icon(
        Icons.open_in_full,
        color: MyColors.camel,
      ),
      onTap: () {
        Get.defaultDialog(
          title: teacher.name,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email: ${teacher.email}"),
              Text("UID: ${teacher.uid}"),
              Text("MCID: ${teacher.mcid}"),
              Text("Verified: ${teacher.verify ? 'Yes' : 'No'}"),
            ],
          ),
          onCancel: () {
            Get.back();
          },
          onConfirm: () {
            final TeacherCrud teacherCrudController = Get.put(TeacherCrud());
            final data = TeacherJson(
                email: teacher.email,
                uid: teacher.uid,
                verify: teacher.verify ? false : true,
                name: teacher.name,
                mcid: teacher.mcid);
            teacherCrudController.updateUser(teacher.uid, data);
            Get.offAll(() => const Homescreen());
          },
          textCancel: "Cancel",
          textConfirm: teacher.verify ? "Block" : "Confirm",
        );
      },
    ),
  );
}
