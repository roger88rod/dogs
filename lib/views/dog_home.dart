import 'package:flutter/material.dart';
import 'package:dog/model/data.dart';
import 'package:dog/services/fetch_data.dart';

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
        if (snapshot.hasData) {
          Map<String,dynamic> myMap = Map.from( snapshot.data!.message );
          var keyList = myMap.keys.toList(); 
          //print(snapshot.data!.message); // Check getting Data
          //return Text(snapshot.data!.message);
          return ListView.builder(
            itemCount: myMap.length,
            itemBuilder: (context, index) {
                          return Text(keyList[index]);//key value
                        },
          );

        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return  CircularProgressIndicator();
      },
    );
  }
}
