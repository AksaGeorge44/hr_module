
import 'package:flutter/material.dart';
import 'package:hr_module/job/JobLists.dart';
import 'package:hr_module/job/PostJob.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    void _showJobDetails(Job job) {
      // Display the details of the job, for example, in a Dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(job.title),
            content: Text(job.description),
            // ... other fields ...
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Job Listings'),
        ),
        body: Column(
           children: [
             const Text("Recruiting"),
             Row(
               children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [

                           const SizedBox(height: 20,),
                           const SectionHeader(title: 'Recruitment'),
                           const SizedBox(height: 10,),
                           ElevatedButton(
                             onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostJobScreen()));
                             },
                             child: const Text('Add Job Postings'),
                           ),
                           const SizedBox(height: 10,),
                           ElevatedButton(
                             onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const JobListsScreen()));
                             },
                             child: const Text('Manage Job Postings'),
                           ),
                           const SizedBox(height: 16.0),
                           ElevatedButton(
                             onPressed: () {
                             },
                             child: const Text('View Candidates'),
                           ),

                           const SizedBox(height: 24.0),
                           const SectionHeader(title: 'Onboarding'),
                           const SizedBox(height: 10,),
                           ElevatedButton(
                             onPressed: () {

                             },
                             child: const Text('Manage Onboarding Tasks'),
                           ),

                           const SizedBox(height: 16.0),
                           ElevatedButton(
                             onPressed: () {

                             },
                             child: const Text('Employee Directory'),
                           ),

                           ElevatedButton(
                             onPressed: () async {
                               // Navigate to the PostJobScreen and wait for the result
                               final result = await Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => const PostJobScreen()),
                               );

                               // Check if a new job was posted
                               if (result != null && result is Job) {
                                 // Display the details of the newly posted job
                                 _showJobDetails(result);
                               }
                             },
                             child: const Text('Add Job Postings'),
                           ),

                         ],
                       ),
                     ),
                   ],
                 ),

               ],
             ),

  ],

),


      );
  }
}

class Job {
  late final String title;
  late final String description;

  Job({required this.title, required this.description});
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}