import 'package:get/get.dart';
import 'server_api_reward.dart';
import 'student_progress_model.dart';

class ProgressController extends GetxController {
  final ApiService _apiService = ApiService();
  var progressList = <StudentProgress>[].obs;
  var isLoading = false.obs;

  // Fetch progress by UID
  Future<void> fetchProgressByUid(String uid) async {
    isLoading.value = true;
    try {
      final List<StudentProgress> progress =
          await _apiService.fetchProgressByUid(uid);
      progressList.assignAll(progress);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Create a new progress record
  Future<void> createProgress(StudentProgress progress) async {
    isLoading.value = true;
    try {
      final StudentProgress newProgress =
          await _apiService.createProgress(progress);
      progressList.add(newProgress); // Add the new progress to the list
      Get.snackbar('Success', 'Progress created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
