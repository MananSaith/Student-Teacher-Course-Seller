import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import '../../constant/colorclass.dart';
import '../../constant/font_weight.dart';
import '../../constant/string_constant.dart';
import '../../controllers/Utils_Controller/custom_loader_controller.dart';
import '../../controllers/firebaseRegistrationController/sign_up_controller.dart';
import '../../utils/custom_loader.dart';
import '../../widegts/custum_button.dart';
import '../../widegts/inputdecorationwidget.dart';
import '../../widegts/textwidget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignUpController controller = Get.put(SignUpController());
  final CunstomLoaderController loadingController =
      Get.put(CunstomLoaderController());
  GlobalKey<FormState> key = GlobalKey<FormState>();

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
                  image: AssetImage(MyText.teacherBackgrounSignInPik),
                  fit: BoxFit.cover, // Cover the entire screen
                ),
              ),
            ),
            Container(
              height: height,
              width: width,
              color: MyColors.transparentBgPallet,
            ),
            Obx(() {
              return Stack(children: [
                Form(
                    key: key,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: TextWidget(
                            text: MyText.signUp,
                            fSize: 35,
                            fWeight: MyFontWeight.bold,
                          )),
                          SizedBox(height: height * 0.045),
                          TextFormField(
                            controller: controller.userName,
                            keyboardType: TextInputType.name,
                            autocorrect: true, // Enable autocorrect
                            enableSuggestions: true, // Allow suggestions
                            textInputAction: TextInputAction.next,
                            decoration: inputDecorationWidget(
                                text: MyText.userName,
                                bdcolor: MyColors.white,
                                prefixIcon: const Icon(Icons.person)),
                            validator: ValidationBuilder()
                                .minLength(6)
                                .maxLength(20)
                                .build(),
                          ),
                          SizedBox(height: height * 0.025),
                          TextFormField(
                            controller: controller.messageCallID,
                            keyboardType: TextInputType.number,
                            decoration: inputDecorationWidget(
                                text: MyText.idString,
                                bdcolor: MyColors.white,
                                prefixIcon: const Icon(Icons.key)),
                            validator: ValidationBuilder()
                                .minLength(1)
                                .maxLength(6)
                                .build(),
                            onChanged: (value) {
                              controller.messageCallID.text = value;
                              controller.checkMcid();
                            },
                          ),
                          SizedBox(height: height * 0.010),
                          Obx(() {
                            return controller.isMcidTaken.value
                                ? TextWidget(
                                    text: MyText.alreadyId,
                                    fSize: 15,
                                    fWeight: MyFontWeight.small,
                                    textColor: MyColors.red,
                                  )
                                : TextWidget(
                                    text: MyText.avalibleyId,
                                    fSize: 15,
                                    fWeight: MyFontWeight.small,
                                    textColor: MyColors.black,
                                  );
                          }),
                          SizedBox(height: height * 0.025),
                          CustomElevatedButton(
                            width: width,
                            backgroundColor: MyColors.secondaryPallet,
                            textColor: MyColors.black,
                            startIcon: Icon(
                              Icons.flash_on,
                              color: MyColors.camel,
                              size: 30,
                            ),
                            text: MyText.signUp,
                            fontSize: 20,
                            onPressed: () {
                              if (!controller.isMcidTaken.value) {
                                if (key.currentState?.validate() ?? false) {
                                  controller.signInWithGoogle();
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                        ],
                      ),
                    )),
                if (loadingController.isLoading.value) const LoaderOverlay(),
              ]);
            })
          ],
        ));
  }
}
