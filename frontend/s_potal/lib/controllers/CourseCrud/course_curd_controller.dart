// controllers/course_controller.dart
import 'package:get/get.dart';

import 'course_api_call.dart';
import 'course_model.dart';

class CourseController extends GetxController {
  final CourseService _courseService = CourseService();
  var isLoading = true.obs;
  // Observable list of courses
  var courses = [].obs;
  var category = "All Courses".obs;
  var enrollCourses = <Course>[].obs;
  // Fetch all courses
  Future<void> fetchAllCourses() async {
    final fetchedCourses = await _courseService.getAllCourses();
    courses.assignAll(fetchedCourses);
  }

  // Fetch courses by category
  Future<void> fetchCoursesByCategory(String category) async {
    try {
      final fetchedCourses =
          await _courseService.fetchCoursesByCategory(category);
    courses.assignAll(fetchedCourses);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> getCourseById({required String id}) async {
    final fetchedCourses = await _courseService.getCourseById(id);
    enrollCourses.add(fetchedCourses);
  }

  void loading() {
    isLoading.value = false;
  }
}
