import 'package:get/get.dart';
import 'std_json.dart';
import 'student_service.dart';

class StudentController extends GetxController {
  final StudentService _studentService = StudentService();
  
  var students = <Student>[].obs;
  var currentStudent = Rxn<Student>(); // Holds a single student
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    isLoading(true);
    try {
      students.value = await _studentService.getAllStudents();
    } finally {
      isLoading(false);
    }
  }

  Future<void> addStudent(Student student) async {
    isLoading(true);
    try {
      final newStudent = await _studentService.createStudent(student);
      students.add(newStudent);
    } finally {
      isLoading(false);
    }
  }
Future<void> fetchStudentByUid(String uid) async {
    isLoading(true);
    try {
      currentStudent.value = await _studentService.getStudentByUid(uid);
    } catch (e) {
      Get.snackbar("Error", "Failed to load student: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
  Future<void> updateStudent(String uid, Student updatedStudent) async {
    isLoading(true);
    try {
      final student = await _studentService.updateStudent(uid, updatedStudent);
      final index = students.indexWhere((s) => s.uid == uid);
      if (index != -1) {
        students[index] = student;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteStudent(String uid) async {
    isLoading(true);
    try {
      await _studentService.deleteStudent(uid);
      students.removeWhere((s) => s.uid == uid);
    } finally {
      isLoading(false);
    }
  }
}
