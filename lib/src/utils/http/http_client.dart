import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {
  static Future<Map<String, dynamic>> get(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> data) async {
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create data');
    }
  }

  static Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic> data) async {
    final response = await http.put(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update data');
    }
  }

  static Future<Map<String, dynamic>> delete(String url) async {
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }
}
