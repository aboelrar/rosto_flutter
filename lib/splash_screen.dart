
 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rosto_f/HomeScreen.dart';

import 'login.dart';

class splash_screen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return splash_state();
  }
}
class splash_state extends State<splash_screen>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/rostolog.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => login())));
  }

}