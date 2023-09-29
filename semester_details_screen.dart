
import 'package:flutter/material.dart';
import 'package:gpa_calculator/semester_model.dart';
import 'package:gpa_calculator/year_model.dart';
import 'semester_screen.dart';

class SemesterDetailsScreen extends StatefulWidget {
  final Year year;

  const SemesterDetailsScreen({super.key, required this.year});

  @override
  _SemesterDetailsScreenState createState() => _SemesterDetailsScreenState();
}

class _SemesterDetailsScreenState extends State<SemesterDetailsScreen> {

  /// Calculates the GPA for the given [semester].
  double calculateGPA(Semester semester) {
    double totalPoints = 0;
    double totalCredits = 0;

    for (var course in semester.courses) {
      totalPoints += course.grade * course.credits;
      totalCredits += course.credits;
    }

    return totalCredits > 0 ? totalPoints / totalCredits : 0;
  }
  
  /// Calculates the cumulative GPA for all semesters.
  double calculateCumulativeGPA() {
    double totalPoints = 0;
    double totalCredits = 0;
    for (var semester in widget.year.semesters) {
      for (var course in semester.courses) {
        totalPoints += course.grade * course.credits;
        totalCredits += course.credits;
      }
    }
    return totalCredits > 0 ? totalPoints / totalCredits : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.year.id} - Semester Details'),
        elevation: 5.0,
      ),
      body: Column(
        children: [
          // Display the cumulative GPA
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Cumulative GPA: ${calculateCumulativeGPA().toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          // Display the list of semesters
          Expanded(
            child: ListView.builder(
              itemCount: widget.year.semesters.length,
              itemBuilder: (context, index) {
                final semester = widget.year.semesters[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Semester: ${semester.name}'),
                    subtitle: Text('GPA: ${calculateGPA(semester).toStringAsFixed(2)}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SemesterScreen(semester: semester),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
