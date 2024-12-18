import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/colorclass.dart';
import '../../../constant/font_weight.dart';
import '../../../constant/string_constant.dart';
import '../../../controllers/CourseCrud/course_curd_controller.dart';
import '../../../widegts/textwidget.dart';
import 'course_detail_page.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final CourseController courseController = Get.put(CourseController());
  final TextEditingController filter = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllCourses();
  }

  void getAllCourses() async {
    await courseController.fetchAllCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            icon: Icon(Icons.flash_on_outlined, color: MyColors.camel),
            onPressed: () => Get.to(() => ProgressScreen(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                )),
          ),
          IconButton(
            icon: Icon(Icons.person, color: MyColors.camel),
            onPressed: () => Get.to(() => const ProfileScreen()),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: filter,
              decoration: InputDecoration(
                hintText: "Search by title...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Triggers rebuild
              },
            ),
          ),
          // GridView
          Obx(() {
            // Filtered list based on search query
            final filteredCourses = courseController.courses
                .where((course) =>
                    filter.text.isEmpty ||
                    course['title']
                        .toString()
                        .toLowerCase()
                        .contains(filter.text.toLowerCase()))
                .toList();

            if (filteredCourses.isEmpty) {
              return const Expanded(
                child: Center(
                  child: Text(
                    'No courses available',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = filteredCourses[index];
                  return card(context: context, course: course);
                },
              ),
            );
          })
        ],
      ),
    );
  }

  Widget card({required Map course, required BuildContext context}) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      tileColor: Colors.white,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          '${MyText.basicUrlApi}/${course['image']}',
          fit: BoxFit.cover,
          width: 80,
          height: 80,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, size: 80);
          },
        ),
      ),
      title: Text(
        course['title'],
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course['description'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14.0),
          ),
          const SizedBox(height: 4.0),
          Text(
            "Price: \$${course['price']}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
      onTap: () {
        Get.to(
          () => CourseDetailPage(),
          arguments: course,
        );
      },
    );
  }
}