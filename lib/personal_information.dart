import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class personal_information extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return personal_state();
  }
}

class personal_state extends State<personal_information> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("image/topimage.png"), fit: BoxFit.cover),
              ),
            ),
            text_field('الاسم'),
            text_field('المنطقه'),
            text_field('الشارع'),
            text_field('المبنى'),
            text_field(('الدور')),
            text_field('الشقه'),
            Container(
              margin: EdgeInsets.only(top: 20.0, right: 15, left: 15.0),
              height: 40.0,
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                style: TextStyle(fontFamily: 'thesansbold'),
                decoration: InputDecoration(
                  hintText: 'رقم الهاتف',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, right: 15, left: 15.0),
              height: 100.0,
              child: TextField(
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'thesansbold',
                  height: 2.5,
                ),
                decoration: InputDecoration(
                  hintText: 'ملاحظات',
                ),
              ),
            ),
              Container(
              margin: EdgeInsets.only(top: 10),
              width: 150.0,
              height: 40.0,
              child: FlatButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)
                      {
                        return personal_information();
                      }
                  ));
                },
                child: Text(
                  "متابعة لانهاء الطلب",
                  style: TextStyle(fontSize: 13.0, fontFamily: 'thesansbold'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget text_field(String txt_n) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, right: 15, left: 15.0),
      height: 40.0,
      child: TextField(
        textAlign: TextAlign.right,
        style: TextStyle(fontFamily: 'thesansbold'),
        decoration: InputDecoration(
          hintText: txt_n,
        ),
      ),
    );
  }
}
