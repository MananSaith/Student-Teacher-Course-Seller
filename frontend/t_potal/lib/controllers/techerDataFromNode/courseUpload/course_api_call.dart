// services/course_service.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:t_potal/constant/colorclass.dart';
import 'package:t_potal/constant/string_constant.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'course_data_controller.dart';
import 'course_model_json.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class CourseService {
  final CourseDataController controller = Get.put(CourseDataController());
  final String baseUrl = '${MyText.basicUrlApi}/api/courses';

  Future<Course?> createCourse(Course course) async {
    try {
      if (course.byteImage == null || course.imagePath.isEmpty) {
        throw Exception("Image data or image path is missing");
      }
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/createCourse"),
      );

      // Add text fields
      request.fields['title'] = course.title;
      request.fields['category'] = course.category;
      request.fields['description'] = course.description;
      request.fields['price'] = course.price.toString();
      request.fields['uid'] = course.uid;
      request.fields['mcid'] = course.mcid;
      String? extension = path.extension(course.imagePath).toLowerCase();
      String mimeType = _getMimeType(extension);
      // Add file as bytes
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        course.byteImage!,
        filename: course.imagePath.split('/').last,
        contentType: MediaType('image', mimeType),
      ));

//Attach other files
      for (var fileData in course.files) {
        Uint8List byte = await File(fileData.path!).readAsBytes();

        String? extension = path.extension(fileData.path!).toLowerCase();
        String mimeType = _getMimeType(extension);

        request.files.add(
          http.MultipartFile.fromBytes(
            'files',
            byte,
            filename: fileData.path!.split('/').last, // Extract filename
            contentType: MediaType('files', mimeType),
          ),
        );
      }

      //Attach other files
      for (var videoData in course.videoLectures) {
        Uint8List byte = await File(videoData.path!).readAsBytes();

        String? extension = path.extension(videoData.path!).toLowerCase();
        String mimeType = _getMimeType(extension);

        request.files.add(
          http.MultipartFile.fromBytes(
            'videoLectures',
            byte,
            filename: videoData.path!.split('/').last, // Extract filename
            contentType: MediaType('videoLectures', mimeType),
          ),
        );
      }

      request.headers.remove('Content-Type');

      var response = await request.send();

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Course successfully uploaded',
          snackPosition: SnackPosition.TOP,
          backgroundColor: MyColors.green,
          colorText: MyColors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to upload course. Status: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: MyColors.red,
          colorText: MyColors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unexpected error uploading course: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: MyColors.red,
        colorText: MyColors.white,
      );
    }
    return null;
  }

  Future<List> getAllCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/getAllCourses'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data;
    }
    return [];
  }

// Fetch courses by category
   Future<List<Course>> fetchCoursesByCategory(String category) async {
    final response = await http.get(Uri.parse("$baseUrl/category/$category"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['data'];
      return data.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load courses: ${response.body}');
    }
  }

  Future<Course?> getCourseById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/getCourseById/$id'));
    if (response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<List> getCoursesByUid(String uid) async {
    final response = await http.get(Uri.parse('$baseUrl/teacher/$uid'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    }
    return [];
  }

  Future<Course?> updateCourseById(String id, Course course) async {
    final response = await http.put(
      Uri.parse('$baseUrl/updateCourseById/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(course.toJson()),
    );
    if (response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<bool> deleteCourseById(String id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/deleteCourseById/$id'));
    return response.statusCode == 200;
  }

  String _getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case '.jpeg':
      case '.jpg':
        return 'jpeg';
      case '.png':
        return 'png';
      case '.gif':
        return 'gif';
      case '.bmp':
        return 'bmp';
      case '.mp4':
        return 'mp4';
      case '.avi':
        return 'x-msvideo';
      case '.mkv':
        return 'x-matroska';
      case '.pdf':
        return 'pdf';
      case '.doc':
        return 'msword';
      case '.docx':
        return 'vnd.openxmlformats-officedocument.wordprocessingml.document';
      case '.pptx':
        return 'vnd.openxmlformats-officedocument.presentationml.presentation';
      default:
        return 'application/octet-stream'; // Default MIME type for unknown extensions
    }
  }
}
