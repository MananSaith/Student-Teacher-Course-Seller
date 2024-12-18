import 'package:get/get.dart';

import 'cource_enrolled.dart';
import 'cource_enrolled_service.dart';

class CourceEnrolledController extends GetxController {
  var courceEnrolledList = <CourceEnrolled>[].obs;
  var selectedCourceEnrolled = Rxn<CourceEnrolled>();
  var isLoading = false.obs;

  // Fetch all records by UID
  Future<void> fetchAllByUid(String uid) async {
    isLoading(true);
    try {
      final records = await CourceEnrolledService.getAllByUid(uid);
      courceEnrolledList.assignAll(records);
    } catch (e) {
      Get.snackbar("Alert", "no course enrolled now");
    } finally {
      isLoading(false);
    }
  }

  // Fetch one record by UID
  Future<void> fetchOneByUid(String uid) async {
    isLoading(true);
    try {
      final record = await CourceEnrolledService.getOneByUid(uid);
      selectedCourceEnrolled.value = record;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Create a new record
  Future<void> createRecord(CourceEnrolled record) async {
    isLoading(true);
    try {
      final newRecord = await CourceEnrolledService.createRecord(record);
      courceEnrolledList.add(newRecord);
      Get.snackbar("Success", "Record created successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Update a record by ID
  Future<void> updateRecord(String id, Map<String, dynamic> updates) async {
    isLoading(true);
    try {
      final updatedRecord =
          await CourceEnrolledService.updateRecord(id, updates);
      final index = courceEnrolledList.indexWhere((record) => record.uid == id);
      if (index != -1) {
        courceEnrolledList[index] = updatedRecord;
      }
      Get.snackbar("Success", "Record updated successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Delete a record by ID
  Future<void> deleteRecord(String id) async {
    isLoading(true);
    try {
      await CourceEnrolledService.deleteRecord(id);
      courceEnrolledList.removeWhere((record) => record.uid == id);
      Get.snackbar("Success", "Record deleted successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
