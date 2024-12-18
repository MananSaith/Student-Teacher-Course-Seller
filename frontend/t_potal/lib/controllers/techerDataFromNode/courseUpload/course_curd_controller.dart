// controllers/course_controller.dart
import 'package:get/get.dart';

import '../../Utils_Controller/custom_loader_controller.dart';
import 'course_api_call.dart';
import 'course_data_controller.dart';
import 'course_model_json.dart';
import 'quiz_controller.dart';
import 'quiz_modle.dart';

class CourseController extends GetxController {
  final CourseDataController dataController = Get.put(CourseDataController());
  final CourseService _courseService = CourseService();
  final QuizController quizController = Get.put(QuizController());
  final CunstomLoaderController loadingController =
      Get.put(CunstomLoaderController());
  final CourseDataController courseDataController =
      Get.put(CourseDataController());

  // Observable list of courses
  var courses = [].obs;
  var currentTecherCourses = [].obs;
  var id = "".obs;

  // Fetch all courses
  Future<void> fetchAllCourses() async {
    final fetchedCourses = await _courseService.getAllCourses();
    courses.assignAll(fetchedCourses);
  }

  // Fetch courses by a specific teacher's UID
  Future<void> fetchCoursesByUid(String uid) async {
    final fetchedCourses = await _courseService.getCoursesByUid(uid);
    currentTecherCourses.assignAll(fetchedCourses);
  }

  // Create a new course
  Future<void> createCourse(Course course) async {
    loadingController.showLoader();

    await _courseService.createCourse(course);
    //get courseId of current uploaded course by given title
    //it will get the all courses first and match the title
    //where title will matehed it will get the _id of the course
    //and will send with quiz module
    id.value = await idFetchForCurrentCourse();
    final mcq = dataController.mcqList.map((e) => e as Question).toList();
    final quiz = Quiz(
        title: dataController.title.value, questions: mcq, courseId: id.value);
    await quizController.createQuiz(quiz);

    loadingController.hideLoader();
  }

  // Update an existing course by ID
  Future<void> updateCourse(String id, Course course) async {
    final updatedCourse = await _courseService.updateCourseById(id, course);
    if (updatedCourse != null) {
      // final index = courses.indexWhere((c) => c.id == id);
      // if (index != -1) {
      //   courses[index] = updatedCourse;
      //}
    }
  }

  // Delete a course by ID
  // Future<void> deleteCourse(String id) async {
  //   final isDeleted = await _courseService.deleteCourseById(id);
  //   if (isDeleted) {
  //   //  courses.removeWhere((course) => course.id == id);
  //   }
  // }

  Future idFetchForCurrentCourse() async {
    await fetchAllCourses();

    // ignore: invalid_use_of_protected_member
    final list = courses.value;
    print(list);

    if (list.isEmpty) {
      // Or handle the case where the list is empty or null
    }

    for (final course in list) {
      if (course["title"] == courseDataController.title.value) {
        return course["_id"]!;
      }
    }
  }
}
