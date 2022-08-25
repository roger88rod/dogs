import 'package:flutter/material.dart';
import 'package:dog/model/data.dart';
import 'package:dog/services/fetch_data.dart';
//1.Select Dog breed in Dropdown
//2.Show random image of selected breed or from all breeds if there is not any selected.

class DogHome extends StatefulWidget {
  const DogHome({Key? key}) : super(key: key);

  @override
  State<DogHome> createState() => _DogHomeState();
}

class _DogHomeState extends State<DogHome> {
  Dog? dropdownvalue;
  Future<Dog>? dogBreed;
  Future<String>? randomDog;

  // ignore: deprecated_member_use
  List data = [];
  //Event selectedEvent;
  Dog? selectedDog;

  @override
  Widget build(BuildContext context) {
    dogBreed = GetData.getBreeds();
    randomDog = GetData.randomDogs();

    //data = dogBreed as List;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 700,
                    alignment: Alignment.bottomCenter,
                    child: _bannerCard(),
                  ),
                ),
                Center(child: _imgBanner()),
                
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _finalButton(context),
      ),
    );
  }

  Widget _bannerCard() => Container(
        height: 500,
        width: 340,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'WOOF!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Welcome to Our Dog App',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                
              ),
              SizedBox(height: 20),
              Center(child: _breeds()),
              SizedBox(height: 20),
              Container(
                height: 250,
                child:  _random(),
              ),
              
            ],
          ),
        ),
      );

  Widget _imgBanner() {
    return Container(
      height: 250,
      child: Image.asset('assets/images/bostonterrier.png'),
    );
  }

  Container _finalButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 34),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        child: Text(
          "Get a Random Image",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          //_random();
        },
      ),
    );
  }

  Widget _random() => Container(
        child: FutureBuilder<String>(
          future: randomDog,
          builder: (context, snapshot) {
            final randomDogPic = snapshot.data!;
            //print(randomDogPic);
            // ignore: unnecessary_null_comparison
            if (randomDogPic != null) {
              return Center(
                  child: Container(
                height: 300,
                width: 300,
                //alignment: Alignment.bottomCenter,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: new ListView(
                        children: <Widget>[new Image.network(randomDogPic)])),
              ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );

  Widget _breeds() => Container(
        child: FutureBuilder<Dog>(
          future: dogBreed,
          builder: (context, snapshot) {
            final events = snapshot.data!.message.keys;
            Map<String, dynamic> myMap = Map.from(snapshot.data!.message);
            var keyList = myMap.keys.toList();
            print(snapshot.data!.message.keys);

            // ignore: unnecessary_null_comparison
            if (events != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButtonHideUnderline(
                      child: DropdownButton<Dog>(
                        hint: const Text("Choose Breed..."),
                        value: selectedDog,
                        isDense: true,
                        items: keyList.map((item) {
                          return DropdownMenuItem<Dog>(
                            value: selectedDog,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (item) {
                          setState(() {
                            selectedDog = item;
                          });
                        },
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
