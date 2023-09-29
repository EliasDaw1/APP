
import 'package:flutter/material.dart';
import 'package:gpa_calculator/year_model.dart';

/// Represents a clickable bar displaying the year.
class YearBar extends StatelessWidget {
  final Year year;
  final VoidCallback onTap;
  
  const YearBar({super.key, required this.year, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blueAccent),
        ),
        child: Text(
          'Year ${year.id}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
      ),
    );
  }
}
