import 'package:get/get.dart';

class LoaderController extends GetxController{
  RxBool loader = false.obs;
  loaderFunction(){
        loader.value=!loader.value;
  }

}