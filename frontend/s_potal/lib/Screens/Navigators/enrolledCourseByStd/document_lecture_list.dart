import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/colorclass.dart';
import 'open_pdf.dart';

class DocumentLectureList extends StatelessWidget {
  final List<String> fileUrls;
  const DocumentLectureList({super.key, required this.fileUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        title: const Text(
          'Documents Lectures',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
          itemCount: fileUrls.length,
          itemBuilder: (context, index) {
            final link = fileUrls[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => PDFScreen(
                      pdfUrl: link,
                    ));
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MyColors.thirdPallet,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.folder, size: 48, color: MyColors.bgPallet),
                    const SizedBox(height: 8),
                    Text(
                      'Lecture ${index + 1}',
                      style: TextStyle(
                        color: MyColors.bgPallet,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
