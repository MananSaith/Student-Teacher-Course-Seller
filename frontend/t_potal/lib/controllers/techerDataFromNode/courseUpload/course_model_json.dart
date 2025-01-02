// models/course_model.dart
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

class Course {
  final String title;
  final Uint8List? byteImage;
  final String description;
  final double price;
  final List<PlatformFile> videoLectures;
  final List<PlatformFile> files;
  final String uid;
  final String mcid;
  final String imagePath;
  final String category;
  String? id;

  Course(
      {required this.title,
      this.byteImage,
      required this.description,
      required this.price,
      required this.category,
      required this.videoLectures,
      required this.files,
      required this.uid,
      required this.mcid,
      required this.imagePath,
      this.id});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      category: json['category'],
      title: json['title'],
      imagePath: json['image'],
      description: json['description'],
      price: json['price'].toDouble(),
      videoLectures: List.from(json['videoLectures']),
      files: List.from(json['files']),
      uid: json['uid'],
      id: json['_id'],
      mcid: json["mcid"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category": category,
      'title': title,
      'image': imagePath,
      'description': description,
      'price': price,
      'videoLectures': videoLectures,
      'files': files,
      'uid': uid,
      "mcid":mcid
    };
  }
}
