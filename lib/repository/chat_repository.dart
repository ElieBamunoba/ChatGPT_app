import 'package:http/http.dart' as http;
import 'dart:convert';

class APIRepository {
  final String apiKey;
  final String endpoint;

  APIRepository({required this.apiKey, required this.endpoint});

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        "id": "chatcmpl-123",
        "object": "chat.completion",
        "created": 1677652288,
        "model": "gpt-3.5-turbo-0613",
        "choices": [
          {
            "index": 0,
            "message": {
              "role": "assistant",
              "content": message,
            },
            "finish_reason": "stop"
          }
        ],
        "usage": {
          "prompt_tokens": 9,
          "completion_tokens": 12,
          "total_tokens": 21
        }
      }),
    );
    print('########################');
    print(response.body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to send message');
    }
  }
}
