// item_controller.dart

import 'dart:async';

import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'teacher_json.dart';

class TeacherCrud extends GetxController {
  String baseUrl =
      'http://192.168.1.7:3000/api/teacher'; // Replace with your actual server URL

  var teachers = <TeacherJson>[].obs;
  var searchTeachers = "".obs;
  var selectedTeacher = Rxn<TeacherJson>(); // Observable for a single teacher
  late Timer _timer; // Timer for periodic updates

  @override
  void onInit() {
    super.onInit();
    fetchTeachers(); // Initial fetch
    _startPolling(); // Start the polling timer
  }

  @override
  void onClose() {
    _timer.cancel(); // Stop the timer when the controller is disposed
    super.onClose();
  }

  void _startPolling() {
    // Polls `fetchItems` every 10 seconds
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchTeachers(); // Fetches items periodically
    });
  }

  //get
  Future<List<TeacherJson>> fetchTeachersAsync() async {
    await fetchTeachers(); // Call the existing fetch method
    return teachers; // Return the updated list of teachers
  }

  Future<void> fetchTeachers() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/read"));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        teachers.value =
            data.map((item) => TeacherJson.fromJson(item)).toList();
      }
    } catch (e) {
      Get.snackbar("Error", "Unexpected error occour get data");
    }
  }

  Future<void> getUserById({required String uid}) async {
    final url = Uri.parse('$baseUrl/single/$uid');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        selectedTeacher.value =
            TeacherJson.fromJson(data); // Update the observable
      } else if (response.statusCode == 404) {
        selectedTeacher.value = null;
        Get.snackbar("Not Found", "User with UID $uid not found");
      } else {
        throw Exception("Failed to fetch user");
      }
    } catch (error) {
      Get.snackbar(
          "Error", "Unexpected error occurred while fetching user data");
    }
  }

  Future<void> createTeacher(TeacherJson data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data.toJson()),
      );

      if (response.statusCode == 201) {
        fetchTeachers();
        // Handle successful creation (e.g., show a snackbar)
      } else {
        Get.snackbar("Error", 'Error creating user: ${response.statusCode}');
        // Handle errors (e.g., show a dialog)
      }
    } catch (e) {
      Get.snackbar("Error", "Unexpected error occour during post");
    }
  }

  Future<void> updateUser(String uid, TeacherJson item) async {
    try {
      await http.put(
        Uri.parse('$baseUrl/update/$uid'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(item.toJson()),
      );
      Get.snackbar("update", 'succesfully update user');
    } catch (e) {
      Get.snackbar("Error", 'Error update user: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    await http.delete(Uri.parse('$baseUrl/delete/$id'));
  }
}
