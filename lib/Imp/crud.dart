import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController uname=TextEditingController();
  TextEditingController password=TextEditingController();

  Future<void> saveDetails() async{
    try{
      FirebaseFirestore firestore =FirebaseFirestore.instance;
      CollectionReference nameCollection=firestore.collection('login');

      Map<String, dynamic> nameData={
        'name':uname.text,
        'password':password.text,
      };
      await nameCollection.add(nameData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added")));
    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error:$error")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: uname,
              decoration: InputDecoration(
                labelText: "uname",
                hintText: "enter uname",
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: password,
              decoration: InputDecoration(
                labelText: "password",
                hintText: "enter password",
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              saveDetails();

            },
                child: Text("Submit")),
            SizedBox(height: 20,),

            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayDataPage()));

            },
                child: Text("Display"))

          ],
        ),
      ),
    );
  }
}

class DisplayDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Data'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('login').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text('Name: ${data['name']}'),
                  subtitle: Text('Password: ${data['password']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditDataPage(data: data, documentId: snapshot.data!.docs[index].id),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, snapshot.data!.docs[index].id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, String documentId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteItem(documentId,context);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(String documentId,context) async {
    try {
      await FirebaseFirestore.instance.collection('login').doc(documentId).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted")));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $error")));
    }
  }
}

// The rest of your EditDataPage and LoginPage code remains the same.


class EditDataPage extends StatefulWidget {

  final Map<String, dynamic> data;
  final String documentId;

  const EditDataPage({required this.data, required this.documentId, Key? key}) : super(key: key);

  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {

  late TextEditingController unameController;
  late TextEditingController passwordController;

  @override

  void initState() {
    super.initState();
    unameController = TextEditingController(text: widget.data['name']);
    passwordController = TextEditingController(text: widget.data['password']);
  }

  Future<void> updateDetails() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference nameCollection = firestore.collection('login');

      await nameCollection.doc(widget.documentId).update({
        'name': unameController.text,
        'password': passwordController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated")));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
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
              updateDetails();
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}

