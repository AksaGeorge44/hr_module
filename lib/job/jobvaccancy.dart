import 'package:flutter/material.dart';
import 'package:hr_module/job/jobposting.dart';
import 'package:url_launcher/url_launcher.dart';

class JobVacanciesSection extends StatefulWidget {
  const JobVacanciesSection({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JobVacanciesSectionState createState() => _JobVacanciesSectionState();
}

class _JobVacanciesSectionState extends State<JobVacanciesSection> {

List<JobVacancy> jobVacancies = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
         appBar: AppBar(
        title: const Text('Job Posting Page'),
      ),

        body:  Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Job Vaccancies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _launchLinkedIn,
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2hM-Oqitw2GhTwPQpfxvG-F-0xSgMO_l2vg&usqp=CAU",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    GestureDetector(
                    onTap: _launchIndeed,
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Indeed_logo.svg/2560px-Indeed_logo.svg.png',
                      height: 50,
                      width: 50,
                    )),
                    const SizedBox(width: 10,),
                GestureDetector(
                    onTap: _launchNaukri,
                    child: Image.network(
                      'https://play-lh.googleusercontent.com/igpy4PR5DK9nVWIVeJ9oA40GQT-fOYgTeD2XGs9Mp1jD9r_pzYxXc7uWj82o-yx1jJE',
                      height: 50,
                      width: 50,
                    )),
          
                  ],
                ),

                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const JobPostingPage()));
                  },
                  child: const Text('Post New Job Vacancy'),
                ),
          
          
                const SizedBox(height: 16),
                if (jobVacancies.isNotEmpty)
                  _buildJobVacancyList()
                else
                  const Text('No job vacancies available.'),
              ],
            ),
          ),
        ),
      ),
      
      
      
    );
    
  }


  Widget _buildJobVacancyList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: jobVacancies.map((job) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(job.title),
            subtitle: Text('${job.department} | ${job.qualifications}'),
            trailing: ElevatedButton(
              onPressed: () => _viewJobApplications(job),
              child: const Text('View Applications'),
            ),
          ),
        );
      }).toList(),
    );
  }



  void _viewJobApplications(JobVacancy job) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Applications for ${job.title}'),
          content: const Text('Implement application viewing here.'),
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

void _launchLinkedIn() async {
  const linkedInURL =
      'https://www.linkedin.com'; // Replace with the actual LinkedIn URL
  if (await canLaunch(linkedInURL)) {
    await launch(linkedInURL);
  } else {
    throw 'Could not launch LinkedIn URL';
  }
}

void _launchIndeed() async {
  const indeedURL = 'https://in.indeed.com';
  if (await canLaunch(indeedURL)) {
    await launch(indeedURL);
  } else {
    throw "Could not launch Indeed URL";
  }
}

void _launchNaukri() async {
  const naukriURL = 'https://www.naukri.com';
  if (await canLaunch(naukriURL)) {
    await launch(naukriURL);
  } else {
    throw "Could not launch Naukri URL";
  }
}

class JobVacancy {
  final String title;
  final String department;
  final String qualifications;

  JobVacancy({
    required this.title,
    required this.department,
    required this.qualifications,
  });
}
