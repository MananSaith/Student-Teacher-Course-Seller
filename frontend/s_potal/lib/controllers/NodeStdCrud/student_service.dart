import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant/string_constant.dart';
import 'std_json.dart';

class StudentService {
  final String baseUrl = '${MyText.basicUrlApi}/api/studentsInfo';

  // Create a new student
  Future<Student> createStudent(Student student) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode == 201) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create student');
    }
  }

  // Get all students
  Future<List<Student>> getAllStudents() async {
    print(
        "nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
    final response = await http.get(Uri.parse('$baseUrl/read'));
    print(
        "ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo ${response.statusCode}");
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((json) => Student.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  // Get a single student by UID
  Future<Student> getStudentByUid(String uid) async {
    final response = await http.get(Uri.parse('$baseUrl/single/$uid'));

    if (response.statusCode == 200) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load student');
    }
  }

  // Update a student
  Future<Student> updateStudent(String uid, Student student) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/$uid'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode == 200) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update student');
    }
  }

  // Delete a student
  Future<void> deleteStudent(String uid) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$uid'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete student');
    }
  }
}
