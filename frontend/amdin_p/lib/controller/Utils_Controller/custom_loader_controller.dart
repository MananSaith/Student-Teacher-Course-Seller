import 'package:get/get.dart';

class CunstomLoaderController extends GetxController {
  var isLoading = false.obs; // Observable for loading state

  void showLoader() {
    isLoading.value = true;
  }

  void hideLoader() {
    isLoading.value = false;
  }
}
