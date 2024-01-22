import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPTService {
  final String apiKey;
  final String endpoint = 'https://api.openai.com/v1/engines/davinci-codex/completions';

  ChatGPTService({required this.apiKey});

  Future<String> generateResponse(String input) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt': input,
        'max_tokens': 150,  // Adjust as needed
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['choices'][0]['text'];
    } else {
      throw Exception('Failed to generate response');
    }
  }
}
