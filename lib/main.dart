import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Animal_Guessing_Game(),
    ),
  );
}

class Animal_Guessing_Game extends StatefulWidget {
  const Animal_Guessing_Game({Key? key}) : super(key: key);

  @override
  State<Animal_Guessing_Game> createState() => _Animal_Guessing_GameState();
}

class _Animal_Guessing_GameState extends State<Animal_Guessing_Game> {
  String animalPath = "assets/images/animals/";

  List<Map<String, dynamic>> animals = [];
  List nameList = [];

  Random r = Random();
  int? i;
  String name = "";

  int nameIndex = 0;
  int chances = 0;

  @override
  void initState() {
    super.initState();

    animals = [
      {
        'id': 1,
        'image': "${animalPath}dog.png",
        'name': "dog",
        'chances': 3,
      },
      {
        'id': 2,
        'image': "${animalPath}horse.png",
        'name': "horse",
        'chances': 3,
      },
      {
        'id': 3,
        'image': "${animalPath}kanchido.png",
        'name': "kanchido",
        'chances': 3,
      },
      {
        'id': 4,
        'image': "${animalPath}lion.png",
        'name': "lion",
        'chances': 3,
      },
      {
        'id': 5,
        'image': "${animalPath}panda.png",
        'name': "panda",
        'chances': 3,
      },
      {
        'id': 6,
        'image': "${animalPath}parrot.png",
        'name': "parrot",
        'chances': 3,
      },
      {
        'id': 7,
        'image': "${animalPath}puffer.png",
        'name': "puffer",
        'chances': 3,
      },
    ];

    i = r.nextInt(animals.length);
    nameList = List.generate(animals[i!]['name'].length, (index) => null);
    chances = animals[i!]['chances'];

    // for(int j = 0; j<nameList.length; j++) {
    //   name = name + nameList[j];
    // }
  }

  void reload() {
    setState(() {
      i = r.nextInt(animals.length);
      nameList = List.generate(animals[i!]['name'].length, (index) => null);
      nameIndex = 0;
      name = "";
      chances = animals[i!]['chances'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Animal Guessing Game",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
      ),
      body: (chances > 0)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    chances,
                    (index) => Icon(
                      CupertinoIcons.smiley_fill,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: h * 0.40,
                  width: w * 0.95,
                  decoration:
                      BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Image.asset(
                    animals[i!]['image'],
                    color:
                        (name == animals[i!]['name']) ? (null) : (Colors.black),
                    height: 300,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: nameList
                      .map(
                        (e) => Container(
                          height: 60,
                          width: w / (animals[i!]['name'].length * 1.2),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            image: (e == null)
                                ? null
                                : DecorationImage(
                                    image: AssetImage(
                                        "assets/images/abc/${nameList[nameList.indexOf(e)]}.png"),
                                  ),
                            border: Border.all(
                              width: 2,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      26,
                      (index) => Padding(
                        padding: EdgeInsets.all(3),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (animals[i!]['name'][nameIndex] ==
                                  String.fromCharCode(index + 97)) {
                                nameList[nameIndex] =
                                    String.fromCharCode(index + 97);
                                name = name + String.fromCharCode(index + 97);
                                nameIndex++;
                              } else {
                                chances--;
                              }
                            });
                          },
                          child: Image.asset(
                            "assets/images/abc/${String.fromCharCode(index + 97)}.png",
                            height: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    (name== animals[i!]['name']) ? reload() : null;
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.red),
                  ),
                  child: Text("Submit"),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      height: h * 0.88,
                      width: w,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        border: Border.all(
                          color: Colors.red,
                          width: 5,
                        ),
                      ),
                    ),
                    Positioned(
                      top: h / 4,
                      left: 60,
                      child: Container(
                        height: h * 0.40,
                        width: 500,
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/animals/loss.png"),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      child: Container(
                        height: h * 0.88,
                        width: w * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.amber,
                            width: 5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: " G\n\n\n",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " A\n\n\n",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " M\n\n\n",
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " E\n",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 500,
                      left: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          reload();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        child: Text("Restart"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
