// screens/home_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_potal/constant/colorclass.dart';
import 'package:t_potal/constant/font_weight.dart';
import 'package:t_potal/widegts/textwidget.dart';

import '../../../constant/string_constant.dart';
import '../../../controllers/techerDataFromNode/courseUpload/course_curd_controller.dart';
import '../../../controllers/techerDataFromNode/courseUpload/course_data_controller.dart';
import '../../../widegts/container_decoration.dart';
import '../initial/navigator_screen.dart';
import 'course_detail_page.dart';
import 'create_course_screen.dart';
import 'earn_screen.dart';
import 'profile_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final CourseDataController controller = Get.put(CourseDataController());
  final CourseController courseController = Get.put(CourseController());
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    controller.reset();
    getTeacherCourses();
  }

  void getTeacherCourses() async {
    await courseController.fetchCoursesByUid(uid);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        centerTitle: false,
        title: TextWidget(
          text: MyText.appName,
          fSize: 25,
          fWeight: MyFontWeight.bold,
          textColor: MyColors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: MyColors.camel),
            onPressed: () => Get.to(() => const ProfileScreen()),
          ),
          IconButton(
            icon: Icon(Icons.attach_money, color: MyColors.camel),
            onPressed: () => Get.to(() => const EarnScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Get.to(() => CreateCourseScreen()),
                child: Container(
                  height: height * 0.1,
                  width: width,
                  padding: const EdgeInsets.all(10),
                  decoration: containerDecorationWidget(
                    color: MyColors.blue,
                    bgColor: MyColors.secondaryPallet,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: "create course",
                        fSize: 25,
                        fWeight: MyFontWeight.medium,
                        textColor: MyColors.white,
                      ),
                      Icon(
                        Icons.add,
                        color: MyColors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacing between sections
              Obx(() {
                if (courseController.currentTecherCourses.isEmpty) {
                  return const Center(
                    child: Text(
                      'No courses available',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 3 / 4, // Adjust as needed
                  ),
                  itemCount: courseController.currentTecherCourses.length,
                  itemBuilder: (context, index) {
                    final course = courseController.currentTecherCourses[index];
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => CourseDetailPage(),
                          arguments: course,
                        );
                      },
                      onLongPress: () {
                        Get.dialog(
                          Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 30),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                          height: 50), // For icon space
                                      const Text(
                                        "Are you sure?",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "This action cannot be undone. Do you want to delete this item?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Cancel button
                                          ElevatedButton(
                                            onPressed: () => Get.back(),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey[300],
                                              foregroundColor: Colors.black,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text("Cancel"),
                                          ),
                                          // Delete button
                                          ElevatedButton(
                                            onPressed: () async {
                                              try {
                                                await courseController
                                                    .deleteCourse(
                                                        course["_id"]);
                                                Get.snackbar("Delete",
                                                    "Sucessfully delete");
                                                Get.offAll(() =>
                                                    const NavigatorScreen());
                                              } catch (e) {
                                                Get.snackbar(
                                                    "Alert", "Error $e");
                                              }
                                              Get.back();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.redAccent,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: -40,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        Colors.redAccent.withOpacity(0.1),
                                    child: const Icon(
                                      Icons.delete_forever,
                                      size: 40,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                '${MyText.basicUrlApi}/${course['image']}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(child: Icon(Icons.error));
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course['title'] ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    course['description'] ?? '',
                                    style: const TextStyle(color: Colors.grey),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Price: \$${course['price']}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.green),
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
            ],
          ),
        ),
      ),
    );
  }
}
