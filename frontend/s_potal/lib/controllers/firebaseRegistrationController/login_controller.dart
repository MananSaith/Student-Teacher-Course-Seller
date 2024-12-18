import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Screens/Navigators/navigator_screen.dart';
import '../Utils_Controller/loader_controller.dart';

class LoginController extends GetxController {
  final LoaderController loader = Get.put(LoaderController());
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future firebaseLoginWithEmailPassword() async {
    loader.loaderFunction();
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((c) {
        loader.loaderFunction();
        Get.snackbar("WelCome Bake", "you are successfully login");
        Get.offAll(const NavigatorScreen());
      });
    } catch (e) {
      Get.snackbar("Error", "$e");
      loader.loaderFunction();
    }
  }
}




// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../../screens/NavigatorScreens/navigator_screen.dart';
// import '../Utils_Controller/loader_controller.dart';

// class LoginController extends GetxController {
//   final LoaderController loader = Get.put(LoaderController());
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//   Future<void> firebaseLoginWithGoogle() async {
//     loader.loaderFunction();
//     try {
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//       if (googleUser != null) {
//         final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         await auth.signInWithCredential(credential).then((c) {
//           loader.loaderFunction();
//           Get.snackbar("Welcome", "You are successfully logged in with Google");
//           Get.offAll(const NavigatorScreen());
//         });
//       } else {
//         Get.snackbar("Error", "Google sign-in was canceled");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "$e");
//     } finally {
//       loader.loaderFunction();
//     }
//   }
// }
