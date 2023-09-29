
import 'package:gpa_calculator/course_model.dart';

/// Represents a semester with a name and a list of courses.
class Semester {
  final String name;
  final List<Course> courses;

  /// Constructs a semester with the given [name] and an optional list of [courses].
  Semester({
    required this.name,
    List<Course>? courses,
  }) : courses = courses ?? [];
}
