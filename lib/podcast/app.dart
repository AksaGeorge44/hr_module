import 'package:flutter/material.dart';
import 'package:hr_module/podcast/home.dart';
import 'package:hr_module/podcast/search.dart';
import 'package:hr_module/podcast/yourlibrary.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Tabs=[Home(),Search(),Library()];
  int currentindex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Tabs[currentindex],
      backgroundColor: Colors.black,

      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentindex)
          {
            setState(() {
              currentindex=currentindex;
            });

          },
          currentIndex: currentindex,
          
          items: [

        BottomNavigationBarItem(

            icon: Icon(Icons.home),label: "Home"


        ),
        BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.library_add),label: "Library"),
      ]),
    );
  }
}
