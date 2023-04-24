//
// import 'dart:js';
// import 'package:js/js.dart';

import 'package:flutter/material.dart';

import 'home.dart';
import 'loading.dart';


void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/":(context) => Loading(),
      "/home" : (context) => Home(),
      "/loading" : (context) => Loading(),
    },
  ));
}
