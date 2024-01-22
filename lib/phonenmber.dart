import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {

  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  String? _verificationId;

  Future<void> _verifyPhoneNumber() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = "+${_phoneNumberController.text}";
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
          // Navigate to successful login screen
        },
        verificationFailed: (FirebaseAuthException error) {
          // Handle error
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval failed, use manual verification
          setState(() => _verificationId = verificationId);
        },
        codeSent: (String verificationId, [int? resendToken]) {
          setState(() => _verificationId = verificationId);
        },
      );
    }
  }




  Future<void> _verifyOtp() async {
    if (_otpController.text.isNotEmpty) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: _otpController.text,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Navigate to successful login screen
      } on FirebaseAuthException catch (error) {
        // Handle error
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_verificationId == null) ...[
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                ElevatedButton(
                  onPressed: _verifyPhoneNumber,
                  child: Text('Request OTP'),
                ),
              ] else
                ...[
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Enter OTP'),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter the OTP' : null,
                  ),
                  ElevatedButton(
                    onPressed: _verifyOtp,
                    child: Text('Verify OTP'),
                  ),
                ],
            ],
          ),
        ),
      ),
    );
  }
}