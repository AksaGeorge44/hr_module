import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_module/employee/employeeDetail.dart';

class CandidateRetrieveScreen extends StatefulWidget {
  const CandidateRetrieveScreen({super.key});

  @override
  State<CandidateRetrieveScreen> createState() => _CandidateRetrieveScreenState();
}

class _CandidateRetrieveScreenState extends State<CandidateRetrieveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Candidate List"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(13),

        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('candidates').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No candidates found.'));
            }
            final candidates = snapshot.data!.docs;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:
              DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Date'),
                  ),
                  DataColumn(label: Text('Email ID')),
                  DataColumn(label: Text('Phone no')),
                  DataColumn(label: Text('Interviewer')),
                  DataColumn(label: Text('Position')),
                  DataColumn(label: Text('Round')),
                  DataColumn(label: Text('Time')),



                ],
                rows: candidates.map((doc) {
                  final candidateData = doc.data() as Map<String, dynamic>;
                  final candidateName = candidateData['candidateName'] ?? 'N/A';
                  final interviewDate = candidateData['interviewDate'] ?? 'N/A';
                  final emailId=candidateData['emailId']??'N/A';
                  final phoneNo=candidateData['phoneNo']??'N/A';
                  final interviewer=candidateData['interviewer']??'N/A';
                  final position=candidateData['position']??'N/A';
                  final round=candidateData['round']??'N/A';
                  final time=candidateData['time']??'N/A';


                  return DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(candidateName),
                        onTap: () {
                          navigateToCandidateDetails(doc, candidateData);
                        },
                      ),
                      DataCell(
                        Text(interviewDate),
                        onTap: () {
                          navigateToCandidateDetails(doc, candidateData);
                        },
                      ),

                      DataCell(
                        Text(emailId),

                      ),
                      DataCell(
                        Text(phoneNo),

                      ),
                      DataCell(
                        Text(interviewer),

                      ),
                      DataCell(
                        Text(position),

                      ),
                      DataCell(
                        Text(round),

                      ),
                      DataCell(
                        Text(time),

                      )
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

  void navigateToCandidateDetails(DocumentSnapshot doc, Map<String, dynamic> candidateData) {
    if (doc.exists) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeDetailScreen(doc, employeeData: candidateData),
        ),
      );
    } else {
      if (kDebugMode) {
        print('Employee document not found.');
      }
    }
  }
}
