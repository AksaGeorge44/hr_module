import 'package:flutter/material.dart';

import 'gpt.dart';


class GptApp extends StatelessWidget {
  final ChatGPTService chatGPTService = ChatGPTService(apiKey: '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');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ChatGPT Flutter App'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final response = await chatGPTService.generateResponse('Your input prompt here');
              print('ChatGPT Response: $response');
            },
            child: Text('Generate Response'),
          ),
        ),
      ),
    );
  }
}
