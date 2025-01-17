import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/colorclass.dart';
import '../../../controllers/Average/average_controller.dart';
import '../../../controllers/CourseCrud/course_model.dart';
import '../ChatScreen/ChatScreenList.dart';
import 'document_lecture_list.dart';
import 'quiz_screen.dart';
import 'video_players.dart';

class CourseDetailsScreen extends StatelessWidget {
  CourseDetailsScreen({super.key});

  final RxInt selectedRating = 0.obs;

  @override
  Widget build(BuildContext context) {
    // Retrieve the course object from GetX arguments
    final course = Get.arguments;

    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        title:
            Text(course.title, style: TextStyle(color: MyColors.thirdPallet)),
        backgroundColor: MyColors.primaryPallet,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  // Videos Container
                  GestureDetector(
                    onTap: () {
                      Get.to(() =>
                          VideoPlayerScreen(videoUrls: course.videoLectures));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.secondaryPallet,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_circle_fill,
                              size: 48, color: MyColors.bgPallet),
                          const SizedBox(height: 8),
                          Text(
                            '${course.videoLectures.length}',
                            style: TextStyle(
                              color: MyColors.bgPallet,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Video Lectures',
                            style: TextStyle(
                              color: MyColors.bgPallet,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Files Container
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DocumentLectureList(
                            fileUrls: course.files,
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.thirdPallet,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder,
                              size: 48, color: MyColors.bgPallet),
                          const SizedBox(height: 8),
                          Text(
                            '${course.files.length}',
                            style: TextStyle(
                              color: MyColors.bgPallet,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Files',
                            style: TextStyle(
                              color: MyColors.bgPallet,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Quiz Container
                  GestureDetector(
                    onTap: () {
                      Get.to(() => QuizScreen(
                            course: course,
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.primaryPallet,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.quiz, size: 48, color: MyColors.bgPallet),
                          const SizedBox(height: 8),
                          Text(
                            'Quiz',
                            style: TextStyle(
                              color: MyColors.bgPallet,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Message and Call Container
                  GestureDetector(
                    onTap: () => Get.to(() => const ZIMKitDemoHomePage()),
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.transparentBgPallet,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.message,
                              size: 48, color: MyColors.primaryPallet),
                          const SizedBox(height: 8),
                          Text(
                            'Message & Call',
                            style: TextStyle(
                              color: MyColors.primaryPallet,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showRatingDialog(course: course),
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.thirdPallet,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, size: 48, color: MyColors.camel),
                          const SizedBox(height: 8),
                          Text(
                            'Rate Us',
                            style: TextStyle(
                              color: MyColors.bgPallet,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showRatingDialog({required Course course}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Rate Us",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          selectedRating.value = index + 1; // Update rating
                        },
                        icon: Icon(
                          Icons.star,
                          color: index < selectedRating.value
                              ? Colors.amber
                              : Colors.grey,
                          size: 30,
                        ),
                      );
                    }),
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await AverageController()
                      .addAverage(course.id!, selectedRating.value.toDouble());
                  Get.back(); // Close dialog
                  Get.snackbar(
                    "Thank You",
                    "You rated ${selectedRating.value} stars!",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
