import 'package:gpa_calculator/semester_model.dart';

class Year {
  final int id;
  final List<Semester> semesters;

  Year({
    required this.id,
    List<Semester>? semesters,
  }) : semesters = semesters ?? [
        Semester(name: 'Semester A'),
        Semester(name: 'Semester B'),
        Semester(name: 'Summer Semester'),
      ];
}
