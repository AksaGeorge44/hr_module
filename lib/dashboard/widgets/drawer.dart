import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_module/hrDashboard/hr/hrdashboard.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
           DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: _user?.photoURL != null
                      ? NetworkImage(_user!.photoURL!)
                      : null,
                  child: _user?.photoURL == null
                      ? Text(
                    _user?.displayName?.substring(0, 1) ?? '',
                    style: TextStyle(fontSize: 24),
                  )
                      : null,
                ),
                SizedBox(height: 10),
                Text(
                  _user?.displayName ?? '',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  _user?.email ?? '',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
           ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const HRDashboard()));
            },
            leading: const Icon(Icons.dashboard),
            title: const Text("HR Dashboard"),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: (){

            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Contact()));

            },
            leading: const Icon(Icons.dashboard_customize),
            title: const Text("Financial Management"),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: (){

              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));

            },
            leading: const Icon(Icons.dashboard),
            title: const Text("Supply Chain Management"),
          ),
           ListTile(
            onTap: (){

              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));

            },
            leading: const Icon(Icons.dashboard_customize),
            title: const Text("Customer Relationship Management"),
          ),
           ListTile(
            onTap: (){

              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));

            },
            leading: const Icon(Icons.dashboard),
            title: const Text("Manfacturing Management"),
          ),
           ListTile(
            onTap: (){

              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));

            },
            leading: const Icon(Icons.dashboard_customize),
            title: const Text("Inventory Management"),
          ),
           ListTile(
            onTap: (){

              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));

            },
            leading: const Icon(Icons.dashboard),
            title: const Text("Sales and Orders"),
          ),
           ListTile(
            onTap: (){

              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));

            },
            leading: const Icon(Icons.dashboard_customize),
            title: const Text("Purchase Management"),
          ),
           ListTile(
            onTap: (){

              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));

            },
            leading: const Icon(Icons.dashboard),
            title: const Text("Project Management"),
          ),
           ListTile(
            onTap: (){

              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));

            },
            leading: const Icon(Icons.dashboard_customize),
            title: const Text("Asset Management"),
          ),
        ],
      ),
    );
  }
}