import 'dart:developer';

import 'package:dog/model/data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class GetData{
  /*Future<List<Dog>?> getDogs() async{

    var cl = http.Client();
    var uri = Uri.parse('https://dog.ceo/api/breeds/list/all');

    var response = await cl.get(uri);

    if(response.statusCode == 200){
      var json = response.body;
      
      return dogFromJson(json);
    }
  }*/
  //

  Future<Dog> fetchPost() async {
    var cl = http.Client();
    var uri = Uri.parse('https://dog.ceo/api/breeds/list/all');

    final response = await cl.get(uri);
  //final response =
     // await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    print("message!!!!");
    return Dog.fromJson(json.decode(response.body));

  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}
}