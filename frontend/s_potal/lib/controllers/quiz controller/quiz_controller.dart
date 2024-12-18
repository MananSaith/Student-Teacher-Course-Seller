// lib/controllers/quiz_controller.dart
import 'package:get/get.dart';

import 'quiz_api_service.dart';

class QuizController extends GetxController {
  final ApiService apiService = ApiService();
  var quizzes = [].obs;
  var isLoading = false.obs;

  // // Create a new quiz
  // Future<void> createQuiz(Quiz quiz) async {
  //   final response = await apiService.createQuiz(quiz);
  //   if (response['success']) {
  //     Get.snackbar("quiz", "quiz upload");
  //   }
  // }

  // Fetch quizzes by courseId
  Future<void> fetchQuizzesByCourseId(String courseId) async {
    isLoading(true);
    quizzes.clear();
    try {
      final q = await apiService.getQuizzesByCourseId(courseId);
      quizzes.add(q);
      
    } catch (e) {
      Get.snackbar("Error", "Error is occour $e");
    } finally {
      isLoading(false);
    }
  }

  // // Fetch all quizzes
  // Future<void> fetchAllQuizzes() async {
  //   try {
  //     final List<Quiz> fetchedQuizzes = await apiService.getAllQuizzes();
  //     quizzes.assignAll(fetchedQuizzes);
  //   } catch (e) {
  //     print("Error fetching quizzes: $e");
  //   }
  // }

  // Fetch quizzes by teacher UID and courseId
  // Future<void> fetchQuizzesByTeacherAndCourse(
  //     String uid, String courseId) async {
  //   try {
  //     final List<Quiz> fetchedQuizzes =
  //         await apiService.getQuizzesByTeacherAndCourse(uid, courseId);
  //     quizzes.assignAll(fetchedQuizzes);
  //   } catch (e) {
  //     print("Error fetching quizzes for teacher and course: $e");
  //   }
  // }
}
