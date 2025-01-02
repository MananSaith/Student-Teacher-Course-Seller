import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;
import '../../constant/string_constant.dart';
import 'student_progress_model.dart';

class ApiService {
  static String baseUrl = '${MyText.basicUrlApi}/api/student-progress';

  final http.Client _client = http.Client();

  // Fetch progress by UID
  Future<List<StudentProgress>> fetchProgressByUid(String uid) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/uid/$uid'));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['data'];
        return data.map((json) => StudentProgress.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to fetch progress11111111111111: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch progress222222222: $e');
    }
  }

  // Create a new progress record
  Future<StudentProgress> createProgress(StudentProgress progress) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(progress.toJson()), // Convert the object to JSON
      );

      if (response.statusCode == 201) {
        return StudentProgress.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw Exception('Failed to create progress: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to create progress: $e');
    }
  }
}
