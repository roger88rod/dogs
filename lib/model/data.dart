// To parse this JSON data, do
//
//     final dog = dogFromJson(jsonString);

//import 'dart:convert';

//List<Dog> dogFromJson(String str) => List<Dog>.from(json.decode(str));
//List<Dog> dogFromJson(String str) => Dog.fromJson(json.decode(str));

//String dogToJson(Dog data) => json.encode(data.toJson());

class Dog {
    Dog({
        required this.message,
        required this.status,
    });

    Map<String, List<String>> message;
    String status;

    factory Dog.fromJson(Map<String, dynamic> json) =>  Dog(
        message: Map.from(json["message"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
        status: json["status"],
    );

   /* Map<String, dynamic> toJson() => {
        "message": Map.from(message).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "status": status,
    };*/
}