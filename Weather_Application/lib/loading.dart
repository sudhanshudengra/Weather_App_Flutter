import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_application/Worker/worker.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String temp;
  late String hum;
  late String air_speed;
  late String des;
  late String main;
  late String icon;
  String city = "Udaipur";

  void startApp(String city) async {
    worker instance = worker(location: city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "air_speed_value": air_speed,
        "des_value": des,
        "main_value": main,
        "icon_value":icon,
        "city_value":city,
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;
    // city = search!['search_text'];

    if(search?.isNotEmpty ?? false)
      {
        city = search!['searchText'];
      }
    startApp(city!);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CircleAvatar(
                    radius: 110,
                    backgroundImage:
                        AssetImage("assets/images/weather_logo.png"),
                  ),
                ),
              ),
              SizedBox(height: 16),
              //     Text("Weather Application",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500,color: Colors.white),),
              //       SizedBox(height: 10,),
              // Text("Made by Sudhanshu",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400,color: Colors.lightGreenAccent)),
              //       SizedBox(height: 39),
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText("Weather Application",
                      textStyle: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightGreenAccent,
                          decoration: TextDecoration.underline),
                      speed: Duration(milliseconds: 150)),
                  // WavyAnimatedText("Made by Sudhanshu",textStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.w400,color: Colors.lightGreenAccent),
                  //     speed: Duration(milliseconds: 100)),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
              SizedBox(height: 20),
              SpinKitWave(
                color: Colors.amberAccent,
                size: 50.0,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blueAccent,
    );
  }
}
