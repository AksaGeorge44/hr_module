// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceRegistrationScreen extends StatefulWidget {
  @override
  _AttendanceRegistrationScreenState createState() =>
      _AttendanceRegistrationScreenState();
}

class _AttendanceRegistrationScreenState
    extends State<AttendanceRegistrationScreen> {
      TimeOfDay? selectedCheckInTime;
  TimeOfDay? selectedCheckOutTime;

  DateTime selectedDate = DateTime.now();
  String? selectedEmployee;
  String selectedStatus = 'Present';
  List<String> employeeNames = [];
  List<Map<String, String?>> enteredAttendanceRecords = [];

  TextEditingController checkInTimeController = TextEditingController();
  TextEditingController checkOutTimeController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Fetch employee names from Firebase Firestore when the screen is loaded
    fetchEmployeeNames();
  }
  Future<void> _selectCheckInTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedCheckInTime = picked;
        checkInTimeController.text = picked.format(context);
      });
    }
  }

  Future<void> _selectCheckOutTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedCheckOutTime = picked;
        checkOutTimeController.text = picked.format(context);
      });
    }
  }

  Future<void> fetchEmployeeNames() async {
    try {
      // Access the "employees" collection in Firebase Firestore
      final employeeCollection = FirebaseFirestore.instance.collection('employees');

      // Fetch employee names
      final querySnapshot = await employeeCollection.get();
      final names = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data['name'] as String;
      }).toList();

      setState(() {
        employeeNames = names;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching employee names: $e');
      }
    }
  }

   @override
  void dispose() {
    checkInTimeController.dispose();
    checkOutTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Date Selection
              Row(
                children: <Widget>[
                  const Text('Date: '),
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            selectedDate = value;
                          });
                        }
                      });
                    },
                    child: Text('${selectedDate.toLocal()}'.split(' ')[0]),
                  ),
                ],
              ),
        
              // Employee Selection Dropdown
              Row(
                children: [
                  const Text('Select Employee: '),
                  const SizedBox(width: 100),
                  DropdownButton<String>(
                    value: selectedEmployee,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedEmployee = newValue;
                      });
                    },
                    items: employeeNames
                        .map<DropdownMenuItem<String>>((String name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(name),
                      );
                    }).toList(),
                  ),
                ],
              ),
        
              // Status Selection Dropdown
              Row(
                children: [
                  const Text('Select Status: '),
                  const SizedBox(width: 100),
                  DropdownButton<String>(
                    value: selectedStatus,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStatus = newValue ?? 'Present';
                      });
                    },
                    items: <String>['Present', 'Absent', 'Late', 'Sick Leave']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              // Check-in Time Input
// Check-in Time Input
// Check-in Time Input
// Check-in Time Input

// Check-out Time Input



        
               
        
              // Submit Button
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (selectedEmployee != null) {
                    // Check if the employee with the same name already exists in the "attendance" collection
                     final attendanceCollection = FirebaseFirestore.instance.collection('attendance');
        final existingRecord = await attendanceCollection
            .where('employeeName', isEqualTo: selectedEmployee)
            .where('date', isEqualTo: selectedDate.toLocal().toString().split(' ')[0])
            .where('check-in-time', isEqualTo: selectedCheckInTime.toString()) // Updated
            .where('check-out-time', isEqualTo: selectedCheckOutTime.toString()) // Updated
            .get();
        
                    if (existingRecord.docs.isEmpty) {
                      // Create a new attendance record
                      final attendanceRecord = {
                        'date': selectedDate.toLocal().toString().split(' ')[0],
                        'employeeName': selectedEmployee,
                        'status': selectedStatus,
                        // ignore: use_build_context_synchronously
                        'check-in-time':_selectCheckInTime(context).toString(),
                        // ignore: use_build_context_synchronously
                        'check-out-time':_selectCheckOutTime(context).toString(),
                      };
        
                      try {
                        // Add the attendance record to Firebase Firestore
                        await attendanceCollection.add({
  'date': attendanceRecord['date'] as String,
  'employeeName': attendanceRecord['employeeName'] as String,
  'status': attendanceRecord['status'] as String,
  'check-in-time': attendanceRecord['check-in-time'] as String,
  'check-out-time': attendanceRecord['check-out-time'] as String,
});
        
                        // Show a success message using a SnackBar
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Attendance Registered',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
        
                        // Optionally, you can reset the selected values to clear the form
                        setState(() {
                          selectedEmployee = null;
                          selectedStatus = 'Present';
                        });
        
                        // Add the entered record to the list
                        enteredAttendanceRecords.add(attendanceRecord);
                      } catch (e) {
                        if (kDebugMode) {
                          print('Error adding attendance record: $e');
                        }
                        // Handle any errors that might occur during the database operation
                      }
                    } else {
                      // Show an error message if the employee already has an attendance record for the selected date
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.black,
                          content: Text(
                            'An attendance record for this employee on the selected date already exists.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    }
                  } else {
                    // Handle the case where no employee is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select an employee.'),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
        
              // Display the entered records in a table
              const SizedBox(height: 50),

             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
               child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Check-in Time')),
                    DataColumn(label: Text('Check-out Time')),
                  ],
                  rows: enteredAttendanceRecords.map((record) {
                    return DataRow(cells: [
                      DataCell(Text(record['date']!)),
                      DataCell(Text(record['employeeName']!)),
                      DataCell(Text(record['status']!)),
                      DataCell(Text(record['checkInTime']??"")),
                      DataCell(Text(record['checkOutTime']??"")),
                    ]);
                  }).toList(),
                ),
             ),
        
        
        
        
            ],
          ),
        ),
      ),
    );
  }
}