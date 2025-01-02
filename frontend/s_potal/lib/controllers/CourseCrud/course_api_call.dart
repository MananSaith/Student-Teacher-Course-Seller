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

  // Fetch courses by category
  Future<List> fetchCoursesByCategory(String category) async {
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    final response = await http.get(Uri.parse("$baseUrl/category/$category"));
    print(
        "333333333333333333333333333333333333333 ${response.statusCode}   $baseUrl/category/$category");
    if (response.statusCode == 200) {
      print("tttttttttttttttttttttttttttttttttttttttttttttttttt");
      final List<dynamic> data = jsonDecode(response.body);
      print("hhhhhhhhhhhhhhhhhhhhhhhhhrrrrrrrrrrrrrrrrrrrrrr");
      print(data);
      return data;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to load courses: ${response.body}');
    }
  }

  Future<Course> getCourseById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/getCourseById/$id'));
    final responseData = json.decode(response.body);

    return Course.fromJson(responseData);
  }
}
