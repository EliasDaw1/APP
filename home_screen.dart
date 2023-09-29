import 'package:flutter/material.dart';
import 'package:gpa_calculator/semester_model.dart'; // Replace with the actual import path
import 'package:gpa_calculator/year_model.dart'; // Replace with the actual import path
import 'package:gpa_calculator/semester_details_screen.dart'; // Replace with the actual import path
import 'package:gpa_calculator/year_bar.dart'; // Replace with the actual import path
import 'package:gpa_calculator/gpa_calculatorss.dart'; // Replace with the actual import path
import 'package:gpa_calculator/gpa_impact_screen.dart'; // Replace with the actual import path

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Year> years = [];
  static const maxYears = 5;

  void _addYear() {
    if (years.length < maxYears) {
      setState(() {
        years.add(Year(
          id: years.length + 1,
          semesters: [
            Semester(name: 'Semester A', courses: []),
            Semester(name: 'Semester B', courses: []),
            Semester(name: 'Summer Semester', courses: []),
          ],
        ));
      });
    }
  }

  void _showImpact() {
    List<CourseImpact> courseImpacts = [];

    for (var year in years) {
      for (var semester in year.semesters) {
        for (var course in semester.courses) {
          double impact = calculateImpact(course);
          courseImpacts.add(CourseImpact(course: course, impact: impact));
        }
      }
    }

    // Sort the courses based on impact
    courseImpacts.sort((a, b) => b.impact.compareTo(a.impact));

    // Navigate to the GpaImpactScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GpaImpactScreen(courseImpacts: courseImpacts),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Calculator'),
        elevation: 5.0,
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: _showImpact,
          ),
        ],
      ),
      body: years.isEmpty
          ? const Center(
              child: Text(
                'No years added. Tap the + button to add a new year.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: years.length,
              itemBuilder: (context, index) {
                final year = years[index];
                return YearBar(
                  year: year,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SemesterDetailsScreen(year: year),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addYear,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
