//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:video_player/video_player.dart';
import '../../../constant/colorclass.dart';
import '../../../constant/font_weight.dart';
import '../../../constant/string_constant.dart';
import '../../../controllers/techerDataFromNode/courseUpload/course_data_controller.dart';
import '../../../widegts/custum_button.dart';
import '../../../widegts/textwidget.dart';
import 'mcq_screen.dart';

class VideoPdfLecturePage extends StatefulWidget {
  const VideoPdfLecturePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VideoPdfLecturePage createState() => _VideoPdfLecturePage();
}

class _VideoPdfLecturePage extends State<VideoPdfLecturePage> {
  final CourseDataController controller = Get.put(CourseDataController());
//  // VideoPlayerController? _videoController;

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }

//   // void _initializeVideoPlayer(String path) {
//   //   _videoController = VideoPlayerController.file(File(path))
//   //     ..initialize().then((_) {
//   //       setState(() {});
//   //       _videoController?.play();
//   //     });
//   // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        centerTitle: true,
        title: TextWidget(
          text: MyText.videoDocument,
          fSize: 25,
          fWeight: MyFontWeight.medium,
          textColor: MyColors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: MyText.uploadContent,
              fSize: 22,
              fWeight: MyFontWeight.bold,
            ),
            SizedBox(height: height * 0.025),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(
                  label: 'Upload Video',
                  onPressed: () async {
                    await controller.pickVideo();
                    // if (controller.videoList.isNotEmpty) {
                    //   _initializeVideoPlayer(controller.videoList.last.path!);
                    // }
                  },
                ),
                _buildActionButton(
                  label: 'Upload Document',
                  onPressed: () async {
                    await controller.pickDocument();
                  },
                ),
              ],
            ),

            SizedBox(height: height * 0.025),

            // // Video Preview
            // if (_videoController != null &&
            //     _videoController!.value.isInitialized)
            //   Container(
            //     margin: const EdgeInsets.symmetric(vertical: 10),
            //     height: height * 0.15,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withOpacity(0.1),
            //           blurRadius: 8,
            //           offset: Offset(0, 4),
            //         ),
            //       ],
            //     ),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(12),
            //       child: AspectRatio(
            //         aspectRatio: _videoController!.value.aspectRatio,
            //         child: VideoPlayer(_videoController!),
            //       ),
            //     ),
            //   ),

            // List of uploaded videos and documents
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.videoList.length +
                      controller.documentList.length,
                  itemBuilder: (context, index) {
                    if (index < controller.videoList.length) {
                      final videoFile = controller.videoList[index];
                      return _buildFileTile(
                          videoFile.name, 'Video', Icons.video_file, () {
                        controller.videoList.removeAt(index);
                      });
                    } else {
                      final docFile = controller
                          .documentList[index - controller.videoList.length];
                      return _buildFileTile(
                          docFile.name, 'Document', Icons.picture_as_pdf, () {
                        controller.documentList
                            .removeAt(index - controller.videoList.length);
                      });
                    }
                  },
                );
              }),
            ),

            SizedBox(height: height * 0.025),
            CustomElevatedButton(
              onPressed: () {
                if (controller.videoList.isEmpty ||
                    controller.documentList.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please add at least one video and one document.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  Get.to(() => AddMCQPage());
                }
              },
              text: MyText.next,
              height: height * 0.06,
              width: width * 0.3,
            )
          ],
        ),
      ),
    );
  }

  // Method to create action buttons
  Widget _buildActionButton(
      {required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.thirdPallet,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label),
    );
  }

  // Method to build file tiles for the list
  Widget _buildFileTile(
      String title, String subtitle, IconData icon, VoidCallback onDelete) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(icon, color: MyColors.secondaryPallet, size: 30),
        title: TextWidget(
          text: title,
          fSize: 15,
          fWeight: MyFontWeight.bold,
        ),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        tileColor: MyColors.bgPallet,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
