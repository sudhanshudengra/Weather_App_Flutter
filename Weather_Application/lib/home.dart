import 'dart:convert';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';
import 'loading.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    print("This is an init State");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set State called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    var city_name = ["Mumbai", "Delhi", "Udaipur", "London"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map info = ModalRoute.of(context)?.settings.arguments as Map;
    String temp = ((info['temp_value']).toString());
    String air = ((info['air_speed_value']).toString());
    if (temp == "NA") {
      print("NA");
    } else {
      temp = ((info['temp_value']).toString().substring(0, 4));
      air = ((info['air_speed_value']).toString().substring(0, 4));
    }
    String icon = info['icon_value'];
    String getcity = info['city_value'];
    String hum = info['hum_value'];

    String des = info['des_value'];

    List<MaterialColor> colorizeColors = [
      Colors.red,
      Colors.yellow,
      Colors.purple,
      Colors.blue,
    ];

    // const colorizeTextStyle = TextStyle(
    //   fontSize: 38.0,
    //   fontFamily: 'SF',
    //   fontStyle: FontStyle.italic,
    // );

    return Scaffold(
      resizeToAvoidBottomInset: false,


      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: NewGradientAppBar(
            title: Text('Flutter'),
            gradient: LinearGradient(colors: [Colors.blue,Colors.yellow,Colors.orange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
        ),
      ),

      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
                // height : MediaQuery.of(context).size.height,  =>To use maximum height of screen
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blueAccent,
                  Colors.lightBlue,
                ],
              )),
              child: Column(
                children: [
                  Container(
                    //Search Conatiner

                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              if ((searchController.text).replaceAll(" ", "") ==
                                  "") {
                                print("Blank Search");
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, "/loading",
                                    arguments: {
                                      "searchText": searchController.text,
                                    });
                              }
                            },
                            child: Container(
                              child: Icon(
                                Icons.search_rounded,
                                color: Colors.blueAccent,
                              ),
                              margin: EdgeInsets.fromLTRB(3, 0, 8, 0),
                            )),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter any City Name:     eg:$city",
                              // hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.network(
                                  "https://openweathermap.org/img/wn/$icon@2x.png"),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "$des",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "$getcity",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                          padding: EdgeInsets.all(26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.thermometer),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$temp",
                                    style: TextStyle(
                                      fontSize: 90,
                                    ),
                                  ),
                                  // Text("C",style: TextStyle(
                                  //   fontSize: 30
                                  // ),),
                                  Icon(
                                    WeatherIcons.celsius,
                                    size: 48,
                                  ),
                                ],
                              ),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    ColorizeAnimatedText(
                                      'Temperature',
                                      textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                        fontSize: 55.0,
                                        fontFamily: 'SF',
                                        fontStyle: FontStyle.italic,
                                      ),
                                      colors: colorizeColors,
                                    ),
                                  ],
                                  isRepeatingAnimation: true,
                                  repeatForever: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          padding: EdgeInsets.all(26),
                          height: 210,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.day_windy),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "$air",
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("km/hr"),
                              SizedBox(height: 6,),

                              FittedBox(
                                fit: BoxFit.contain,
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    ColorizeAnimatedText(
                                      'Air Speed',
                                      textAlign: TextAlign.left,
                                      textStyle: TextStyle(
                                        fontSize: 28.5,
                                        fontFamily: 'SF',
                                        fontStyle: FontStyle.italic,
                                      ),
                                      colors: colorizeColors,
                                    ),
                                  ],
                                  isRepeatingAnimation: true,
                                  repeatForever: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                          padding: EdgeInsets.all(26),
                          height: 210,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.humidity),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "$hum",
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("Percent(%)"),
                              SizedBox(height: 6,),

                              FittedBox(
                                fit: BoxFit.contain,
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    ColorizeAnimatedText(
                                      'Humidity',
                                      textAlign: TextAlign.left,
                                      textStyle: TextStyle(
                                        fontSize: 28.5,
                                        fontFamily: 'SF',
                                        fontStyle: FontStyle.italic,
                                      ),
                                      colors: colorizeColors,
                                    ),
                                  ],
                                  isRepeatingAnimation: true,
                                  repeatForever: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  Container(
                    color: Colors.transparent,
                    height: 50,
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          ScaleAnimatedText('Developed by Sudhanshu',
                              scalingFactor: 0.8,
                              textStyle: TextStyle(
                                  color: Colors.lightGreenAccent,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
