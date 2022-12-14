import 'package:flutter/material.dart';
import 'package:dog/model/data.dart';
import 'package:dog/services/fetch_data.dart';
//TODO:
//1.Display Dog breed in Dropdown
//2.Show random image of dog
//3.or from all breeds if there is not any selected.

class DogHome extends StatefulWidget {
  const DogHome({Key? key}) : super(key: key);

  @override
  State<DogHome> createState() => _DogHomeState();
}

class _DogHomeState extends State<DogHome> {
  Dog? dropdownvalue;
  Future<Dog>? dogBreed;
  Future<String>? randomDog;
  Future<String>? getDogByBreed;
  String dropDownValue = '';
  //bool _clicked = false;
  List data = [];
  late String selectedDog;
  var _dog = "";
  String selectval = '';

  @override
  Widget build(BuildContext context) {
    dogBreed = GetData.getBreeds();
    randomDog = GetData.randomDogs();
    getDogByBreed = GetData.getDogByBreeds(dropDownValue);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: DecorationImage(
                image: AssetImage("assets/images/dogsbackground.jpg"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
              )),
          child: Column(
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
              Center(child: _dogBreeds()),
              SizedBox(height: 20),
              Container(
                height: 250,
                child: (dropDownValue == '')
                ? _random()
                :_getRandomSelectedBreed()
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
          setState(() {
            randomDog = GetData.randomDogs();
          });
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

       Widget _getRandomSelectedBreed() => Container(
        child: FutureBuilder<String>(
          future: getDogByBreed,
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

   Widget _dogBreeds() => Container(
        child: FutureBuilder(
          future: GetData.getBreeds(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Map<String, dynamic> myMap = Map.from(snapshot.data!.message);
            var keyList = myMap.keys.toList();
            return snapshot.hasData
                ? Container(
                    child: DropdownButton<String>(
                      hint: Text(dropDownValue),
                      items: keyList.map((item) {
                        return new DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropDownValue = value!;
                          print(value);
                        });
                      },
                    ),
                  )
                : Container(
                    child: Center(
                      child: Text('Loading...'),
                    ),
                  );
          },
        ),
      );
}
