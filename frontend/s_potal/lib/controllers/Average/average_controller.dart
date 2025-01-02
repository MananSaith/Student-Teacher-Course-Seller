import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;
import '../../constant/string_constant.dart';
import 'average_model.dart';

class AverageController {
  final String baseUrl = '${MyText.basicUrlApi}/api/averages';

  // Add a new average
  Future<Average?> addAverage(String courseId, double value) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'courseId': courseId,
          'value': value,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Average.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get averages by course
  Future<Map<String, dynamic>?> getAverageByCourse(String courseId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/course/$courseId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return {
          'averages': (data['averages'] as List)
              .map((e) => Average.fromJson(e))
              .toList(),
          'overallAverage': data['overallAverage'],
        };
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
