
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:t_potal/constant/string_constant.dart';
import '../../screens/NavigatorScreens/initial/navigator_screen.dart';
import '../Utils_Controller/loader_controller.dart';
import '../techerDataFromNode/teacherInfo/teacher_crud.dart';

class LoginController extends GetxController {
  final LoaderController loader = Get.put(LoaderController());
  final TeacherCrud teacherCrudController = Get.put(TeacherCrud());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Your backend URL
  final String backendUrl = "${MyText.basicUrlApi}/api/teacher/email";

  Future<void> firebaseLoginWithEmailPassword() async {
    loader.loaderFunction();
    try {
      // Initiate Google sign-in
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Verify user existence in the backend
        final bool userExists = await _checkUserInBackend(googleUser.email);

        if (userExists) {
          // Create Firebase credential
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          // Sign in with Firebase
          await auth.signInWithCredential(credential).then((_) {
            loader.loaderFunction();
            Get.snackbar(
                "Welcome", "You are successfully logged in with Google");
            Get.offAll(const NavigatorScreen());
          });
        } else {
          Get.snackbar("Error", "User not registered. Please sign up first.");
        }
      } else {
        Get.snackbar("Error", "Google sign-in was canceled");
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
    } finally {
      loader.loaderFunction();
    }
  }

  Future<bool> _checkUserInBackend(String email) async {
    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data[
            'success']; // Assume backend returns { "success": true/false }
      } else {
        Get.snackbar("Error", "Failed to verify user.");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Server error: $e");
      return false;
    }
  }
}
