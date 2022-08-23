//import 'dart:developer';
import 'package:dog/model/data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class GetData {
  static Future<Dog> getBreeds() async {
    var client = http.Client();
    var dogUri = Uri.parse('https://dog.ceo/api/breeds/list/all');

    final response = await client.get(dogUri);

    if (response.statusCode == 200) {
      print("Server status code success");
      return Dog.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
    
  }
}
