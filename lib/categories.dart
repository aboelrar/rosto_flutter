import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class categories extends StatefulWidget
{
  categories(String id);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return categoriesState();
  }
}
class categoriesState extends State<categories>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:  AssetImage("image/topimage.png"),
                  fit: BoxFit.cover
                ),
              ),
              child: Column(
                children: <Widget>[
                  Text('الفرع الاول',style: TextStyle(fontFamily: "thesansbold"),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  }