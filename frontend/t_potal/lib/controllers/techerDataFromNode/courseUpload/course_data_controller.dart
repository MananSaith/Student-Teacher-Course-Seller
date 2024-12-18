// controllers/course_controller.dart
import 'dart:io';

import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'file_picker.dart';
import 'dart:typed_data';

import 'quiz_modle.dart';

class CourseDataController extends GetxController {
  var title = ''.obs;
  var price = 0.0.obs;
  var description = ''.obs;
  var imagePath = "".obs;
  var mcqLenght = 0.obs;

  RxList<PlatformFile> videoList = <PlatformFile>[].obs;
  RxList<PlatformFile> documentList = <PlatformFile>[].obs;
  Rxn<Uint8List> byte = Rxn<Uint8List>();

  // MCQ list
  var mcqList = [].obs;

  // Update functions
  void updateTitle(String newTitle) => title.value = newTitle;
  void updatePrice(double newPrice) => price.value = newPrice;
  void updateDescription(String newDescription) =>
      description.value = newDescription;

  void addMCQ({required Question mcq}) {
    mcqList.add(mcq);
    mcqLenght.value = mcqList.length;
  }

  // Use FilePickerHelper to pick an image
  Future<void> pickImage() async {
    PlatformFile? image = await FilePickerHelper.pickImage();
    if (image != null) {
      // Read the file bytes manually if image.bytes is null
      if (image.bytes == null && image.path != null) {
        byte.value = await File(image.path!).readAsBytes();
      } else {
        byte.value = image.bytes;
      }
      imagePath.value = image.path!;
    }
  }

  // Use FilePickerHelper to pick a video
  Future<void> pickVideo() async {
    PlatformFile? video = await FilePickerHelper.pickVideo();
    if (video != null) {
      videoList.add(video);
    }
  }

  // Use FilePickerHelper to pick a document
  Future<void> pickDocument() async {
    PlatformFile? document = await FilePickerHelper.pickDocument();
    if (document != null) {
      documentList.add(document);
    }
  }

  void reset() {
    title.value = '';
    price.value = 0.0;
    description.value = '';
    imagePath.value = "";
    videoList.clear();
    documentList.clear();
    mcqList.clear();
    mcqLenght.value = 0;
  }
}
