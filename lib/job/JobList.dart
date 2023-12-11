import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

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
          return const CircularProgressIndicator();
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var job = snapshot.data!.docs[index];
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Card(
                child: ListTile(
                  title: Text(job['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description: ${job['description']}',),
                      const SizedBox(height: 5,),
                      Text('Skills:${job['skills']}'),
                      const SizedBox(height: 5,),
                      Text('Responsibility: ${job['responsibilities']}'),
                      const SizedBox(height: 5,),
                      Text('JobType:${job['jobtype']}'),
                      const SizedBox(height: 5,),
                      Text('Phoneno:${job['phoneno']}'),
                      const SizedBox(height: 5,),
                      Text('Schedule:${job['schedule']}'),
                      const SizedBox(height: 5,),
                      Text('Experience:${job['experience']}'),
                      const SizedBox(height: 5,),
                      Text('Education:${job['education']}'),
                      const SizedBox(height: 5,),
                      Text('Place:${job['place']}'),
                      const SizedBox(height: 5,),
                      Text('Salary: ${job['salary']}'),
                      const SizedBox(height: 5,),
                      Text('Benefits: ${job['benefits']}'),
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
