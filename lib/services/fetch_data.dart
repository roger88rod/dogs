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
      //print("Server status code success");
      return Dog.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load dog breed');
    }
    
  }

  static Future<Dog> getRandom() async{
    var client = http.Client();
    String randomDog = 'https://dog.ceo/api/breeds/image/random';
    var randomDogUri = Uri.parse(randomDog);

    final response = await client.get(randomDogUri);

    if (response.statusCode == 200) {
      return Dog.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load random dog');
    }
    
  }

  
}
