// Import the cloud_firestore package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}
class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: newPasswordController,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                hintText: 'Enter new password',
                labelText: 'New Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  icon: Icon(
                    isShowPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  try {
                    await user.updatePassword(newPasswordController.text);

                    await FirebaseFirestore.instance
                        .collection('registers') // Adjust collection name
                        .doc(user.uid) // Use the user's UID as the document ID
                        .update({'password': newPasswordController.text});

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password updated successfully'),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to update password: ${e.message}'),
                      ),
                    );
                  }
                }
              },
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
