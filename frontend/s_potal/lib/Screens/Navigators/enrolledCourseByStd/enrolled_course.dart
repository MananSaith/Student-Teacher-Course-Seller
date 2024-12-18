import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/colorclass.dart';
import '../../../constant/string_constant.dart';
import '../../../controllers/CourseCrud/course_curd_controller.dart';
import '../../../controllers/Enrolled course/cource_enrolled_controller.dart';
import 'coursedetailscreen.dart';

class EnrolledCourse extends StatefulWidget {
  const EnrolledCourse({super.key});

  @override
  State<EnrolledCourse> createState() => _EnrolledCourseState();
}

class _EnrolledCourseState extends State<EnrolledCourse> {
  final CourceEnrolledController controllerEnrolled =
      Get.put(CourceEnrolledController());
  final CourseController courseController = Get.put(CourseController());
  final uid = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = true;
  @override
  void initState() {
    startFunction();
    super.initState();
  }

  void startFunction() async {
    await controllerEnrolled.fetchAllByUid(uid);
    for (var cource in controllerEnrolled.courceEnrolledList) {
      // print('UID: ${cource.uid}, Object ID: ${cource.objectId}');
      await courseController.getCourseById(id: cource.objectId);
    }

    courseController.loading();
  }

  @override
  void dispose() {
    courseController.enrollCourses.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        title: Text('Courses', style: TextStyle(color: MyColors.thirdPallet)),
        backgroundColor: MyColors.primaryPallet,
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: courseController.enrollCourses.length,
          itemBuilder: (context, index) {
            final course = courseController.enrollCourses[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => const CourseDetailsScreen(), arguments: course);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: MyColors.transparentBgPallet,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '${MyText.basicUrlApi}/${course.image}',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: TextStyle(
                              color: MyColors.secondaryPallet,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            course.description,
                            style: TextStyle(
                              color: MyColors.primaryPallet,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
