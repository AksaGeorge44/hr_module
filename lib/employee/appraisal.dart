import 'package:flutter/material.dart';

class PerformanceAppraisalScreen extends StatefulWidget {
  const PerformanceAppraisalScreen({super.key});

  @override
  _PerformanceAppraisalScreenState createState() =>
      _PerformanceAppraisalScreenState();
}

class _PerformanceAppraisalScreenState
    extends State<PerformanceAppraisalScreen> {
  final TextEditingController _employeeNameController =
  TextEditingController();
  final TextEditingController _appraisalDateController =
  TextEditingController();
  final TextEditingController _feedbackController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Appraisal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _employeeNameController,
              decoration: const InputDecoration(labelText: 'Employee Name'),
            ),
            TextField(
              controller: _appraisalDateController,
              decoration: const InputDecoration(labelText: 'Appraisal Date'),
            ),
            TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(labelText: 'Feedback'),
              maxLines: 3,
            ),
            // Add other input fields as needed

            ElevatedButton(
              onPressed: () {
                // Handle form submission and data storage
                _submitForm();
              },
              child: const Text('Submit Appraisal'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    // Retrieve data from controllers and save to the backend
    final appraisal = PerformanceAppraisal(
      employeeName: _employeeNameController.text,
      appraisalDate: _appraisalDateController.text,
      feedback: _feedbackController.text,
      // Add other relevant fields
    );

    // TODO: Save the appraisal data to the backend
    // Example: Send a request to your backend API
  }

}

class PerformanceAppraisal {
  final String employeeName;
  final String appraisalDate;
  final String feedback;
  // Add other relevant fields

  PerformanceAppraisal({
    required this.employeeName,
    required this.appraisalDate,
    required this.feedback,
    // Add other relevant fields
  });
}

