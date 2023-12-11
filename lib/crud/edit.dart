import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {

  final Map<String,dynamic> data;
  final String documentId;

  const EditPage({super.key, required this.data, required this.documentId});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  TextEditingController unameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),

      body: Column(
        children: [
          TextField(
            controller: unameController,
            decoration: InputDecoration(
              labelText: "uname",
              hintText: "enter uname",
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "password",
              hintText: "enter password",
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {

            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
