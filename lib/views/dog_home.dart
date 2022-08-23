import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dog/model/data.dart';
import 'package:dog/services/fetch_data.dart';
import 'dart:developer';

class DogHome extends StatefulWidget {
  const DogHome({Key? key}) : super(key: key);

  @override
  State<DogHome> createState() => _DogHomeState();
}

class _DogHomeState extends State<DogHome> {
  Future<Dog>? dogBreed;

  @override
  Widget build(BuildContext context) {
   dogBreed = GetData.getBreeds();
    return FutureBuilder<Dog>(
      future: dogBreed,
      builder: (context, snapshot) {
              if(snapshot.hasData){
                print(snapshot.data!.message);//
                //return Text(snapshot.data!.message);
              } else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
    );
  }
}
