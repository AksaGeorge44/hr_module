
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../crud/crud.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController uname = TextEditingController();
  TextEditingController date = TextEditingController();

  TimeOfDay? time;
  //date

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 50),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        date.text = formatDate(selectedDate);
      });
    }
  }


  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }



//time
  Future<void> _pickTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        time = pickedTime;
      });
    }
  }



  Future<void> saveDetails() async{
    try{
      FirebaseFirestore firestore=FirebaseFirestore.instance;
      CollectionReference nameCollection=firestore.collection('users');
      Map<String,dynamic>nameData={
        'uname':uname.text,
        'date':date.text,
        'time':time != null
            ? DateFormat.Hm().format(
          DateTime(2023, 1, 1, time!.hour, time!.minute),
        ) : '',
      };
      await nameCollection.add(nameData);
    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error:$error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            TextFormField(
              controller: uname,
              decoration: InputDecoration(
                labelText: "uname",
                hintText: "enter uname",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter all fields';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: date,
              onTap: () {
                _selectDate(context);
              },
              decoration: const InputDecoration(
                labelText: 'Salary start:',
                labelStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Select Time:',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black
                ),
                suffixIcon: Icon(Icons.access_time),
              ),
              readOnly: true,
              controller: TextEditingController(
                text: time != null
                    ? DateFormat.Hm().format(
                  DateTime(2023, 1, 1, time!.hour, time!.minute),
                )
                    : '',
              ),
              onTap: () {
                _pickTime(context);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                saveDetails();
              },
              child: Text("Submit"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayDataPage()));
              },
              child: Text("Retrieve"),
            ),
          ],
        ),
      ),
    );
  }


}
