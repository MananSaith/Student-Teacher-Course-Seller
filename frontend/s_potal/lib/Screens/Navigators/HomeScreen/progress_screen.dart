import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/colorclass.dart';
import '../../../controllers/std_reward/progress_controller.dart';

class ProgressScreen extends StatelessWidget {
  final String uid;
  ProgressScreen({super.key, required this.uid});

  final ProgressController _controller = Get.put(ProgressController());

  @override
  Widget build(BuildContext context) {
    // Fetch progress when the screen loads
    _controller.fetchProgressByUid(uid);

    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        title: const Text(
          'Student Progress',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MyColors.primaryPallet,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.progressList.isEmpty) {
          return const Center(child: Text('No progress found.'));
        }

        return ListView.builder(
          itemCount: _controller.progressList.length,
          itemBuilder: (context, index) {
            final progress = _controller.progressList[index];
            return Card(
              color: MyColors.scaffoldBack,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListTile(
                title: Text(progress.courseName,
                    style: TextStyle(color: MyColors.primaryPallet)),
                subtitle: Text(
                  'Progress: ${progress.percentage}%',
                  style: TextStyle(color: MyColors.secondaryPallet),
                ),
                trailing: CircleAvatar(
                  backgroundColor: MyColors.thirdPallet,
                  child: Text(
                    '${progress.percentage}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
