import 'package:gpa_calculator/course_model.dart'; // Replace with the actual import path

double calculateImpact(Course course) {
  // Assuming the maximum grade is 100
  return ((100 - course.grade) / 100) * course.credits;
}
