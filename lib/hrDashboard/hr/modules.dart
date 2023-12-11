import 'package:flutter/material.dart';
import 'package:hr_module/dashboard/onboarding.dart';
import 'package:hr_module/hrDashboard/ExpenseClaim/expenseClaim.dart';
import 'package:hr_module/job/recruitment.dart';
import 'package:hr_module/hrDashboard/salary/salaryCalculator.dart';

import '../employeeMangmnt.dart';
import '../../employee/employeeRetrieve.dart';

class Modules extends StatefulWidget {
  const Modules({super.key});

  @override
  State<Modules> createState() => _ModulesState();
}

class _ModulesState extends State<Modules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Functions"),
      ),
      body:   SingleChildScrollView(
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: const Text('Employee Information Sheet'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  const EmployeeListScreen()));
                  },
                ),
                ListTile(
                  title: const Text('Onboarding'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const JobListScreen()));

                  },
                ),
                ListTile(
                  title: const Text('Onboarding Checklist'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const OnboardingChecklistScreen()));

                  },
                ),
                ListTile(
                  title: const Text("Employee Records"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EmployeeRetrieveScreen()));

                  },
                ),
                ListTile(
                  title: const Text('Performance Appraisal'),
                  onTap: () {


                  },
                ),
                ListTile(
                  title: const Text("Time and Attendance Tracking"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Employee Leave Request Form"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Training and Development Plan'),
                  onTap: () {
                  },
                ),
                ListTile(
                  title: const Text("Termination Checklist"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Employee Claim"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ExpenseClaimForm()));

                  },
                ),
                ListTile(
                  title: const Text('HR Policy Acknowledgment Form'),
                  onTap: () {
                  },
                ),
                ListTile(
                  title: const Text("Job Description"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Employee Handbook"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Compensation and Benefits Summary"),
                  onTap: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SalaryCalculatorScreen()));

                  },
                ),
                ListTile(
                  title: const Text('Health and Safety Guidelines'),
                  onTap: () {
                  },
                ),
                ListTile(
                  title: const Text("Diversity and Inclusion Statement"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Confidentiality Agreement"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Grievance Form"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                      "Performance Improvement Plan (PIP) Template"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Succession Planning Template"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Offboarding Checklist"),
                  onTap: () {},
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
