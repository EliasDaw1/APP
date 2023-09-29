import 'package:flutter/material.dart';
import 'package:gpa_calculator/semester_model.dart';
import 'package:gpa_calculator/course_model.dart';

class SemesterScreen extends StatefulWidget {
  final Semester semester;
  const SemesterScreen({Key? key, required this.semester}) : super(key: key);
  @override
  _SemesterScreenState createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  
  void addCourse() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController creditsController = TextEditingController();
    TextEditingController finalGradeController = TextEditingController();
    TextEditingController assignmentWeightageController = TextEditingController();
    TextEditingController assignmentGradeController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Course'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Course Name'),
                  validator: (value) => value!.isEmpty ? 'Enter Course Name' : null,
                ),
                TextFormField(
                  controller: creditsController,
                  decoration: const InputDecoration(labelText: 'Credits'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter Credits' : null,
                ),
                TextFormField(
                  controller: finalGradeController,
                  decoration: const InputDecoration(labelText: 'Final Exam Grade'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter Final Exam Grade' : null,
                ),
                TextFormField(
                  controller: assignmentWeightageController,
                  decoration: const InputDecoration(labelText: 'Assignment Weightage (Optional)'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: assignmentGradeController,
                  decoration: const InputDecoration(labelText: 'Assignment Grade (Optional)'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String name = nameController.text;
                int credits = int.parse(creditsController.text);
                double finalGrade = double.parse(finalGradeController.text);
                double? assignmentWeightage = assignmentWeightageController.text.isNotEmpty
                    ? double.parse(assignmentWeightageController.text)
                    : null;
                double? assignmentGrade = assignmentGradeController.text.isNotEmpty
                    ? double.parse(assignmentGradeController.text)
                    : null;
                double courseFinalGrade = (assignmentWeightage != null && assignmentGrade != null)
                    ? (100 - assignmentWeightage) * finalGrade / 100 + assignmentWeightage * assignmentGrade / 100
                    : finalGrade;
                Course newCourse = Course(
                  name: name,
                  credits: credits,
                  grade: courseFinalGrade,
                );
                setState(() {
                  widget.semester.courses.add(newCourse);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }


void editCourse(Course course) async {
  TextEditingController nameController = TextEditingController(text: course.name);
  TextEditingController creditsController = TextEditingController(text: course.credits.toString());
  TextEditingController finalGradeController = TextEditingController(text: course.grade.toString());
  TextEditingController assignmentWeightageController = TextEditingController();
  TextEditingController assignmentGradeController = TextEditingController();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Course'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Course Name'),
                validator: (value) => value!.isEmpty ? 'Enter Course Name' : null,
              ),
              TextFormField(
                controller: creditsController,
                decoration: const InputDecoration(labelText: 'Credits'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter Credits' : null,
              ),
              TextFormField(
                controller: finalGradeController,
                decoration: const InputDecoration(labelText: 'Final Exam Grade'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter Final Exam Grade' : null,
              ),
              TextFormField(
                controller: assignmentWeightageController,
                decoration: const InputDecoration(labelText: 'Assignment Weightage (Optional)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: assignmentGradeController,
                decoration: const InputDecoration(labelText: 'Assignment Grade (Optional)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String name = nameController.text;
              int credits = int.parse(creditsController.text);
              double finalGrade = double.parse(finalGradeController.text);
              double? assignmentWeightage = assignmentWeightageController.text.isNotEmpty
                  ? double.parse(assignmentWeightageController.text)
                  : null;
              double? assignmentGrade = assignmentGradeController.text.isNotEmpty
                  ? double.parse(assignmentGradeController.text)
                  : null;
              double courseFinalGrade = (assignmentWeightage != null && assignmentGrade != null)
                  ? (100 - assignmentWeightage) * finalGrade / 100 + assignmentWeightage * assignmentGrade / 100
                  : finalGrade;
              Course updatedCourse = Course(
                name: name,
                credits: credits,
                grade: courseFinalGrade,
              );
              int index = widget.semester.courses.indexOf(course);
              setState(() {
                widget.semester.courses[index] = updatedCourse;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Update'),
          ),
        ],
      );
    },
  );
}


  void removeCourse(Course course) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Course'),
          content: Text('Are you sure you want to remove ${course.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.semester.courses.remove(course);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  double calculateGPA() {
    double totalPoints = 0;
    int totalCredits = 0;
    for (var course in widget.semester.courses) {
      totalPoints += course.grade * course.credits;
      totalCredits += course.credits;
    }
    double gpa = totalCredits > 0 ? totalPoints / totalCredits : 0;
    return double.parse(gpa.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.semester.name} - GPA: ${calculateGPA().toStringAsFixed(2)}')),
      body: ListView.builder(
        itemCount: widget.semester.courses.length,
        itemBuilder: (context, index) {
          var course = widget.semester.courses[index];
          return ListTile(
            title: Text(course.name),
            subtitle: Text('Grade: ${course.grade.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => editCourse(course),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () => removeCourse(course),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCourse,
        child: const Icon(Icons.add),
      ),
    );
  }
}