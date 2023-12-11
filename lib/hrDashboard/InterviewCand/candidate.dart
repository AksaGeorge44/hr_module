import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hr_module/hrDashboard/InterviewCand/candidateView.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../dashboard/widgets/email.dart';

class InterviewReminderScreen extends StatefulWidget {
  const InterviewReminderScreen({super.key});

  @override
  State<InterviewReminderScreen> createState() => _InterviewReminderScreenState();
}

class _InterviewReminderScreenState extends State<InterviewReminderScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Candidate'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: InterviewForm(),
      ),
    );
  }
}

class InterviewForm extends StatefulWidget {
  const InterviewForm({super.key});

  @override
  _InterviewFormState createState() => _InterviewFormState();
}

class _InterviewFormState extends State<InterviewForm> {
  bool _showDialog = false;

  @override
  void initState() {
    super.initState();
    _fetchPositions();
    _fetchInterviewers();
    _fetchRounds();
  }

  final TextEditingController round = TextEditingController();
  final TextEditingController candidateNameController = TextEditingController();

  TextEditingController emailid = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  final TextEditingController _doiController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController position = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String date = '';

  String _round = 'Select Round';
  String _position = 'developer';
  String _interviewer = 'Select Position';

  TimeOfDay? time;

  List<String> _roundsList = [];
  List<String> _positionsList = [];
  List<String> _interviewersList = [];


  Future<void> _fetchRounds() async {
    try {
      final querySnapshot = await _firestore.collection('rounds').get();
      _roundsList = querySnapshot.docs
          .map((doc) =>
          (doc.data() as Map<String, dynamic>)['round'].toString())
          .toList();
      if (_roundsList.isNotEmpty) {
        _round = _roundsList[0]; // Set the first item as default
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching round list: $e');
      }
    }
  }

  Future<void> _fetchPositions() async {
    try {
      final querySnapshot = await _firestore.collection('positions').get();
      _positionsList = querySnapshot.docs
          .map((doc) =>
          (doc.data() as Map<String, dynamic>)['position'].toString())
          .toList();
      if (_positionsList.isNotEmpty) {
        _position = _positionsList[0]; // Set the first item as default
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching positions: $e');
      }
    }
  }

  Future<void> _fetchInterviewers() async {
    try {
      final querySnapshot = await _firestore.collection('interviewers').get();
      _interviewersList = querySnapshot.docs
          .map((doc) =>
          (doc.data() as Map<String, dynamic>)['interviewer'].toString())
          .toList();
      if (_interviewersList.isNotEmpty) {
        _interviewer = _interviewersList[0]; // Set the first item as default
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching positions: $e');
      }
    }
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day
        .toString().padLeft(2, '0')}';
  }

  void _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 100),
      lastDate: DateTime(currentDate.year + 100),
    );

    if (selectedDate != null) {
      setState(() {
        _doiController.text = formatDate(selectedDate);

        final DateTime now = DateTime.now();
      });
    }
  }

  Future<void> _selectDateofInterview(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 50),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        _doiController.text = formatDate(selectedDate);
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        time = pickedTime;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const CandidateRetrieveScreen()));

                  },
                      child: const Text("View Candidates"))
                ],
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: candidateNameController,
                decoration: const InputDecoration(
                    labelText: 'Candidate Name:',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    )
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the candidate name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _doiController,

                onTap: () {
                  _selectDate(context);
                },
                decoration: const InputDecoration(
                  labelText: 'Interview Date:',
                  labelStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a  value.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
            TextFormField(
              controller: emailid, // Use a TextEditingController to capture the email
              decoration: const InputDecoration(
                labelText: 'Email ID:',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the email id';
                }
                return null;
              },
            ),
               const SizedBox(height: 20,),
              TextFormField(
                controller: phoneno,
                decoration: const InputDecoration(
                    labelText: "Phone no:", labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                )
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,

                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Text("Select Position:", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black
                  ),),
                  const SizedBox(width: 50,),
                  DropdownButton<String>(
                    value: _position,
                    onChanged: (newValue) {
                      setState(() {
                        _position = newValue!;
                      });
                    },
                    items: _positionsList.map((position) {
                      return DropdownMenuItem<String>(
                        value: position,
                        child: Text(position),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Text("Select Interviewer:", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black
                  ),),
                  const SizedBox(width: 30,),
                  DropdownButton<String>(
                    value: _interviewer,
                    onChanged: (newValue) {
                      setState(() {
                        _interviewer = newValue!;
                      });
                    },
                    items: _interviewersList.map((interviewer) {
                      return DropdownMenuItem<String>(
                        value: interviewer,
                        child: Text(interviewer),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Text("Select Round:", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black
                  ),),
                  const SizedBox(width: 55,),
                  DropdownButton<String>(
                    value: _round,
                    onChanged: (newValue) {
                      setState(() {
                        _round = newValue!;
                      });
                    },
                    items: _roundsList.map((round) {
                      return DropdownMenuItem<String>(
                        value: round,
                        child: Text(round),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Select Time:',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black
                ),
                  suffixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                controller: TextEditingController(
                  text: time != null
                      ? DateFormat.Hm().format(
                    DateTime(2023, 1, 1, time!.hour, time!.minute),
                  )
                      : '',
                ),
                onTap: () {
                  _pickTime(context);
                },
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 1190),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          _sendInterviewReminder(emailid.text);
                        }
                      },
                      child: const Text('Send Reminder'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      _saveCandidateDetails();
                    }
                  },
                      child: const Text("Save")),
                  const SizedBox(width: 40,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _saveCandidateDetails() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final Map<String, dynamic> candidateData = {
        'candidateName': candidateNameController.text,
        'interviewDate': _doiController.text,
        'emailId': emailid.text,
        'phoneNo': phoneno.text,
        'position': _position,
        'interviewer': _interviewer,
        'round': _round,
        'time': time != null
            ? '${time!.hour}:${time!.minute}'
            : '',
      };

      await firestore.collection('candidates').add(candidateData);

      if (kDebugMode) {
        print('Candidate details saved successfully.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving candidate details: $e');
      }
    }
  }



  void _sendInterviewReminder(String recipientEmail) {
    String candidateName = candidateNameController.text;
    String interviewDate = _doiController.text;
    String position = _position;
    String interviewTime = time != null
        ? DateFormat.Hm().format(
      DateTime(2023, 1, 1, time!.hour, time!.minute),
    )
        : 'Time';

    EmailService.sendReminderEmail(
      recipientEmail: recipientEmail,
      candidateName: candidateName,
      interviewDate: interviewDate,
      interviewTime: interviewTime,
      position: position,
    );

    if (kDebugMode) {
      print('Reminder sent to $candidateName at $recipientEmail for $position interview on $interviewDate at $interviewTime');
    }
  }

}
