import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hr_module/Imp/API/Delete.dart';
import 'package:hr_module/Imp/API/Get.dart';
import 'package:hr_module/Imp/API/Post.dart';
import 'package:hr_module/Imp/API/Update.dart';
import 'package:hr_module/Imp/AnimatedCon.dart';
import 'package:hr_module/Imp/Eg.dart';
import 'package:hr_module/Imp/httpEg.dart';
import 'package:hr_module/Imp/httpEg1.dart';
import 'package:hr_module/dashboard/dashboard.dart';
import 'package:hr_module/user/login.dart';

import 'Imp/crud.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //name: 'hr_module',
    options: const FirebaseOptions(
        apiKey: 'AIzaSyCWCGprBDza6W4CbS--XErSMa_4Bb7Nobg',
        appId: '863626803161:android:dcf4e4e787edd0809ccbc8',
        messagingSenderId: '863626803161',
        projectId: 'hrmodule-d1b97'
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Dashboard()
      ),
    );
  }
}


