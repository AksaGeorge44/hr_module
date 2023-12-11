import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditWork extends StatefulWidget {
  final String employeeId; // Pass the employee ID to this page

  EditWork({required this.employeeId});

  @override
  _EditWorkState createState() => _EditWorkState();
}

class _EditWorkState extends State<EditWork> {
void _updateEmployeeData() {
  // Define a reference to the Firestore document you want to update
  DocumentReference employeeRef = _firestore.collection('employees').doc(widget.employeeId);

  // Create a map with the new data
  Map<String, dynamic> updatedData = {
    'department': _selectedDepartment,
    'position': _positionController.text,
    'role': _selectedRole,
    'date_of_hire': _dohController.text,
    'date_of_join': _dojController.text,
    'date_of_resign': _dorController.text,
    'employee_status': _selectedStatus,
    'job_location': _joblocationController.text,
    'salary': _salaryController.text,
    'salary_start':_salaryStartDate.text,
    'salary_end':_salaryEndDate.text,
    'shift': _selectedShift,
    'ssn': _ssnController.text,
    'work_email': _workemailController.text,
    'work_phone_number': _workphoneNoController.text,
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

String _selectedStatus = 'Intern';
  String _selectedRole = 'admin';
  String _selectedShift = 'morning';
  
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _salaryStartDate=TextEditingController();
  final TextEditingController _salaryEndDate=TextEditingController();
  final TextEditingController _dohController = TextEditingController();
  final TextEditingController _workemailController = TextEditingController();
  final TextEditingController _workphoneNoController = TextEditingController();
  final TextEditingController _dojController = TextEditingController();
  final TextEditingController _ssnController = TextEditingController();
  final TextEditingController _joblocationController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _dorController=TextEditingController();
  String _selectedDepartment = 'IT';

Future<void> _selectDateofHire(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 50),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        _dohController.text = formatDate(selectedDate);
      });
    }
  }

  Future<void> _selectDateofJoin(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 50),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        _dojController.text = formatDate(selectedDate);
      });
    }
  }

  Future<void> _selectDateofResign(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(currentDate.year - 50),
        lastDate: currentDate);
    if (selectedDate != null) {
      setState(() {
        _dorController.text = formatDate(selectedDate);
      });
    }
  }
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
                _selectedDepartment = employeeData['department'];
                _positionController.text = employeeData['position'];
                _selectedRole = employeeData['role'];
                _dohController.text = employeeData['date_of_hire'];
                _dojController.text = employeeData['date_of_join'];
                _dorController.text = employeeData['date_of_resign'];
                _selectedStatus= employeeData['employee_status'];
                _joblocationController.text = employeeData['job_location'];
                _positionController.text = employeeData['position'];
                _workemailController.text = employeeData['work_email'];
                _workphoneNoController.text = employeeData['work_phone_number'];
                _salaryController.text = employeeData['salary'];
                _salaryStartDate.text=employeeData['salary_start'];
                _salaryEndDate.text=employeeData['salary_end'];
               
                _ssnController.text = employeeData['ssn'];
               

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      const Text(
                        "Work Details",
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _positionController,
                        decoration: const InputDecoration(labelText: 'Positon',
                         labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _dohController,
                        decoration: const InputDecoration(labelText: 'Date of Hire',
                         labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                       TextFormField(
                        controller: _dorController,
                        decoration: const InputDecoration(labelText: 'Date of Resign',
                         labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _dojController,
                        decoration: const InputDecoration(
                          labelText: 'Date of Join:',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      TextFormField(
                        controller: _joblocationController,
                        decoration: const InputDecoration(
                          labelText: 'Job Location:',
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
                              controller: _salaryController,
                              decoration: const InputDecoration(
                                labelText: 'Salary:',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 13,),
                          Expanded(
                            child: TextFormField(
                              controller: _ssnController,
                              decoration: const InputDecoration(
                                labelText: 'SSN:',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                       TextFormField(
                        controller: _salaryStartDate,
                        decoration: const InputDecoration(labelText: 'Salary start:',
                         labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _salaryEndDate,
                        decoration: const InputDecoration(
                          labelText: 'Salary end:',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 35,),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _workemailController,
                              decoration: const InputDecoration(
                                labelText: 'Work Email:',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        
                         
                        ],
                      ),
                      const SizedBox(height: 20,),
                       TextFormField(
                         controller: _workphoneNoController,
                         decoration: const InputDecoration(
                           labelText: 'Work Phoneno:',
                           labelStyle: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         keyboardType: TextInputType.number,
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
