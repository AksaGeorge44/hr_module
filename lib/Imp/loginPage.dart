// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class LoginPage extends StatefulWidget {
//
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//
//   Future<String?> getUserRole() async {
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user == null) {
//       return null;
//     }
//     final idTokenResult = await user.getIdTokenResult();
//
//     return idTokenResult.claims['role'];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             // Perform login logic
//
//             // Check user role
//             final userRole = await getUserRole();
//
//             // Navigate based on role
//             if (userRole == 'admin') {
//               // Navigate to admin page
//               Navigator.pushReplacementNamed(context, '/admin');
//             } else {
//               // Navigate to user page
//               Navigator.pushReplacementNamed(context, '/user');
//             }
//           },
//           child: Text('Login'),
//         ),
//       ),
//     );
//   }
// }
