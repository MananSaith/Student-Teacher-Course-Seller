import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:s_potal/constant/string_constant.dart';

// ignore: must_be_immutable
class PDFScreen extends StatelessWidget {
  String pdfUrl;
  PDFScreen({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: FutureBuilder(
        future: _downloadFile("${MyText.basicUrlApi}/$pdfUrl"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading PDF'));
          } else {
            return PDFView(
              filePath: snapshot.data,
            );
          }
        },
      ),
    );
  }

  Future<String> _downloadFile(String url) async {
    // Download the PDF file from the given URL
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    // Save the PDF file to local storage and return its path
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/document.pdf';
    File(filePath).writeAsBytesSync(bytes);

    return filePath;
  }
}
