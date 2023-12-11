import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditJobScreen extends StatefulWidget {
  final String jobId;
  final String initialTitle;
  final String initialDescription;

  EditJobScreen({
    required this.jobId,
    required this.initialTitle,
    required this.initialDescription,
  });

  @override
  _EditJobScreenState createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initialTitle);
    descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  Future<void> _updateJob() async {
    // Update the job in Firebase
    await FirebaseFirestore.instance.collection('jobs').doc(widget.jobId).update({
      'title': titleController.text,
      'description': descriptionController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Job posting updated'),
      ),
    );

    // Close the edit screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Job Posting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Job Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Job Description'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateJob,
              child: const Text('Update Job Posting'),
            ),
          ],
        ),
      ),
    );
  }
}
