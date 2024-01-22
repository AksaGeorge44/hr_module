import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {

  DateTime _selectedDay = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  String _taskName = '';
  String _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _selectedTimeText = DateFormat('HH:mm').format(DateTime.now());
  String _necessaryItems = '';

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = DateTime(
          _selectedDay.year,
          _selectedDay.month,
          _selectedDay.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _selectedTimeText = pickedTime.format(context);
      });
    }
  }

  Future<void> saveTaskToFirebase() async {
    final newTask = {
      'taskName': _taskName,
      'date': _selectedDate,
      'time': _selectedTimeText,
      'necessaryItems': _necessaryItems,
    };

    try {
      await FirebaseFirestore.instance.collection('tasks').add(newTask);
      Navigator.of(context).pop();
    } catch (e) {
      if (kDebugMode) {
        print('Error saving task: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Tasks Calendar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TableCalendar(
                focusedDay: _selectedDay,
                firstDay:
                    DateTime(_selectedDay.year, _selectedDay.month - 2, 1),
                lastDay:
                    DateTime(_selectedDay.year, _selectedDay.month + 2, 31),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _selectedDate =
                        DateFormat('yyyy-MM-dd').format(_selectedDay);
                  });
                },
              ),




              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Create New Task'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              onChanged: (value) {
                                _taskName = value;
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Task Name'),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                const Text('Date:'),
                                IconButton(
                                  icon: const Icon(Icons.date_range),
                                  onPressed: () async {
                                    final DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: _selectedDay,
                                      firstDate: DateTime.now(),
                                      lastDate:
                                          DateTime(DateTime.now().year + 2),
                                    );
                                    if (selectedDate != null) {
                                      setState(() {
                                        _selectedDay = selectedDate;
                                        _selectedDate = DateFormat('yyyy-MM-dd')
                                            .format(_selectedDay);
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const Text('Time:'),
                                IconButton(
                                  icon: const Icon(Icons.access_time),
                                  onPressed: () {
                                    _selectTime(context);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              onChanged: (value) {
                                _necessaryItems = value;
                              },
                              maxLines: 2,
                              decoration: const InputDecoration(
                                  labelText: 'Description'),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              saveTaskToFirebase();
                            },
                            child: const Text('Create Task'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Create New Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
