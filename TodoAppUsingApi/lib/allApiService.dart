import 'dart:convert';

import 'package:http/http.dart' as http;


class ApiService{

/// static: if a data member is static, it can be accessed without creating an object.
  static Future<bool> delete(String id) async{

    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);

    final response = await http.delete(uri);

    if(response.statusCode == 200) return true;
    else return false;
  }

  static Future<List?> read() async{

    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body) as Map;
      final result = responseBody['items'] as List;
      return result;
    }
    else return null;
  }

  static Future<bool> update(String id,Map body) async{
    final url='https://api.nstack.in/v1/todos/$id';
    final uri=Uri.parse(url);

    final response=await http.put(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type':'application/json'
        }
    );

    if(response.statusCode==200) return true;
    else return false;

  }

  static Future<bool> create(Map body)async{
    final url='https://api.nstack.in/v1/todos';
    final uri=Uri.parse(url);

    final response=await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type':'application/json'
        }
    );
    if(response.statusCode==201) return true;
    else return false;

  }

}