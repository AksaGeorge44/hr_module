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

  Future<void>saveDetails() async{
    try{
      FirebaseFirestore firestore=FirebaseFirestore.instance;
      CollectionReference nameCollection=firestore.collection('login');
      Map<String,dynamic>nameData={
        'uname':uname.text,
        'password':password.text,
      };
      await nameCollection.add(nameData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added")));
    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error:${error}")));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("app"),
      ),
      body: StreamBuilder(

          stream: FirebaseFirestore.instance.collection('login').snapshots(),

          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot)
      {
        if(snapshot.connectionState==ConnectionState.waiting)
          {
            return CircularProgressIndicator();
          }
        else if(snapshot.hasError)
          {
            return Text("error:${snapshot.error}");
          }
        else{
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index)
          {
            var data=snapshot.data!.docs[index].data() as Map<String,dynamic>;
            return ListTile(
              title: Text("uname:${data['uname']}"),
              subtitle: Text("password:${data['password']}"),
            );




          }
          );
        }
      }
      )
    );
  }
}
