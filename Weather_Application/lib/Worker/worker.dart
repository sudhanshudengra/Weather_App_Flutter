import 'dart:convert';
import 'dart:core';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class worker
{
  late String location;

  worker ({required this.location})
  {
    location = this.location;
  }

  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;


  Future<void> getData() async {

    try{
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=84cce9a749a3325c14b16618927cd27c"));
      Map data = jsonDecode(response.body);

      // Getting temp & humidity
      Map temp_data = data['main'];
      String getHumidity = temp_data['humidity'].toString();
      double getTemp = temp_data['temp'] - 273.15;
      // print(temp);

      // Getting air speed
      Map wind = data['wind'];
      double getAir_speed = wind['speed']/0.277777;

      // Getting Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data['description'];


      // assigning values
      temp = getTemp.toString(); //Celsuius
      humidity = getHumidity; //%
      air_speed  = getAir_speed.toString(); //km/hr
      description = getDesc;
      main = getMain_des;
      icon = weather_main_data['icon'].toString();
    }catch(e)
    {
      temp = "Try checking the city name!!";
      humidity = "NA";
      air_speed  = "NA";
      description = "NA";
      main = "NA";
      icon = "50n";
    }

    }



}
