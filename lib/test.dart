import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyHome extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Firebase Authentication'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                  email: 'user@example.com',
                  password: 'password123',
                );
                print('Sign in successful: ${userCredential.user?.email}');
              } catch (e) {
                print('Sign in failed: $e');
              }
            },
            child: Text('Sign In'),
          ),
        ),
      ),
    );
  }
}
