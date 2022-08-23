import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dog/model/data.dart';
import 'dart:developer';

class DogHome extends StatefulWidget {
  const DogHome({Key? key}) : super(key: key);

  @override
  State<DogHome> createState() => _DogHomeState();
}

class _DogHomeState extends State<DogHome> {
  

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dog Breed'),
        ),
        body: Center(
          
          ));
  }
}
