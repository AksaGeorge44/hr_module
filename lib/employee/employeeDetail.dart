
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_module/employee/editEducation.dart';
import 'package:hr_module/employee/editPerson.dart';
import 'package:hr_module/employee/editWork.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final Map<String, dynamic> employeeData;
  final DocumentSnapshot employeeSnapshot; // Use DocumentSnapshot

  const EmployeeDetailScreen(
    this.employeeSnapshot, {
    Key? key,
    required this.employeeData,
  });

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  Map<String, dynamic> _editedEmployeeData = {};
  final bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _editedEmployeeData =
        widget.employeeSnapshot.data() as Map<String, dynamic>;
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this employee?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                final employeeId = widget.employeeSnapshot.id;
                final firestore = FirebaseFirestore.instance;
                await firestore
                    .collection('employees')
                    .doc(employeeId)
                    .delete();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Details"),
        actions: const <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text(
                      "Personal Details",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    const SizedBox(width: 50,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPerson(
                                employeeId: widget.employeeSnapshot.id),
                          ),
                        );
                      },
                      child: const Icon(Icons.edit),
                    ),
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: _showDeleteConfirmationDialog,
                      child: const Icon(Icons.delete),
                    ),
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.download),
                    ),
                  ],
                ),
              ),

              DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      'Field',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Value',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
                rows: [
                  buildDataRow("Full Name", 'full_name', "Full Name"),
                  buildDataRow("Emp ID", 'employee_id', "Emp ID"),
                  buildDataRow("Address", 'address', "Address"),
                  buildDataRow('Aadhaar no', 'aadhaar_no', "Aadhaar no"),
                  buildDataRow("Email", 'email', "Email"),
                  buildDataRow("Date of Birth", 'dob', "Date of Birth"),
                  buildDataRow("Username", 'username', "Username"),
                  buildDataRow("Password", 'password', "Password"),

                  buildDataRow("Age", 'age', "Age"),
                  buildDataRow("Gender", 'gender', "Gender"),
                  buildDataRow("Nationality", 'nationality', "Nationality"),
                  buildDataRow("Phone no", 'phone_no', "Phone no"),
                  buildDataRow("Emergency no", 'emergency_no', "Emergency no"),

                  buildDataRow("Pincode", 'pincode', "Pincode"),
                  buildDataRow("state", 'state', "State"),
                  buildDataRow("District", 'district', "District"),

                  buildDataRow("Place", 'place', "Place"),
                  buildDataRow("Blood Group", 'blood_group', "Blood Group"),
                  buildDataRow(
                      "Marital Status", 'marital_status', "Marital status"),
                  buildDataRow("Spouse name", 'spouse_name', "Spouse name"),
                  // Add more personal details rows here
                ],
              ),
              // Work Details Table
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text(
                      "Work Details",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditWork(
                                employeeId: widget.employeeSnapshot.id),
                          ),
                        );
                      },
                      child: const Icon(Icons.edit),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.download),
                    ),
                  ],
                ),
              ),
              DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      'Field',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Value',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
                rows: [
                  buildDataRow("Department", 'department', "Department"),
                  buildDataRow("Position", 'position', "Position"),
                  buildDataRow("Role", 'role', "Role"),

                  buildDataRow("Date of Hire", 'date_of_hire', "Date of Hire"),
                  buildDataRow("Date of Join", 'date_of_join', "Date of Join"),
                  buildDataRow(
                      "Date of Resign", 'date_of_resign', "Date of Resign"),

                  buildDataRow(
                      "Employee status", 'employee_status', "Employee Status"),
                  buildDataRow("Job location", 'job_location', "Job location"),

                  buildDataRow("Salary", 'salary', "Salary"),
                  buildDataRow("Salary start", 'salary_start', "Salary start"),
                  buildDataRow("Salary end", "salary_end", "Salary end"),
                  buildDataRow("Shift", 'shift', "Shift"),
                  buildDataRow("ssn", 'ssn', "SSN"),
                  buildDataRow("work email", 'work_email', "Work Email"),
                  buildDataRow(
                      "work phoneno", 'work_phone_number', "Work Phone no"),

                  // Add more educational details rows here
                ],
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text(
                      "Educatonal Details",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50,),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditEducation(
                                  employeeId: widget.employeeSnapshot.id),
                            ),
                          );
                        },
                        child: const Icon(Icons.edit)),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.download),
                    ),
                  ],
                ),
              ),
              // Educational Details Table
              DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      'Field',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Value',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
                rows: [
                  buildDataRow("Education", 'education', "Education"),
                  buildDataRow("Course", 'course', "Course"),
                  buildDataRow("College", 'college_name', "College Name"),
                  buildDataRow("Course start", 'course_start', "Course Start"),
                  buildDataRow("Course end", 'course_end', "Course End"),

                  buildDataRow("Marks", 'marks', "Marks"),
                  buildDataRow("Any Other Certificates",
                      'any_other_certificates', "Any Other Certificates"),
                  buildDataRow("work email", 'work_email', "Email"),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow buildDataRow(String field, String fieldName, String labelText) {
    return DataRow(
      cells: [
        DataCell(Text(labelText)),
        DataCell(
          _isEditing
              ? TextFormField(
                  initialValue: _editedEmployeeData[fieldName],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (text) {
                    setState(() {
                      _editedEmployeeData[fieldName] = text;
                    });
                  },
                  validator: (text) {
                    if (fieldName == 'employee_id') {
                      if (text == null || text.isEmpty) {
                        return 'Employee ID is required';
                      }
                    }
                    return null;
                  },
                )
              : Text(_editedEmployeeData[fieldName]),
        ),
      ],
    );
  }
}
