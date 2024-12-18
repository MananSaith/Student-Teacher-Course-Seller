import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:s_potal/constant/string_constant.dart';

import 'cource_enrolled.dart';

class CourceEnrolledService {
  static String baseUrl = "${MyText.basicUrlApi}/api/CourceEnrolled";

  // Get all records by UID
  static Future<List<CourceEnrolled>> getAllByUid(String uid) async {
    final response = await http.get(Uri.parse("$baseUrl/getall/$uid"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
     
      return data.map((json) => CourceEnrolled.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load records");
    }
  }

  // Get one record by UID
  static Future<CourceEnrolled> getOneByUid(String uid) async {
    final response = await http.get(Uri.parse("$baseUrl/getone/$uid"));
    if (response.statusCode == 200) {
      return CourceEnrolled.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load record");
    }
  }

  // Create a new record
  static Future<CourceEnrolled> createRecord(CourceEnrolled record) async {
    final response = await http.post(
      Uri.parse("$baseUrl/create"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(record.toJson()),
    );
    if (response.statusCode == 201) {
      return CourceEnrolled.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to create record");
    }
  }

  // Update a record by ID
  static Future<CourceEnrolled> updateRecord(
      String id, Map<String, dynamic> updates) async {
    final response = await http.put(
      Uri.parse("$baseUrl/update/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(updates),
    );
    if (response.statusCode == 200) {
      return CourceEnrolled.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to update record");
    }
  }

  // Delete a record by ID
  static Future<void> deleteRecord(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/delete/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete record");
    }
  }
}
