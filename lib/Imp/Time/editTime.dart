import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditDataPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final String documentId;

  const EditDataPage({required this.data, required this.documentId, Key? key}) : super(key: key);

  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  late TextEditingController unameController;
  late TextEditingController dateController;
  late TextEditingController timeController;

  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    unameController = TextEditingController(text: widget.data['name']);
    dateController = TextEditingController(text: widget.data['date']);
    timeController = TextEditingController(text: widget.data['time']);

    String timeString = widget.data['time'];
    selectedTime = timeString.isNotEmpty
        ? TimeOfDay.fromDateTime(DateFormat.Hm().parse(timeString))
        : null;
  }

  Future<void> updateDetails() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference nameCollection = firestore.collection('users');

      await nameCollection.doc(widget.documentId).update({
        'name': unameController.text,
        'date': dateController.text,
        'time': selectedTime != null
            ? _formatTime(selectedTime!)
            : '',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Updated")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return DateFormat('HH:mm').format(dateTime);
  }

  Future<void> _pickTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
        timeController.text = _formatTime(selectedTime!);
      });
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
          SizedBox(height: 20),
          TextField(
            controller: dateController,
            decoration: InputDecoration(
              labelText: "date",
              hintText: "enter date",
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: timeController,
            onTap: () {
              _pickTime(context);
            },
            decoration: InputDecoration(
              labelText: 'Time:',
              hintText: 'select time',
              suffixIcon: Icon(Icons.access_time),
            ),
            readOnly: true,
          ),
          SizedBox(height: 20),
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
