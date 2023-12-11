import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<DateTime> punchInTimes = [];
  List<DateTime> punchOutTimes = [];
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      bool isBiometricAvailable = await _localAuth.canCheckBiometrics;

      if (isBiometricAvailable) {
        bool isBiometricAuthorized = await _localAuth.authenticate(
          localizedReason: 'Authenticate using biometrics',
        );

        if (isBiometricAuthorized) {
          punchInTimes.add(DateTime.now());
          setState(() {});
          return true; // Biometric authentication successful
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Biometric authentication error: $e');
      }
    }

    return false; // Biometric authentication failed or not available
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        punchInTimes.add(DateTime.now());
                        setState(() {});
                      },
                      child: const Text(
                        'Punch In',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: FloatingActionButton(
                        backgroundColor: Colors.blue,
                        onPressed: () {
                          punchInTimes.add(DateTime.now());
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.punch_clock,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 35,
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            if (punchInTimes.length > punchOutTimes.length) {
                              punchOutTimes.add(DateTime.now());
                              setState(() {});
                            }
                          },
                          child: const Text(
                            'Punch Out',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: FloatingActionButton(
                            backgroundColor: Colors.blue,
                            onPressed: () {
                              if (punchInTimes.length > punchOutTimes.length) {
                                punchOutTimes.add(DateTime.now());
                                setState(() {});
                              }
                            },
                            child: const Icon(
                              Icons.punch_clock,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),

            const SizedBox(height: 50),
            const Text(
              'Punch-In and Punch-Out Entries:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: punchInTimes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("\n"+
                        'Punch In: ${formatDateTime(punchInTimes[index])}'),
                    subtitle: index < punchOutTimes.length
                        ? 
                        Text( "\n"+'Punch Out: ${formatDateTime(punchOutTimes[index])}')
                        : const Text('Punch Out: N/A'),
                  );
                },
              ),
            ),

            // GestureDetector(
            //   onTap: () async {
            //     bool isAuthenticated = await authenticate();
            //     if (isAuthenticated) {
            //       setState(() {});
            //     }
            //   },
            //   child: Image.network(
            //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzVxhPqpwBjPo0O2VNB7be-VVEbzdqmK2YsA&usqp=CAU",
            //   ),
            // ),
            const SizedBox(height: 20),
            const Text(
              'Total Working Hours:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' ${calculateWorkingHours()} hours',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.toLocal()}".split('.').first;
  }

  String calculateWorkingHours() {
    Duration totalDuration = const Duration();
    for (int i = 0; i < punchInTimes.length; i++) {
      if (i < punchOutTimes.length) {
        totalDuration += punchOutTimes[i].difference(punchInTimes[i]);
      }
    }
    int hours = totalDuration.inHours;
    int minutes = totalDuration.inMinutes.remainder(60);
    return '$hours hours $minutes minutes';
  }
}

