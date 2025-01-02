import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colorclass.dart';
import '../../constant/font_weight.dart';
import '../../constant/string_constant.dart';
import '../../controllers/Utils_Controller/loader_controller.dart';
import '../../controllers/firebaseRegistrationController/login_controller.dart';
import '../../widegts/custum_button.dart';
import '../../widegts/inputdecorationwidget.dart';
import '../../widegts/textwidget.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());
  final LoaderController loader = Get.put(LoaderController());

  ImageProvider logo = AssetImage('assets/teacherlogin.jpg');
  @override
  void dispose() {
    // controller.email.clear();
    //controller.password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  //image: AssetImage(MyText.teacherBackgrounLoginPik),
                  image: logo,
                  fit: BoxFit.cover, // Cover the entire screen
                ),
              ),
            ),
            Container(
              height: height,
              width: width,
              color: MyColors.transparentBgPallet,
            ),
            Form(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.2),
                    TextWidget(
                      text: MyText.login,
                      fSize: 35,
                      fWeight: MyFontWeight.extra,
                    ),
                    SizedBox(height: height * 0.035),
                    TextFormField(
                      // controller: controller.email,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: true, // Enable autocorrect
                      enableSuggestions: true, // Allow suggestions
                      textInputAction: TextInputAction.next,
                      decoration: inputDecorationWidget(
                          text: MyText.email,
                          bdcolor: MyColors.white,
                          prefixIcon: const Icon(Icons.email)),
                    ),
                    SizedBox(height: height * 0.025),
                    TextFormField(
                      // controller: controller.password,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: inputDecorationWidget(
                          text: MyText.password,
                          bdcolor: MyColors.white,
                          prefixIcon: const Icon(Icons.password)),
                    ),
                    SizedBox(height: height * 0.025),
                    Obx(() {
                      return CustomElevatedButton(
                        width: width,
                        backgroundColor: MyColors.primaryPallet,
                        textColor: MyColors.white,
                        startIcon: Icon(
                          Icons.login,
                          color: MyColors.lowWhite,
                        ),
                        text: MyText.login,
                        isLoading: loader.loader.value,
                        onPressed: () {
                          controller.firebaseLoginWithEmailPassword();
                        },
                      );
                    }),
                    SizedBox(height: height * 0.025),
                    Obx(() {
                      return CustomElevatedButton(
                        width: width,
                        backgroundColor: MyColors.primaryPallet,
                        textColor: MyColors.white,
                        startIcon: Icon(
                          Icons.login,
                          color: MyColors.lowWhite,
                        ),
                        text: MyText.loginWithGoogle,
                        isLoading: loader.loader.value,
                        onPressed: () {
                          controller.firebaseLoginWithEmailPassword();
                        },
                      );
                    }),
                    SizedBox(height: height * 0.055),
                    CustomElevatedButton(
                      width: width,
                      backgroundColor: MyColors.secondaryPallet,
                      textColor: MyColors.white,
                      startIcon: Image.asset(
                        MyText.googleIcon,
                        height: height * 0.045,
                      ),
                      text: MyText.continoueWithGoogle,
                      fontSize: 20,
                      isLoading: loader.loader.value,
                      onPressed: () {
                        Get.to(() => const SignupScreen());
                      },
                    ),
                  ],
                ),
              ),
            )),
          ],
        ));
  }
}
