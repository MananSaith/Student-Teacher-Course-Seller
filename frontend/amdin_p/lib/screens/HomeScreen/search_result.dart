// New widget for displaying search results
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/techerDataFromNode/teacher_crud.dart';
import '../../controller/techerDataFromNode/teacher_json.dart';
import 'contained_tab_bar_view.dart';

searchResults({required String searchQuery}) {
  final TeacherCrud teacherCrudController = Get.find<TeacherCrud>();

  return FutureBuilder<List<TeacherJson>>(
    future: teacherCrudController.fetchTeachersAsync(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("No data available"));
      } else {
        final teachers = snapshot.data!;
        final filteredTeachers = teachers.where((teacher) {
          return teacher.name
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              teacher.email.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

        if (filteredTeachers.isEmpty) {
          return const Center(child: Text("No results found"));
        }
        return Container(
          height:
              MediaQuery.of(context).size.height * 0.8, // Adjust as necessary
          child: ListView.builder(
            itemCount: filteredTeachers.length,
            itemBuilder: (context, index) {
              return teacherListTile(teacher: filteredTeachers[index]);
            },
          ),
        );
      }
    },
  );
}
