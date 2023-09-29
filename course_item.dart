
import 'package:flutter/material.dart';
import 'package:gpa_calculator/course_model.dart';

class CourseItem extends StatelessWidget {
  final Course course;
  
  const CourseItem({super.key, required this.course});
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      title: Text(
        course.name,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          const Icon(Icons.grade, color: Colors.blueAccent),
          Text(' Grade: ${course.grade}, ', style: const TextStyle(fontSize: 16.0)),
          const Icon(Icons.credit_score, color: Colors.blueAccent),
          Text('Credits: ${course.credits}', style: const TextStyle(fontSize: 16.0)),
        ],
      ),
      onTap: () {
        // Implement onTap action if needed
      },
    );
  }
}
