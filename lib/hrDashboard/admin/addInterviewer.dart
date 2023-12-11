import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InterviewerPage extends StatefulWidget {
  const InterviewerPage({super.key});

  @override
  State<InterviewerPage> createState() => _InterviewerPageState();
}

class _InterviewerPageState extends State<InterviewerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController interviewer = TextEditingController();

  bool _showDialog = false;
  List<String> _interviewersList = [];
  String _interviewer = 'Select Position'; // Default selection

  @override
  void initState() {
    super.initState();
    _fetchInterviewers();
  }

  Future<void> _fetchInterviewers() async {
    try {
      final querySnapshot = await _firestore.collection('interviewers').get();
      _interviewersList = querySnapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['interviewer'].toString())
          .toList();
      if (_interviewersList.isNotEmpty) {
        _interviewer = _interviewersList[0]; // Set the first item as default
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching interviewers list: $e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interviewers'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Add Interviewer",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 44, 159, 212),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: interviewer,
                        decoration: const InputDecoration(
                          labelText: 'Name:',
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid value.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm();
                        clearForm();
                      },
                      child: const Text(
                        'Add Interviewer',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _buildInterviewerList(),
          ),
        ],
      ),
    );
  }
  Widget _buildInterviewerList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('interviewers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final interviewers = snapshot.data!.docs;

        _interviewersList = interviewers
            .map((interviewer) =>
            (interviewer.data() as Map<String, dynamic>)['interviewer'].toString())
            .toList();

        if (_interviewersList.isEmpty) {
          return const Center(child: Text('No list available.'));
        }

        return ListView.builder(
          itemCount: interviewers.length,
          itemBuilder: (context, index) {
            final interviewerData = interviewers[index].data() as Map<String, dynamic>;
            final interviewerName = interviewerData['interviewer'] ?? '';
            final createdAt = interviewerData['createdAt']?.toDate() ?? DateTime.now();

            return ListTile(
              title: Text(interviewerName),
              subtitle: Text('${_formatDate(createdAt)}'),
              trailing: GestureDetector(
                onTap: () {
              _deleteInterviewer(interviewerName);

              // Remove the item from the list.
              setState(() {
                interviewers.removeAt(index);
              });
            },
                child: const Icon(Icons.delete,color: Colors.red,),
              ),
            );
          },
        );
      },
    );
  }
Future<void> _deleteInterviewer(String interviewerName) async {
  try {
    await _firestore.collection('interviewers').where('interviewer', isEqualTo: interviewerName).get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  } catch (e) {
    if (kDebugMode) {
      print('Error deleting interviewer: $e');
    }
  }
}


  String _formatDate(DateTime date) {
    final formattedDate = DateFormat('dd-MM-yyyy    HH:mm').format(date);
    return formattedDate;
  }

  void _submitForm() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      try {
        await _firestore.collection('interviewers').add({
          'interviewer': interviewer.text,
          'createdAt': FieldValue.serverTimestamp(),
        });

        setState(() {});
      } catch (e) {
        if (kDebugMode) {
          print('Error: $e');
        }
      }
    }
  }

  void clearForm() {
    interviewer.clear();
  }
}


