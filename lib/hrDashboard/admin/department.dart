import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({super.key});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController department = TextEditingController();

  bool _showDialog = false;
  List<String> _departmentList = [];
  String _department = 'Select Round'; // Default selection

  @override
  void initState() {
    super.initState();
    _fetchDepartments();
  }

  Future<void> _fetchDepartments() async {
    try {
      final querySnapshot = await _firestore.collection('departments').get();
      _departmentList = querySnapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['department'].toString())
          .toList();
      if (_departmentList.isNotEmpty) {
        _department = _departmentList[0];
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
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
                    const SizedBox(height: 20,),
                    const Text(
                      "Add Departments",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 44, 159, 212),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: department,
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
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      child: const Text(
                        'Add Department',
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
            child: _buildDepartmentList(),
          ),
        ],
      ),
    );
  }
  Widget _buildDepartmentList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('departments').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final departments = snapshot.data!.docs;

        _departmentList = departments
            .map((department) =>
            (department.data() as Map<String, dynamic>)['department'].toString())
            .toList();

        if (_departmentList.isEmpty) {
          return const Center(child: Text('No list available.'));
        }

        return ListView.builder(
          itemCount: departments.length,
          itemBuilder: (context, index) {
            final departmentData = departments[index].data() as Map<String, dynamic>;
            final departmentName = departmentData['department'] ?? '';
            final createdAt = departmentData['createdAt']?.toDate() ?? DateTime.now();

            return ListTile(
              title: Text(departmentName),
              subtitle: Text('${_formatDate(createdAt)}'),
              trailing: GestureDetector(
                onTap: () {
                  _deleteDepartment(departmentName);

                  setState(() {
                    departments.removeAt(index);
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
  Future<void> _deleteDepartment(String departmentName) async {
    try {
      await _firestore.collection('departments').where('department', isEqualTo: departmentName).get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting list: $e');
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
        await _firestore.collection('departments').add({
          'department': department.text,
          'createdAt': FieldValue.serverTimestamp(),
        });

        _showDialog = true;

        if (_showDialog) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Department added'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      clearForm();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        setState(() {});
      } catch (e) {
        if (kDebugMode) {
          print('Error: $e');
        }
      }
    }
  }

  void clearForm() {
    department.clear();
  }
}


