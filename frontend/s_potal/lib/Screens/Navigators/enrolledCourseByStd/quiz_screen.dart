import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_potal/controllers/CourseCrud/course_model.dart';
import 'package:s_potal/widegts/textwidget.dart';

import '../../../constant/colorclass.dart';
import '../../../controllers/quiz controller/quiz_controller.dart';
import '../../../controllers/std_reward/progress_controller.dart';
import '../../../controllers/std_reward/student_progress_model.dart';
import '../navigator_screen.dart';

class QuizScreen extends StatefulWidget {
  final Course course;
  const QuizScreen({super.key, required this.course});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizController quizController = Get.put(QuizController());
  final ProgressController progressController = Get.put(ProgressController());
  final Map<int, int> selectedAnswers = {}; // Map to store selected answers
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    await quizController.fetchQuizzesByCourseId(widget.course.id!);
    setState(() {});
  }

  // Calculate and display the result
  void submitQuiz() {
    correctAnswers = 0;
    final questions =
        quizController.quizzes[0][0]["questions"] as List<dynamic>;

    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i]["correctAnswer"]) {
        correctAnswers++;
      }
    }

    double percentage = (correctAnswers / questions.length) * 100;

    String resultMessage =
        percentage > 80 ? 'Congratulations, you passed!' : 'Sorry, you failed.';
    Get.defaultDialog(
      title: 'Quiz Result',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Your Score: $correctAnswers/${questions.length}'),
          Text('Percentage: ${percentage.toStringAsFixed(2)}%'),
          Text(resultMessage),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          final int f = percentage.toInt();
          if (f > 90) {
            final stdProgress = StudentProgress(
              uid: FirebaseAuth.instance.currentUser!.uid,
              percentage: (percentage).toInt(),
              courseName: widget.course.title,
            );
            await progressController.createProgress(stdProgress);
          }
          Get.offAll(() => const NavigatorScreen());
        },
        style:
            ElevatedButton.styleFrom(backgroundColor: MyColors.primaryPallet),
        child: const Text('OK'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        title: TextWidget(
          text: "Quiz",
          fSize: 24,
          textColor: Colors.white,
        ),
        centerTitle: true,
      ),
      body: quizController.quizzes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: quizController.quizzes[0][0]["questions"].length,
              itemBuilder: (context, questionIndex) {
                final question = quizController.quizzes[0][0]["questions"]
                    [questionIndex]["question"];
                final options = quizController.quizzes[0][0]["questions"]
                    [questionIndex]["options"] as List<dynamic>;

                return Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: MyColors.bgPallet,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question Text
                      Text(
                        "Q${questionIndex + 1}: $question",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: MyColors.primaryPallet,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Options
                      ...List.generate(
                        options.length,
                        (optionIndex) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAnswers[questionIndex] = optionIndex + 1;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: selectedAnswers[questionIndex] ==
                                      optionIndex + 1
                                  ? MyColors.thirdPallet
                                  : MyColors.transparentBgPallet,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: MyColors.secondaryPallet,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              options[optionIndex],
                              style: TextStyle(
                                fontSize: 16,
                                color: selectedAnswers[questionIndex] ==
                                        optionIndex + 1
                                    ? Colors.white
                                    : MyColors.primaryPallet,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: submitQuiz,
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.secondaryPallet,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Submit Quiz',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
