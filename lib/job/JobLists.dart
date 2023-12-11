import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobListsScreen extends StatelessWidget {
  const JobListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Listings'),
      ),
      body: _buildJobList(),
    );
  }

  Widget _buildJobList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var job = snapshot.data!.docs[index];
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    job['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Description: ${job['description']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Skills: ${job['skills']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Responsibility: ${job['responsibilities']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Job Type: ${job['jobtype']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Phone: ${job['phoneno']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Schedule: ${job['schedule']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Experience: ${job['experience']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Education: ${job['education']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Location: ${job['place']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Salary: ${job['salary']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Benefits: ${job['benefits']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
