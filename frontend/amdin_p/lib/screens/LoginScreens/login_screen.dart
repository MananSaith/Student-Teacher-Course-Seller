import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

import '../../constant/colorclass.dart';
import '../../constant/font_weight.dart';
import '../../constant/string_constant.dart';
import '../HomeScreen/homescreen.dart';
import '../../widgets/custum_button.dart';
import '../../widgets/inputdecorationwidget.dart';
import '../../widgets/snackbar_custom.dart';
import '../../widgets/textwidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: MyColors.scaffoldBack,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: height * 0.35,
              pinned: true,
              stretch: true,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(bottom: 40, left: 40),
                title: TextWidget(
                  text: MyText.login,
                  fSize: 20,
                  fWeight: MyFontWeight.bold,
                  textColor: MyColors.camel,
                ),
                background: Image.asset(
                  MyText.adminLoginPik,
                  fit: BoxFit.cover,
                ),
              ),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.0),
                  child: Container(
                    height: height * 0.03,
                    decoration: BoxDecoration(
                        color: MyColors.scaffoldBack,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                  )),
            ),
            SliverToBoxAdapter(
              child: Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.02),
                        Center(
                          child: TextWidget(
                            text: MyText.adminPanel,
                            fSize: 22,
                            fWeight: MyFontWeight.extra,
                            textColor: MyColors.primaryPallet,
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: true, // Enable autocorrect
                          enableSuggestions: true, // Allow suggestions
                          textInputAction: TextInputAction.next,
                          decoration: inputDecorationWidget(
                              text: MyText.email,
                              bdcolor: MyColors.white,
                              prefixIcon: const Icon(Icons.email)),
                          validator:
                              ValidationBuilder().email().maxLength(25).build(),
                        ),
                        SizedBox(height: height * 0.025),
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: inputDecorationWidget(
                              text: MyText.password,
                              bdcolor: MyColors.white,
                              prefixIcon: const Icon(Icons.password)),
                          validator: ValidationBuilder()
                              .minLength(8)
                              .maxLength(25)
                              .build(),
                        ),
                        SizedBox(height: height * 0.025),
                        CustomElevatedButton(
                          width: width,
                          backgroundColor: MyColors.primaryPallet,
                          textColor: MyColors.white,
                          startIcon: Icon(
                            Icons.login,
                            color: MyColors.lowWhite,
                          ),
                          text: MyText.login,
                          onPressed: () {
                            if (key.currentState?.validate() ?? false) {
                              if (email.text == "admin@gmail.com" &&
                                  password.text == "11223344") {
                                Get.offAll(() => const Homescreen());
                              } else {
                                showCustomSnackBar(
                                    title: "Login Error",
                                    message: "Enter correct password and Email",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: MyColors.thirdPallet);
                              }
                            }
                          },
                        ),
                        SizedBox(height: height * 0.03),
                      ],
                    ),
                  )),
            )
          ],
        ));
  }
}
