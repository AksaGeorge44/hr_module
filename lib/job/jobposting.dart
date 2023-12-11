import 'package:flutter/material.dart';




class JobPostingPage extends StatefulWidget {
  const JobPostingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JobPostingPageState createState() => _JobPostingPageState();
}

class _JobPostingPageState extends State<JobPostingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String jobTitle = '';
  String jobDescription = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Posting Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Post a Job Vacancy',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a job title';
                  }
                  return null;
                },
                onSaved: (value) {
                  jobTitle = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a job description';
                  }
                  return null;
                },
                maxLines: 5,
                onSaved: (value) {
                  jobDescription = value!;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _submitJob();
                },
                child: const Text('Post Job Vacancy'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitJob() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Here, you can implement the logic to send the job details to your backend
      // and handle the job posting process.

      // For simplicity, we will just display the job details for now.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Job Vacancy Posted'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Job Title: $jobTitle'),
                Text('Job Description: $jobDescription'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
}
