
import 'package:flutter/material.dart';

// Custom class representing a person
class Person {
  String name;
  int age;

  // Constructor
  Person({
    required this.name,
    required this.age,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Creating an instance of the custom class
    Person person = Person(name: 'John Doe', age: 25);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Class Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Name: ${person.name}'),
              Text('Age: ${person.age}'),
            ],
          ),
        ),
      ),
    );
  }
}
