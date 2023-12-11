import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_module/job/recruitment.dart';

import 'JobLists.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({Key? key}) : super(key: key);

  @override
  _PostJobScreenState createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController responsibilityController=TextEditingController();
  TextEditingController salaryController=TextEditingController();
  TextEditingController benefitsController=TextEditingController();
  TextEditingController jobtypeController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController experienceController=TextEditingController();
  TextEditingController skillsController=TextEditingController();
  TextEditingController scheduleController=TextEditingController();
  TextEditingController relocateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    responsibilityController.clear();
    salaryController.clear();
    benefitsController.clear();
    jobtypeController.clear();
    educationController.clear();
    experienceController.clear();
    skillsController.clear();
    scheduleController.clear();
    relocateController.clear();
    phoneController.clear();
  }

  Future<void> _postJob() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        responsibilityController.text.isEmpty ||
        salaryController.text.isEmpty ||
        benefitsController.text.isEmpty ||
        jobtypeController.text.isEmpty ||
        educationController.text.isEmpty ||
        experienceController.text.isEmpty ||
        skillsController.text.isEmpty ||
        scheduleController.text.isEmpty ||
        relocateController.text.isEmpty ||
        phoneController.text.isEmpty) {
      if (kDebugMode) {
        print("Please fill in all fields");
      }
      return;
    }

    try {
      String title = titleController.text;
      String description = descriptionController.text;
      String salary = salaryController.text;
      String benefits = benefitsController.text;
      String jobtype = jobtypeController.text;
      String education = educationController.text;
      String experience = experienceController.text;
      String schedule = scheduleController.text;
      String relocate = relocateController.text;
      String phoneno = phoneController.text;
      String responsibilities = responsibilityController.text;
      String skills = skillsController.text;

      List<String> responsibilityList = responsibilities.split('\n');
      List<String> skillsList = skills.split('\n');
      List<String> benefitsList = benefits.split('\n');

      await FirebaseFirestore.instance.collection('jobs').add({
        'title': title,
        'description': description,
        'responsibilities': responsibilityList,
        'benefits': benefitsList,
        'skills': skillsList,
        'phoneno': phoneno,
        'place': relocate,
        'schedule': schedule,
        'experience': experience,
        'education': education,
        'jobtype': jobtype,
        'salary': salary,
      });
      Navigator.pop(context, Job(title: title, description: description));

      if (kDebugMode) {
        print("Job posted successfully");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error posting job: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              const Center(child: Text("Add New Job Post", style: TextStyle(
                  color: Colors.black,
                fontSize: 26
              ),)),
              Padding(
                padding: const EdgeInsets.only(left: 1100),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const JobListsScreen()));
                  },
                  child: const Text('View Job Listings'),
                ),
              ),
              const SizedBox(height: 30,),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    labelText: 'Job Title:',
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return 'Please enter a valid name with only letters and spaces.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Job Description:',
                    labelStyle: TextStyle(
                    color: Colors.black
                ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return 'Please enter a valid name with only letters and spaces.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50,),
              TextFormField(
                controller: skillsController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(labelText: 'Skills Required:',
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return 'Please enter a valid name with only letters and spaces.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: responsibilityController,
                maxLines: null, // Allows for multiline input
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "Roles & Responsibilities:",
                    labelStyle: TextStyle(
                    color: Colors.black
                ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return 'Please enter a valid name with only letters and spaces.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 50,),
              TextFormField(
                controller: jobtypeController,
                decoration: const InputDecoration(
                    labelText: 'Job Type:',
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return 'Please enter a valid name with only letters and spaces.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50,),
              TextFormField(
                controller: scheduleController,
                decoration: const InputDecoration(
                    labelText: 'Schedule:',
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return 'Please enter a valid name with only letters and spaces.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50,),
              TextFormField(
                controller: relocateController,
                decoration: const InputDecoration(
                    labelText: 'Relocate/Commute to:',
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),

                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }

                },
              ),
              const SizedBox(height: 50,),
              TextFormField(
                controller: educationController,
                decoration: const InputDecoration(labelText: 'Education:',
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return 'Please enter a valid name with only letters and spaces.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50,),
              TextFormField(
                controller: experienceController,
                decoration: const InputDecoration(labelText: 'Experience:',
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }

                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: salaryController,
                decoration: const InputDecoration(
                  labelText: "Pay:",
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }

                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: benefitsController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "Benefits:",
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return 'Please enter a valid name with only letters and spaces.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50,),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                    labelText: 'Speak with the employer:',
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a 10-digit number.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: (){
                  _postJob();
                  clearForm();

                },


                child: const Text('Post Job'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
