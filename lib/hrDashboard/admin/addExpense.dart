import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController expenseType = TextEditingController();

  List<String> _expensesList = [];
  String _expTypes = 'Select Position'; // Default selection

  @override
  void initState() {
    super.initState();
    _fetchTypes();
  }

  Future<void> _fetchTypes() async {
    try {
      final querySnapshot = await _firestore.collection('exptypes').get();
      _expensesList = querySnapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['expenseType'].toString())
          .toList();
      if (_expensesList.isNotEmpty) {
        _expTypes = _expensesList[0]; // Set the first item as default
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching  list: $e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Type'),
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
                      "Add Expense Type",
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
                        controller: expenseType,
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
                        'Add Expense Type',
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
            child: _buildexpTypeList(),
          ),
        ],
      ),
    );
  }
  Widget _buildexpTypeList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('exptypes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final expTypes = snapshot.data!.docs;

        _expensesList = expTypes
            .map((expType) =>
            (expType.data() as Map<String, dynamic>)['expenseType'].toString())
            .toList();

        if (_expensesList.isEmpty) {
          return const Center(child: Text('No position available.'));
        }

        return ListView.builder(
          itemCount: expTypes.length,
          itemBuilder: (context, index) {
            final expTypeData = expTypes[index].data() as Map<String, dynamic>;
            final expTypeName = expTypeData['expenseType'] ?? '';
            final createdAt = expTypeData['createdAt']?.toDate() ?? DateTime.now();

            return ListTile(
              title: Text(expTypeName),
              subtitle: Text('${_formatDate(createdAt)}'),
              trailing: GestureDetector(
                onTap: () {
                  _deleteexpType(expTypeName);

                  setState(() {
                    expTypes.removeAt(index);
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
  Future<void> _deleteexpType(String interviewerName) async {
    try {
      await _firestore.collection('exptypes').where('expenseType', isEqualTo: interviewerName).get().then((querySnapshot) {
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
        await _firestore.collection('exptypes').add({
          'expenseType': expenseType.text,
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
    expenseType.clear();
  }
}


