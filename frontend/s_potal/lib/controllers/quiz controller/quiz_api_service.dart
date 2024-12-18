// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant/string_constant.dart';
import 'quiz_modle.dart';

class ApiService {
  final String baseUrl =
      '${MyText.basicUrlApi}/api/quizzes'; // Replace with your actual API URL

  // Create a new quiz
  Future<Map<String, dynamic>> createQuiz(Quiz quiz) async {
    final response = await http.post(
      Uri.parse('$baseUrl/quizzes'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(quiz.toJson()),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create quiz');
    }
  }

  // Get all quizzes
  Future<List<Quiz>> getAllQuizzes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/getall'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['quizzes'];
      return data.map((quizJson) => Quiz.fromJson(quizJson)).toList();
    } else {
      throw Exception('Failed to load quizzes');
    }
  }

  // get by courseId
  // Fetch quizzes by courseId
  Future<List> getQuizzesByCourseId(String courseId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/course/$courseId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['quizzes'];
       
        return data;
      } else {
        throw Exception('Failed to load quizzes');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get quizzes by teacher UID and courseId
  Future<List<Quiz>> getQuizzesByTeacherAndCourse(
      String uid, String courseId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/teacher/$uid/course/$courseId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((quizJson) => Quiz.fromJson(quizJson)).toList();
    } else {
      throw Exception('Failed to load quizzes');
    }
  }
}
