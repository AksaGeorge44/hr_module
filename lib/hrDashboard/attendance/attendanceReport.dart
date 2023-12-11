import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AttendanceReportScreen extends StatefulWidget {
  final String employeeName;

  const AttendanceReportScreen(this.employeeName, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AttendanceReportScreenState createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  List<Map<String, String>> attendanceRecords = [];

  @override
  void initState() {
    super.initState();
    // Fetch attendance records for the specified employee
    fetchAttendanceRecords();
  }

  Future<void> fetchAttendanceRecords() async {
    try {
      // Access the "attendance" collection in Firebase Firestore
      final attendanceCollection = FirebaseFirestore.instance.collection('attendance');

      // Query attendance records for the selected employee
      final querySnapshot = await attendanceCollection
          .where('employeeName', isEqualTo: widget.employeeName)
          .get();

      final records = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'date': data['date'] as String,
          'status': data['status'] as String,
        };
      }).toList();

      setState(() {
        attendanceRecords = records;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching attendance records: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Report for ${widget.employeeName}'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Employee Name: ${widget.employeeName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: attendanceRecords.length,
              itemBuilder: (context, index) {
                final record = attendanceRecords[index];
                return ListTile(
                  title: Text('Date: ${record['date']}'),
                  subtitle: Text('Status: ${record['status']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
