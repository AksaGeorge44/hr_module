import 'package:flutter/material.dart';

class CircularOverviewWidget extends StatelessWidget {
  final int totalEmployees = 100;
  final int employeesWorking = 80;
  final int employeesResigned = 10;
  final int employeesOnLeave = 10;

  const CircularOverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 5.0,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildCircularOverviewItem('Total Employees', totalEmployees),
            _buildCircularOverviewItem('Working', employeesWorking),
            _buildCircularOverviewItem('Resigned', employeesResigned),
            _buildCircularOverviewItem('On Leave', employeesOnLeave),
          ],
        ),
      ],
    );
  }

  Widget _buildCircularOverviewItem(String title, int value) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 10,),
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 24, color: Colors.black),
          ),
        ],
      ),
    );
  }
}