import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String _baseURL =
      'https://crudcrud.com/api/4edc952046be4ecf8d32ecae18e8ddf6/todo';

  // Get all todos
  get() async {
    try {
      final response = await http.get(Uri.parse(_baseURL));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Create a new todo
  post(Map<String, dynamic> data) async {
    try {
      String jsondata = json.encode(data);
      final response =
          await http.post(Uri.parse(_baseURL), body: jsondata, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Update a todo
  put(String url, Map<String, dynamic> data) async {
    try {
      String jsondata = json.encode(data);
      final response =
          await http.put(Uri.parse(_baseURL + url), body: jsondata, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Delete a todo
  delete(String url) async {
    try {
      final response = await http.delete(Uri.parse(_baseURL + url));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
