class Course {
  final String name;
  final int credits;
  final double grade;

  Course({
    required this.name,
    required this.credits,
    required this.grade,
  });

  const Course.constant({
    required this.name,
    required this.credits,
    required this.grade,
  });
}