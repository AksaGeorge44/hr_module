import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_module/hrDashboard/admin/addPermission.dart';
import 'package:intl/intl.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController role = TextEditingController();

  bool _showDialog = false;
  List<String> _rolesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions'),
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
                      "Add Permissions",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 44, 159, 212),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>const AddPermissionPage()));
                      },
                      child: const Text(
                        'New Permissions',
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
            child: _buildRoleList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('roles').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final roles = snapshot.data!.docs;

        _rolesList = roles
            .map((role) =>
                (role.data() as Map<String, dynamic>)['role'].toString())
            .toList();

        if (_rolesList.isEmpty) {
          return const Center(child: Text('No roles available.'));
        }

        return ListView.builder(
          itemCount: roles.length,
          itemBuilder: (context, index) {
            final roleData = roles[index].data() as Map<String, dynamic>;
            final roleName = roleData['role'] ?? '';
            final createdAt = roleData['createdAt']?.toDate() ?? DateTime.now();

            return ListTile(
              title: Text(roleName),
              subtitle: Text('${_formatDate(createdAt)}'),
              trailing: const Icon(Icons.view_list),
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
        await _firestore.collection('roles').add({
          'role': role.text,
          'createdAt': FieldValue.serverTimestamp(),
        });

        _showDialog = true;

        if (_showDialog) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Role added'),
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
    role.clear();
  }
}
