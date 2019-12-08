import 'package:flutter/material.dart';
import 'package:rosto_f/splash_screen.dart';

import 'login.dart';
import 'one.dart';

void main()
{
  return runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
      initialRoute:'login',
    routes: {
      /**
       * HERE DEFINE ALL PAGES SOMETHING LIKE MANIFIEST IN ANDROID ALL PAGES MUST WRITTING HERE
       */
      'splash_screen':(context)=>splash_screen(),
      'login':(context)=>login(),
      'one':(context)=>one(),
    },
  ));
}



