
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_module/user/login.dart';

import 'fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();
  bool isShowPassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController uname = TextEditingController();


  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      final existingUser = await FirebaseFirestore.instance
          .collection('registers')
          .where('email', isEqualTo: email.text)
          .get();

      if (existingUser.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email ID already exists'),
          ),
        );
        return;
      }

      final existingUsername = await FirebaseFirestore.instance
          .collection('registers')
          .where('username', isEqualTo: uname.text)
          .get();

      if (existingUsername.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Username already exists'),
          ),
        );
        return;
      }

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        await FirebaseFirestore.instance
            .collection('registers')
            .doc(userCredential.user!.uid)
            .set({
          'username': uname.text,
          'email': email.text,
          'password': password.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully registered'),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        print('Failed to register user: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: uname,
                style: MyFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  hintText: "Enter your username",
                  labelText: "uname",
                  prefixIcon: Icon(Icons.account_box_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return 'Please enter a valid name with only letters and spaces.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: email,
                style: MyFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  labelText: "email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid email address.';
                  }
                  if (!RegExp(
                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(209, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "password",
                  prefixIcon: const Icon(Icons.password_rounded),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isShowPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (value.length < 8 || !RegExp(r'[0-9]').hasMatch(value) || !RegExp(r'[!@#$%^&*]').hasMatch(value)) {
                    return 'Password should contain a minimum of 8 characters, \n one number, and one special character.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: ()  {
                  registerUser();

                }, child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
