import 'package:flutter/material.dart';

import '../../../constant/colorclass.dart';
import '../../../constant/free_course.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        title: const Text(
          'Courses',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: CourseData.courses.length,
        itemBuilder: (context, index) {
          // Get course data
          var course = CourseData.courses[index];

          return ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: Image.asset(
              course['image'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(
              course['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              course['description'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              // Navigate to the detailed course page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailScreen(course: course),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CourseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    // Get screen height to adjust padding dynamically
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        title: Text(
          course['title'],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Image
              Image.asset(course['image']),
              const SizedBox(height: 16),

              // Course Title
              Text(
                course['title'],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Course Description
              Text(
                course['details'],
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Course Content Heading
              const Text(
                'Course Content:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Course Headings List
              ...course['headings'].map<Widget>((heading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    heading['title'],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),

              // Ensure spacing at the bottom to prevent overflow
              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
