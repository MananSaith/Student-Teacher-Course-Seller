// screens/create_course_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:t_potal/constant/colorclass.dart';
import 'package:t_potal/constant/font_weight.dart';
import 'package:t_potal/constant/string_constant.dart';
import 'package:t_potal/widegts/textwidget.dart';
import '../../../controllers/techerDataFromNode/courseUpload/course_data_controller.dart';
import '../../../widegts/custum_button.dart';
import 'video_pdf_lec_screen.dart';

class CreateCourseScreen extends StatelessWidget {
  CreateCourseScreen({super.key});
  final CourseDataController controller = Get.put(CourseDataController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: TextWidget(
          text: MyText.createCourse,
          fSize: 20,
          fWeight: MyFontWeight.medium,
          textColor: MyColors.white,
        ),
        centerTitle: true,
        backgroundColor: MyColors.primaryPallet,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(height: height * 0.02),
              Obx(() {
                return Center(
                  child: Container(
                    width: height * 0.2,
                    height: width * 0.2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      image: controller.imagePath.value.isNotEmpty
                          ? DecorationImage(
                              image:
                                  FileImage(File(controller.imagePath.value)),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: AssetImage(
                                  MyText.googleIcon), // Default image
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                );
              }),
              SizedBox(height: height * 0.025),
              // Title
              buildTextField(
                label: 'Title',
                hintText: 'Enter course title',
                onChanged: controller.updateTitle,
                validator:
                    ValidationBuilder().minLength(6).maxLength(25).build(),
              ),
              SizedBox(height: height * 0.02),
              TextWidget(
                  text: "Category",
                  fSize: 16,
                  fWeight: MyFontWeight.samiBold,
                  textColor: MyColors.hint),
              SizedBox(height: height * 0.01),
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.category.value.isEmpty
                      ? null
                      : controller.category.value,
                  onChanged: (value) {
                    if (value != null) {
                      if (value == 'Free Courses') {
                        controller.updatePrice(0.0);
                      }
                      controller.category.value = value;
                    }
                  },
                  items: <String>[
                    'Algorithms',
                    'Artificial Intelligence',
                    'Computer Networks',
                    'Database Systems',
                    'Human-Computer Interaction',
                    'Operating Systems',
                    'Software Engineering',
                    "Theoretical Computer Science",
                    "Computer vision",
                    "Computer Graphics",
                    'Free Courses',
                    "other"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.deepPurple.shade300, width: 1.5),
                    ),
                  ),
                );
              }),

              SizedBox(height: height * 0.02),

              // Price
              buildTextField(
                  label: 'Price',
                  hintText: 'Enter course price',
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.updatePrice(
                      controller.category.value == 'Free Courses'
                          ? 0.0
                          : double.tryParse(value) ?? 0.0),
                  validator: ValidationBuilder().minLength(3).build()),
              SizedBox(height: height * 0.02),

              // Description
              buildTextField(
                label: 'Description',
                hintText: 'Enter a brief description',
                maxLines: 3,
                onChanged: controller.updateDescription,
                validator:
                    ValidationBuilder().minLength(8).maxLength(100).build(),
              ),
              SizedBox(height: height * 0.02),

              // Image Upload Button
              CustomElevatedButton(
                onPressed: () async {
                  await controller.pickImage();
                },
                text: MyText.uploadImage,
                textColor: MyColors.cream,
                backgroundColor: MyColors.thirdPallet,
                startIcon: const Icon(Icons.upload, color: Colors.white),
              ),
              SizedBox(height: height * 0.02),
              // Image Upload Button
              CustomElevatedButton(
                onPressed: () {
                  if (controller.imagePath.value.isNotEmpty) {
                    if (formKey.currentState?.validate() ?? false) {
                      Get.to(() => const VideoPdfLecturePage());
                    }
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please complete all fields and upload an image.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.shade600,
                      colorText: Colors.white,
                    );
                  }
                },
                text: MyText.next,
                textColor: MyColors.cream,
                backgroundColor: MyColors.secondaryPallet,
                endIcon: Icons.skip_next,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    String? hintText,
    TextInputType? keyboardType,
    int maxLines = 1,
    required void Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700),
        ),
        const SizedBox(height: 6),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Colors.deepPurple.shade300, width: 1.5),
            ),
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
