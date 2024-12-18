import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../NodeStdCrud/std_json.dart';
import '../NodeStdCrud/studendController.dart';
import '../Utils_Controller/custom_loader_controller.dart';
import '../Utils_Controller/wrapper.dart';

class SignUpController extends GetxController {
  final CunstomLoaderController loader = Get.put(CunstomLoaderController());
  final StudentController studentController = Get.put(StudentController());
  final TextEditingController userName = TextEditingController();
  final TextEditingController messageCallID = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add required scopes for Google Sign-In (email, profile)
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  RxBool isMcidTaken = false.obs;
  User? currentUsers;

  Future<void> signInWithGoogle() async {
    loader.showLoader();

    try {
      // Opens the Google Sign-In screen where the user can choose their account
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        loader.hideLoader();
        // The user canceled the sign-in
        return;
      }

      // Fetch authentication tokens (access token and ID token) from the googleUser object.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the Google authentication tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Retrieve the signed-in user
      currentUsers = userCredential.user;

      if (currentUsers != null) {
        // Check if the UID already exists in Firestore
        bool check = await checkUIDExists(currentUsers!.uid);

        if (check) {
          // Show a snackbar if the user already exists
          Get.snackbar(
            'Welcome back',
            'You already have an account with this email.',
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          // Add new user info to mongodb if they don't have an account
          await additionalUserInfo();
        }
      }

      // Navigate to the next page after successful sign-in
      loader.hideLoader();
      Get.offAll(const Wrapper());
    } catch (error) {
      loader.hideLoader();
      Get.snackbar(
        'Sign In Error',
        'Failed to sign in with Google: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Function to add additional user info into mongodb
  Future<void> additionalUserInfo() async {
    try {
      final studentrData = Student(
        name: userName.text,
        email: currentUsers!.email as String,
        uid: currentUsers!.uid,
        mcid: messageCallID.text,
      );
      await studentController.addStudent(studentrData);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error storing user info: $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Function to check if the username already exists in Firestore
  Future<void> checkMcid() async {
    try {
      await studentController.fetchStudents();

      // ignore: invalid_use_of_protected_member
      final list = studentController.students.value;
      if (list.isNotEmpty) {
        for (final std in list) {
          if (std.mcid == messageCallID.text) {
            isMcidTaken.value = true;
          } else {
            isMcidTaken.value = false;
          }
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'server is down right now',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Function to check if a UID already exists in Firestore
  Future<bool> checkUIDExists(String uid) async {
    await studentController.fetchStudents();

    // ignore: invalid_use_of_protected_member
    final list = studentController.students.value;

    if (list.isEmpty) {
      return false; // Or handle the case where the list is empty or null
    }

    for (final teacher in list) {
      if (teacher.uid == uid) {
        return true;
      }
    }

    return false;
  }
}
