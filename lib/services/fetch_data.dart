import 'package:dog/model/data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class GetData {
  //To get All Dog Breeds
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

//To get Random Dog Image
  static Future<String> randomDogs() async {
    var client = http.Client();
    var dogUrl = 'https://dog.ceo/api/breeds/image/random';
    var dogUri = Uri.parse(dogUrl);
    var response = await client.get(dogUri);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var parsedResponse = jsonResponse as Map<String, dynamic>;

      return parsedResponse['message'];
    } else {
      throw Exception('Failed to load random dog');
    }
  }

  //To get Dog by Breed
  static Future<String> getDogByBreeds(String type) async {
    var client = http.Client();
    var dogByBreedUri = Uri.parse('https://dog.ceo/api/breed/$type/images/random');

    final response = await client.get(dogByBreedUri);

     if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var parsedResponse = jsonResponse as Map<String, dynamic>;
print(parsedResponse['message']);
      return parsedResponse['message'];
    } else {
      throw Exception('Failed to load random dog');
    }
  }
}
