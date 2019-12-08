import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class one extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return one_s();
  }
}

class one_s extends State<one>
{
  static int num=1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildfgGASHDHFHSAJKSFJKAKLKFSKAJLKJFA
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
        Container(
          height: 500,
          child: ListView.builder(
          itemCount: num,
          itemBuilder: (BuildContext context, index)
    {
      return TextField(

      );
    }
          ),
        ),
             GestureDetector(
               onTap: ()
               {
                 setState(() {
                   num = num+1;
                 /*  Navigator.push(context, MaterialPageRoute(
                       builder: (BuildContext context) {
                         return one();
                       }));*/
                 });
               },
               child: Container(
                 child: Text('+')
                 ,
               ),
             ),
          ],
        ),
      ),
    );
  }

}