import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_module/user/forgotPassword.dart';
import 'package:hr_module/user/register.dart';
import '../dashboard/dashboard.dart';
import 'fonts.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShowPassword = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: email,
                      style: MyFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: "Enter your email",
                        labelText: "email",
                        prefixIcon: Icon(Icons.email_outlined),

                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(20),
                        // )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                     //height: 500,
                     // width: 500,
                      child: TextFormField(
                        controller: password,
                        obscureText: isShowPassword,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(209, 0, 0, 0)),
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          labelText: "password",
                          prefixIcon: const Icon(Icons.password_rounded),
                          suffixIcon: CupertinoButton(
                            onPressed: () {
                              setState(() {
                                isShowPassword = !isShowPassword;
                              });
                            },
                            padding: EdgeInsets.zero,
                            child: Icon(
                              isShowPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: email.text, password: password.text);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Dashboard()),
                        );
                      } on FirebaseAuthException catch (e) {
                        // Show an error message if the authentication fails
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('User does not exist'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid email or password'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                const SizedBox(width: 200,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const PasswordScreen()));
                }, child: const Text("Forgot Password"))
                ],
              ),

              const SizedBox(height: 60,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


