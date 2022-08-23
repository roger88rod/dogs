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
  //String dropdownvalue = 'Choose Breed';
  // List data = [];
  //Event selectedEvent;

  @override
  Widget build(BuildContext context) {
    dogBreed = GetData.getBreeds();
    //data = dogBreed as List;
    return Scaffold(
      body: FutureBuilder<Dog>(
        future: dogBreed,
        builder: (context, snapshot) {
          final events = snapshot.data!.message.keys;
          Map<String, dynamic> myMap = Map.from(snapshot.data!.message);
          var keyList = myMap.keys.toList();
          print(snapshot.data!.message.keys);
          if (events != null ) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButtonHideUnderline(
                    child: DropdownButton<Dog>(
                      hint: const Text("Choose Breed..."),
                      //value: selectedEvent ?? events[0],
                      isDense: true,
                      onChanged: (newValue) {
                        setState(() {
                          //selectedEvent = newValue;
                        });
                      },
                      items: keyList.map((String keylist) {
                      return DropdownMenuItem<Dog>(
                        //value: Text(keylist),
                        child: Text(keylist),
                      );
                    }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
