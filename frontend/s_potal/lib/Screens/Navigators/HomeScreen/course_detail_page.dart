import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_potal/controllers/teacher_earn/teacher_json.dart';

import '../../../constant/colorclass.dart';
import '../../../constant/font_weight.dart';
import '../../../constant/string_constant.dart';
import '../../../controllers/Enrolled course/cource_enrolled.dart';
import '../../../controllers/Enrolled course/cource_enrolled_controller.dart';
import '../../../controllers/teacher_earn/teacher_crud.dart';
import '../../../widegts/textwidget.dart';
import '../navigator_screen.dart';

// ignore: must_be_immutable
class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course = Get.arguments;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final CourceEnrolledController enrolledController =
      Get.put(CourceEnrolledController());
  double? earn;
  final TeacherCrud teacherCrudController = Get.put(TeacherCrud());

  CourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        title: TextWidget(
          text: course['title'],
          fSize: 22,
          fWeight: MyFontWeight.bold,
          textColor: MyColors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                '${MyText.basicUrlApi}/${course['image']}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.error, size: 50, color: Colors.red),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),

            // Description
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              course['description'] ?? "No description available",
              style: const TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
            const SizedBox(height: 16.0),

            // Total Video Lectures
            const Text(
              "Video Lectures",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              "This course includes ${course['videoLectures'].length} video lectures to help you master the subject.",
              style: const TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
            const SizedBox(height: 16.0),

            // Documents
            const Text(
              "Documents",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              "You'll receive ${course['files'].length} supporting documents to enhance your learning experience.",
              style: const TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
            const SizedBox(height: 16.0),

            // Price
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: MyColors.primaryPallet.withOpacity(0.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${course['price']}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Price
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: MyColors.primaryPallet.withOpacity(0.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Teacher mcid",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${course['mcid']}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Buy Course Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final recorde =
                      CourceEnrolled(uid: uid, objectId: course['_id']);
                  await enrolledController.createRecord(recorde);
                  await teacherCrudController.getUserById(uid: course['uid']);
                  earn =
                      (teacherCrudController.selectedTeacher.value?.earn ?? 0)
                          .toDouble();
                  earn = (earn! + course['price']);
                  var updateTeacher = TeacherJson(
                    earn: (earn as double)
                        .toInt(), // Convert double to int using .toInt()
                    name: teacherCrudController.selectedTeacher.value?.name ??
                        "null",
                    email: teacherCrudController.selectedTeacher.value?.email ??
                        "",
                    uid: course['uid'],
                    mcid:
                        teacherCrudController.selectedTeacher.value?.mcid ?? "",
                    verify:
                        teacherCrudController.selectedTeacher.value?.verify ??
                            true,
                  );

                  await teacherCrudController
                      .updateUser(course['uid'], updateTeacher)
                      .then((e) {
                    Get.offAll(() => const NavigatorScreen());
                  });

                  // Add functionality for buying the course
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryPallet,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  "Buy Course",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
