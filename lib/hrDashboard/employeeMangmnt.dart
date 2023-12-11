import 'package:flutter/material.dart';
import 'package:hr_module/employee/addEmployee.dart';
import 'package:hr_module/hrDashboard/admin/addExpense.dart';
import 'package:hr_module/hrDashboard/admin/addInterviewer.dart';
import 'package:hr_module/hrDashboard/admin/addRound.dart';
import 'package:hr_module/hrDashboard/attendance/attendanceReport.dart';
import 'package:hr_module/hrDashboard/attendance/attendanceScreen.dart';
import 'package:hr_module/hrDashboard/admin/department.dart';
import 'package:hr_module/hrDashboard/admin/designation.dart';
import 'package:hr_module/hrDashboard/attendance/employeeAttendence.dart';
import 'package:hr_module/employee/employeeRetrieve.dart';
import 'package:hr_module/hrDashboard/admin/roles.dart';


class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Management'),
      ),
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddEmployee()));
              },
              child: const Text('Register Employee'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EmployeeRetrieveScreen(),
                  ),
                );
              },
              child: const Text('Retrieve Employee Details'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const RoundPage()));
              },
              child: const Text('Add Round'),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const AddExpensePage()));
              },
              child: const Text('Add Expense'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const InterviewerPage()));
              },
              child: const Text('Add Interviewer'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  AttendanceScreen()));
              },
              child: const Text('Attendance'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RolePage(),
                  ),
                );
              },
              child: const Text('Roles and Permissions'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DesignationPage(),
                  ),
                );
              },
              child: const Text('Designation'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DepartmentPage(),
                  ),
                );
              },
              child: const Text('Department'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceRegistrationScreen(),
                  ),
                );
              },
              child: const Text('Employee Attendance'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AttendanceReportScreen("ab"),
                  ),
                );
              },
              child: const Text('Attendance Report'),
            ),
          ],
        ),
      ),
    );
  }
}
