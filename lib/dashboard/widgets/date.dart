import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDateTimeWidget extends StatefulWidget {
  const CurrentDateTimeWidget({super.key});

  @override
  _CurrentDateTimeWidgetState createState() => _CurrentDateTimeWidgetState();
}

class _CurrentDateTimeWidgetState extends State<CurrentDateTimeWidget> {
  String formattedDate = '';
  String formattedTime = '';

  @override
  void initState() {
    super.initState();
    _updateDateTime();
  }

  void _updateDateTime() {
    final now = DateTime.now();
    formattedDate = DateFormat('MM/dd/yyyy').format(now); // Format date as "MM/dd/yyyy"
    formattedTime = DateFormat.Hm().format(now); // Format time as "HH:mm"

    Future.delayed(const Duration(minutes: 1), _updateDateTime); // Update every minute
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        Row(
          children: [
            const Text('Date: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            Text(formattedDate, style: const TextStyle(fontSize: 16),),
          ],
        ),
        const SizedBox(height: 3,),
        Row(
          children: [
            const Text('Time: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(formattedTime, style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}