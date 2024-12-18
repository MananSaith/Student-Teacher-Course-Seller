// item_controller.dart

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constant/string_constant.dart';
import 'teacher_json.dart';

class TeacherCrud extends GetxController {
  String baseUrl = '${MyText.basicUrlApi}/api/teacher';

  var teachers = <TeacherJson>[].obs;
  var selectedTeacher = Rxn<TeacherJson>();
  late String currentUserUid;

  @override
  void onInit() {
    super.onInit();

    // Initialize currentUserUid here
    final currentUser = FirebaseAuth.instance.currentUser;
    currentUserUid = currentUser?.uid ?? '';

    fetchItems();
    getUserById(uid: currentUserUid);
  }

  Future<void> fetchItems() async {
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
    final url = Uri.parse('$baseUrl/$uid');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        selectedTeacher.value =
            TeacherJson.fromJson(data); // Update the observable
      } else if (response.statusCode == 404) {
        selectedTeacher.value = null;
        // Get.snackbar("Not Found", "User with UID $uid not found");
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
        fetchItems();
        Get.snackbar("succesfully", 'add user: ${response.statusCode}');
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
    await http.put(
      Uri.parse('$baseUrl/update/$uid'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );
  }

  Future<void> deleteItem(String id) async {
    await http.delete(Uri.parse('$baseUrl/delete/$id'));
  }
}
