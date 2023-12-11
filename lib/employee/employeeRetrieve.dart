import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_module/employee/employeeDetail.dart';

class EmployeeRetrieveScreen extends StatefulWidget {
  @override
  State<EmployeeRetrieveScreen> createState() => _EmployeeRetrieveScreenState();
}

class _EmployeeRetrieveScreenState extends State<EmployeeRetrieveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(13),
        
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('employees').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No employees found.'));
            }
            final employees = snapshot.data!.docs;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: 
              DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('ID'),
                  ),
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(label: Text('Designation')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Department')),
                  DataColumn(label: Text('Shift')),

                ],
                rows: employees.map((doc) {
                  final employeeData = doc.data() as Map<String, dynamic>;
                  final employeeId = employeeData['employee_id'] ?? 'N/A';
                  final employeeName = employeeData['full_name'] ?? 'N/A';
                  final employeeDesignation=employeeData['position']??'N/A';
                  final employeeStatus=employeeData['employee_status']??'N/A';
                  final employeeDepartment=employeeData['department']??'N/A';
                  final employeeShift=employeeData['shift']??'N/A';

                  return DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(employeeId),
                        onTap: () {
                          navigateToEmployeeDetails(doc, employeeData);
                        },
                      ),
                      DataCell(
                        Text(employeeName),
                        onTap: () {
                          navigateToEmployeeDetails(doc, employeeData);
                        },
                      ),
                      DataCell(Text(employeeDesignation),),
                      DataCell(Text(employeeStatus),),
                      DataCell(Text(employeeDepartment),),
                      DataCell(Text(employeeShift),)
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  void navigateToEmployeeDetails(DocumentSnapshot doc, Map<String, dynamic> employeeData) {
    if (doc.exists) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeDetailScreen(doc, employeeData: employeeData),
        ),
      );
    } else {
      if (kDebugMode) {
        print('Employee document not found.');
      }
    }
  }
}
