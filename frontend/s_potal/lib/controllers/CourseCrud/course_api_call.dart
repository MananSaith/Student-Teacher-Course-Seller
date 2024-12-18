// services/course_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant/string_constant.dart';
import 'course_model.dart';

class CourseService {
  final String baseUrl = '${MyText.basicUrlApi}/api/courses';

  Future<List> getAllCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/getAllCourses'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      
      return data;
    }
    return [];
  }

  Future<Course> getCourseById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/getCourseById/$id'));
    final responseData = json.decode(response.body);
    
    return Course.fromJson(responseData);
  }
}
