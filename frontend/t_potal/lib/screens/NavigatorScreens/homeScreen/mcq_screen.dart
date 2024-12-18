import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_potal/constant/colorclass.dart';
import '../../../constant/font_weight.dart';
import '../../../constant/string_constant.dart';
import '../../../controllers/Utils_Controller/custom_loader_controller.dart';
import '../../../controllers/techerDataFromNode/courseUpload/course_curd_controller.dart';
import '../../../controllers/techerDataFromNode/courseUpload/course_data_controller.dart';
import '../../../controllers/techerDataFromNode/courseUpload/course_model_json.dart';
import '../../../controllers/techerDataFromNode/courseUpload/quiz_modle.dart';
import '../../../controllers/techerDataFromNode/teacherInfo/teacher_crud.dart';
import '../../../utils/custom_loader.dart';
import '../../../widegts/custum_button.dart';
import '../../../widegts/textwidget.dart';
import 'homescreen.dart';

class AddMCQPage extends StatefulWidget {
  AddMCQPage({super.key});

  @override
  State<AddMCQPage> createState() => _AddMCQPageState();
}

class _AddMCQPageState extends State<AddMCQPage> {
  final TeacherCrud teacherCrudController = Get.put(TeacherCrud());

  final CourseDataController controller = Get.put(CourseDataController());

  final CourseController courseController = Get.put(CourseController());

  final CunstomLoaderController loadingController =
      Get.put(CunstomLoaderController());

  final _auth = FirebaseAuth.instance.currentUser;

  final TextEditingController questionController = TextEditingController();

  final List<TextEditingController> optionControllers =
      List.generate(4, (_) => TextEditingController());

  final RxInt selectedAnswer = 0.obs;
  // Store the selected correct answer index (1-4)
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    await teacherCrudController.getUserById(uid: currentUser!.uid);
    setState(() {});
  }

  // Clears input fields after adding an MCQ
  void clearFields() {
    questionController.clear();
    for (var controller in optionControllers) {
      controller.clear();
    }
    selectedAnswer.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: MyText.addMcq,
          fSize: 16,
          fWeight: MyFontWeight.bold,
          textColor: MyColors.white,
        ),
        backgroundColor: MyColors.primaryPallet,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Ensure this wraps the entire content
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: MyText.enterQuestion,
                      fSize: 20,
                      fWeight: MyFontWeight.samiBold,
                    ),
                    Obx(() {
                      return TextWidget(
                        text: controller.mcqLenght.value.toString(),
                        fSize: 20,
                        fWeight: MyFontWeight.samiBold,
                        textColor: MyColors.camel,
                      );
                    }),
                  ],
                ),
                SizedBox(height: height * 0.013),
                TextField(
                  controller: questionController,
                  decoration: InputDecoration(
                    labelText: 'Question',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: MyColors.secondaryPallet),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.017),
                TextWidget(
                  text: MyText.option,
                  fSize: 20,
                  fWeight: MyFontWeight.samiBold,
                ),
                ...List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextField(
                      controller: optionControllers[index],
                      decoration: InputDecoration(
                        labelText: '${MyText.option} ${index + 1}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: MyColors.secondaryPallet),
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(height: height * 0.015),
                TextWidget(
                  text: MyText.selectans,
                  fSize: 19,
                  fWeight: MyFontWeight.samiBold,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (index) {
                    return Obx(() => ChoiceButton(
                          index: index,
                          isSelected: selectedAnswer.value == index,
                          onPressed: () => selectedAnswer.value = index,
                        ));
                  }),
                ),
                SizedBox(height: height * 0.022),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        // Add MCQ to the controller's list
                        if (questionController.text.isNotEmpty &&
                            optionControllers.every(
                                (controller) => controller.text.isNotEmpty)) {
                          final quiz = Question(
                            question: questionController.text,
                            options:
                                optionControllers.map((c) => c.text).toList(),
                            correctAnswer: selectedAnswer.value + 1,
                          );
                          controller.addMCQ(mcq: quiz);
                          // Clear fields for the next entry
                          clearFields();
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please add question & all 4 options',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      text: "Add MCQ",
                      backgroundColor: MyColors.thirdPallet,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        // Add MCQ to the controller's list
                        if (controller.mcqList.isNotEmpty) {
                          if (questionController.text.isNotEmpty &&
                              optionControllers.every(
                                  (controller) => controller.text.isNotEmpty)) {
                            final quiz = Question(
                              question: questionController.text,
                              options:
                                  optionControllers.map((c) => c.text).toList(),
                              correctAnswer: selectedAnswer.value + 1,
                            );
                            controller.addMCQ(mcq: quiz);
                            //ya function data upload kara ga then navegate kara ga
                            uploadCompleteCourse();
                          } else {
                            Get.snackbar(
                              'Error',
                              'Please add question & all 4 options',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        } else {
                          Get.snackbar(
                            'Alert',
                            'enter at least 10 MCQ\'s',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      text: "Submit",
                      backgroundColor: MyColors.thirdPallet,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.023),
                ListView.builder(
                  shrinkWrap: true, // Ensure it wraps the height of the content
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling
                  itemCount: controller.mcqList.length,
                  itemBuilder: (context, index) {
                    Question mcq = controller.mcqList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: 'Q${index + 1}: ${mcq.question}',
                                fSize: 13,
                                fWeight: MyFontWeight.samiBold,
                                overFlow: true,
                              ),
                              TextWidget(
                                text: 'Correct: ${mcq.correctAnswer}',
                                fSize: 13,
                                fWeight: MyFontWeight.small,
                                textColor: MyColors.green,
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(4, (i) {
                              return Text('${i + 1}. ${mcq.options[i]}');
                            }),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              controller.mcqList.removeAt(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: MyColors.red,
                            ),
                          )),
                    );
                  },
                ),
              ],
            ),
            if (loadingController.isLoading.value) const LoaderOverlay(),
          ]);
        }),
      ),
    );
  }

  void uploadCompleteCourse() async {
    final course = Course(
        description: controller.description.value,
        title: controller.title.value,
        imagePath: controller.imagePath.value,
        byteImage: controller.byte.value,
        price: controller.price.value,
        files: controller.documentList,
        uid: _auth!.uid,
        videoLectures: controller.videoList,
        mcid: teacherCrudController.selectedTeacher.value!.mcid);

    await courseController.createCourse(course).then((value) {
      // Clear fields for the next entry
      clearFields();
      Get.offAll(() => const Homescreen());
    }).catchError((v) {});
  }
}

// ChoiceButton widget for correct answer selection
class ChoiceButton extends StatelessWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onPressed;

  const ChoiceButton({
    super.key,
    required this.index,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? MyColors.thirdPallet : Colors.grey,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text('${index + 1}', style: const TextStyle(fontSize: 18)),
    );
  }
}
