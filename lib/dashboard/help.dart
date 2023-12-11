import 'package:flutter/material.dart';

class HelpAndSupportWidget extends StatelessWidget {
  const HelpAndSupportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Help"),
        ),
        body: Column(

          children: [
            const SizedBox(height: 20,),
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Help and Support',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(Icons.help_outline),
                      title: const Text('FAQs'),
                      onTap: () {
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.contact_support),
                      title: const Text('Contact Support'),
                      onTap: () {
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      );
  }
}