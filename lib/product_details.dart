import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class product_details extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return product_state();
  }

}

class product_state extends State<product_details>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       body: Stack(
         children: <Widget>[
           Container(
             child: Column(
               children: <Widget>[
               Container(
               height: 150,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 image: DecorationImage(
                     image: AssetImage("image/topimage.png"),
                     fit: BoxFit.cover),
               ),
               )
               ],
             ),
           )
         ],
       ),
    );
  }
}