import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosto_f/HomeScreen.dart';
import 'package:rosto_f/my_cart.dart';
import 'package:rosto_f/personal_info_edits.dart';

class settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return settings_state();
  }
}

class settings_state extends State<settings> {

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.person, "انا", Colors.deepOrange,
        labelStyle:
        TextStyle(fontWeight: FontWeight.normal, color: Colors.deepOrange)),
    new TabItem(Icons.shopping_cart, "الطلبات", Colors.deepOrange,
        labelStyle:
        TextStyle(fontWeight: FontWeight.normal, color: Colors.deepOrange)),
    new TabItem(Icons.flag, "الفروع", Colors.deepOrange,
        labelStyle:
        TextStyle(fontWeight: FontWeight.normal, color: Colors.deepOrange)),
  ]);

  static int get Pos => 0;

  CircularBottomNavigationController _navigationController =
  new CircularBottomNavigationController(Pos);

  //Bottom Navigation
  void bottom_nav(position)
  {
    if(position==1)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context) {
            return mycart();
          }));
    }
    else if(position==2)
      {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return HomeScreen();
            }));
      }
  }


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
                  image: AssetImage("image/topimage.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Transform.translate(
                  offset: Offset(25, 35),
                  child: Image.asset(
                    'image/rostologo.png',
                    alignment: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'اعدادات',
                style: TextStyle(
                    fontFamily: 'thesansbold',
                    fontSize: 15,
                    color: Colors.black38),
              ),
            )),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 6.0, right: 15.0, left: 15.0),
                children: <Widget>[
                  Container(
                    height: 0.4,
                    color: Colors.black45,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6.0),
                    padding: EdgeInsets.only(right: 5.0),
                    color: Colors.black12,
                    height: 35.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الحساب الشخصى',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black,
                            fontFamily: 'thesansbold'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return personal_info_edits();
                          }));
                    },
                    child: Container(
                      width: 300.0,
                      padding: EdgeInsets.only(left: 7.0,right: 7.0,top: 5.0,bottom: 5.0),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  'البيانات الشخصية',
                                  style: TextStyle(
                                      fontFamily: 'thesansbold',
                                      fontSize: 11,
                                      color: Colors.black54),
                                ),
                              )),
                          Image.asset('image/nextone.png',width: 15,height: 15,)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: Colors.black45,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 7.0,right: 7.0,top: 5.0,bottom: 5.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'تغيير الرقم السرى',
                                style: TextStyle(
                                    fontFamily: 'thesansbold',
                                    fontSize: 11,
                                    color: Colors.black54),
                              ),
                            )),
                        Image.asset('image/nextone.png',width: 15,height: 15,)
                      ],
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: Colors.black45,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.0),
                    padding: EdgeInsets.only(right: 5.0),
                    color: Colors.black12,
                    height: 35.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'اعدادات',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black,
                            fontFamily: 'thesansbold'),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 7.0,right: 7.0,top: 5.0,bottom: 5.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'من نحن',
                                style: TextStyle(
                                    fontFamily: 'thesansbold',
                                    fontSize: 11,
                                    color: Colors.black54),
                              ),
                            )),
                        Image.asset('image/nextone.png',width: 15,height: 15,)
                      ],
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: Colors.black45,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 7.0,right: 7.0,top: 5.0,bottom: 5.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'اسئلة شائعة',
                                style: TextStyle(
                                    fontFamily: 'thesansbold',
                                    fontSize: 11,
                                    color: Colors.black54),
                              ),
                            )),
                        Image.asset('image/nextone.png',width: 15,height: 15,)
                      ],
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: Colors.black45,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 7.0,right: 7.0,top: 5.0,bottom: 5.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'اتصل بنا',
                                style: TextStyle(
                                    fontFamily: 'thesansbold',
                                    fontSize: 11,
                                    color: Colors.black54),
                              ),
                            )),
                        Image.asset('image/nextone.png',width: 15,height: 15,)
                      ],
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: Colors.black45,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 7.0,right: 7.0,top: 5.0,bottom: 5.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'سياسة الخصوصية',
                                style: TextStyle(
                                    fontFamily: 'thesansbold',
                                    fontSize: 11,
                                    color: Colors.black54),
                              ),
                            )),
                        Image.asset('image/nextone.png',width: 15,height: 15,)
                      ],
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: Colors.black45,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.0),
                    padding: EdgeInsets.only(right: 5.0),
                    color: Colors.black12,
                    height: 35.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'تسجيل الخروج',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black,
                            fontFamily: 'thesansbold'),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
        bottomNavigationBar: CircularBottomNavigation(
          tabItems,
          controller: _navigationController,
          barHeight: 50.0,
          selectedCallback: (int selectedPos) {
            setState(() {
              bottom_nav(selectedPos);
            });
          },
        )
    );
  }
}
