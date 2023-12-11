import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../employee/permission.dart';
class DesignationPage extends StatefulWidget {
  const DesignationPage({super.key});

  @override
  State<DesignationPage> createState() => _DesignationPageState();
}

class _DesignationPageState extends State<DesignationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController position = TextEditingController();

  bool _showDialog = false;
  List<String> _positionsList = [];
  String _position = 'developer'; // Default selection

  @override
  void initState() {
    super.initState();
    _fetchPositions();
  }

  Future<void> _fetchPositions() async {
    try {
      final querySnapshot = await _firestore.collection('positions').get();
      _positionsList = querySnapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['position'].toString())
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Designation'),
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
                      "Add New Designation",
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
                        controller: position,
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
                      },
                      child: const Text(
                        'Add New Designation',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),


                    // DropdownButton<String>(
                    //   value: _position,
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       _position = newValue!;
                    //     });
                    //   },
                    //   items: _positionsList.map((position) {
                    //     return DropdownMenuItem<String>(
                    //       value: position,
                    //       child: Text(position),
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _buildPositionList(),
          ),
        ],
      ),
    );
  }
  Widget _buildPositionList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('positions').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final positions = snapshot.data!.docs;

        _positionsList = positions
            .map((position) =>
            (position.data() as Map<String, dynamic>)['position'].toString())
            .toList();

        if (_positionsList.isEmpty) {
          return const Center(child: Text('No position available.'));
        }

        return ListView.builder(
          itemCount: positions.length,
          itemBuilder: (context, index) {
            final positionData = positions[index].data() as Map<String, dynamic>;
            final positionName = positionData['position'] ?? '';
            final createdAt = positionData['createdAt']?.toDate() ?? DateTime.now();

            return ListTile(
              title: Text(positionName),
              subtitle: Text('${_formatDate(createdAt)}'),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PermissionPage()));
                },
                child: const Icon(Icons.view_list),
              ),
            );
          },
        );
      },
    );
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
        await _firestore.collection('positions').add({
          'position': position.text,
          'createdAt': FieldValue.serverTimestamp(),
        });

        _showDialog = true;

        if (_showDialog) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Position added'),
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
    position.clear();
  }
}


