import 'package:flutter/material.dart';
import 'package:gpa_calculator/course_model.dart';

class GpaImpactScreen extends StatelessWidget {
  final List<CourseImpact> courseImpacts;

  const GpaImpactScreen({Key? key, required this.courseImpacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Impact on GPA'),
      ),
      body: ListView.builder(
        itemCount: courseImpacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(courseImpacts[index].course.name),
            subtitle: Text('Final Grade: ${courseImpacts[index].course.grade.toStringAsFixed(2)}\nImpact: ${courseImpacts[index].impact.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}

class CourseImpact {
  final Course course;
  final double impact;

  CourseImpact({required this.course, required this.impact});
}
