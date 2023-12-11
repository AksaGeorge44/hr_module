import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditEducation extends StatefulWidget {
  final String employeeId; // Pass the employee ID to this page

  const EditEducation({super.key, required this.employeeId});

  @override
  _EditEducationState createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {
void _updateEmployeeData() {
  DocumentReference employeeRef = _firestore.collection('employees').doc(widget.employeeId);

  Map<String, dynamic> updatedData = {
    'education': _selectedEducation,
    'course': _courseController.text,
    'college_name': _collegeController.text,
    'course_start': _courseStartController.text,
    'course_end': _courseEndController.text,
    'marks': _marksController.text,
    'any_other_certificates': _anyotherController.text,
  };

  employeeRef.update(updatedData).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Employee data updated successfully'),
    ));
      Navigator.of(context).pop();

  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error updating employee data: $error'),
    ));
  });
}
  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedEducation = 'PG';

  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _courseStartController = TextEditingController();
  final TextEditingController _courseEndController = TextEditingController();
  final TextEditingController _marksController = TextEditingController();
  final TextEditingController _anyotherController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Employee Details"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: FutureBuilder<DocumentSnapshot>(
            future:
                _firestore.collection('employees').doc(widget.employeeId).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              if (snapshot.hasData) {
                Map<String, dynamic> employeeData =
                    snapshot.data!.data() as Map<String, dynamic>;
                _selectedEducation= employeeData['education'];
                _courseController.text = employeeData['course'];
                _collegeController.text = employeeData['college_name'];
                _marksController.text = employeeData['marks'];
                _courseStartController.text = employeeData['course_start'];
                _courseEndController.text = employeeData['course_end'];
                _anyotherController.text = employeeData['any_other_certificates'];

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "Educational Details",
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20,),
                       DropdownButtonFormField<String>(
                        value: _selectedEducation,
                        items: [
                          'PG', 'UG', 'Diploma', '12', '10', 'Other',
                        ]
                            .map((education) => DropdownMenuItem(
                                  value: education,
                                  child: Text(education),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedEducation = value!;
                            _courseController.clear();
                            _collegeController.clear();
                            _courseStartController.clear();
                            _courseEndController.clear();
                            _marksController.clear();
                            _anyotherController.clear();
                          });
                        },
                        decoration: const InputDecoration(
                            labelText: "Education",
                            labelStyle: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _courseController,
                        decoration: const InputDecoration(labelText: 'Course',
                         labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                        
                        
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _collegeController,
                        decoration: const InputDecoration(labelText: 'College',
                         labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _marksController,
                        decoration: const InputDecoration(
                          labelText: 'Marks',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      TextFormField(
                        controller: _courseStartController,
                        decoration: const InputDecoration(
                          labelText: 'Course Start',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 25,),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _courseEndController,
                              decoration: const InputDecoration(
                                labelText: 'Course End',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 13,),
                        ],
                      ),
                     const SizedBox(height: 20,),
                        TextFormField(
                          controller: _anyotherController,
                          decoration: const InputDecoration(
                            labelText: 'Any Other Certificates',
                            labelStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(height: 20,),
                    ElevatedButton(
                   onPressed: () {
                     _updateEmployeeData(); // Call the method to update the data
                         } ,
                    child: const Text('Save Changes'),
                  ),
                    ],
                  ),
                );
              }
              return const Text("No data available");
            },
          ),
        ),
      ),
    );
  }
}
