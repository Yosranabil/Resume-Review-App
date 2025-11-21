import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  static Future<Map<String, dynamic>?> fetchResume(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("GitHub Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Network Error: $e");
    }
    return null;
  }
}
