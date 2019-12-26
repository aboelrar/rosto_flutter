import 'dart:math';

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rosto_f/apis.dart';
import 'package:rosto_f/categories_list.dart';
import 'package:rosto_f/categories_list.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rosto_f/my_cart.dart';
import 'package:rosto_f/products.dart';
import 'package:rosto_f/settings.dart';

import 'categories_list.dart';

class categories extends StatefulWidget {
  categories(String id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return categoriesState();
  }
}

class categoriesState extends State<categories> {
  static int count = null;
  List<categories_list> mylist = new List<categories_list>();
  Map map = new Map();
  Map map_list = new Map();

  static int get selectedPos => 2;

  //GET CATEGORIES DATA
  Future<List<categories_list>> get_data() async {
    var response = await http.get('${apis.categories}');
    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      map.addAll(data);
      count = map.length;
      if (map['status'] == 1) {
        for (int index = 0; index < count; index++) {
          map_list.addAll(map['catrgories'][index]);
          mylist.add(new categories_list(map_list['image'], map_list['name'],
              map_list['description'], '22'));
        }
      }
    }
    return mylist;
  }

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



  CircularBottomNavigationController _navigationController =
  new CircularBottomNavigationController(selectedPos);

  //Bottom Navigation
  void bottom_nav(position) {
    if (position == 1) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return mycart();
          }));

    } else if (position == 0) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return settings();
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("image/header.png"),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Transform.translate(
                    offset: Offset(25, 45),
                    child: Image.asset(
                      'image/rostologo.png',
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 170.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'الاصناف',
                      style: TextStyle(fontSize: 17, fontFamily: "thesansbold"),
                    )),
              ),
              FutureBuilder(
                  future: get_data(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: SizedBox(
                          child: CircularPercentIndicator(
                            radius: 90.0,
                            lineWidth: 8.0,
                            percent: 1.0,
                            center: Image.asset('image/loadingpic.png',width: 40.0,height: 40.0,),
                            progressColor: Colors.orange,
                            backgroundColor: Colors.deepOrange,
                            animation: true,
                            animationDuration: 1700,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.only(top: 200.0),
                        child: Column(children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 5.0),
                              child: GridView.count(
                                crossAxisCount: count,
                                children: List.generate(2, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return products(snapshot.data[index].num);
                                      }));
                                    },
                                    child: Center(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                      margin: EdgeInsets.only(
                                          left: 15.0, right: 15.0),
                                      elevation: 15.0,
                                      child: Container(
                                        height: 270.0,
                                        child: Column(
                                          children: <Widget>[

                                           Flexible(
                                             child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 10.0,
                                                      left: 10.0,
                                                      top: 10.0),
                                                  child: ClipRRect(
                                                    borderRadius: new BorderRadius.circular(8.0),
                                                    child: Image.network(
                                                      snapshot.data[index].image,
                                                      height: 100.0,
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      fit: BoxFit.cover,
                                                    /*  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                                        if (loadingProgress == null) return child;
                                                        return Container(
                                                          height: 100.0,
                                                          child: Center(
                                                            child: CircularProgressIndicator(
                                                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                                                              backgroundColor: Colors.grey,
                                                              value: loadingProgress.expectedTotalBytes != null ?
                                                              loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                                  : null,
                                                            ),
                                                          ),
                                                        );
                                                      },*/
                                                    ),
                                                  ),
                                                ),flex: 8,
                                           ),
                                            Flexible(
                                              child: Container(
                                                margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(
                                                            right: 20.0),
                                                        child: Align(
                                                          alignment: Alignment.topRight,
                                                          child: Text(
                                                            snapshot.data[index].title,
                                                            style: TextStyle(
                                                                fontFamily: 'thesansbold',
                                                                fontSize: 15.0,
                                                                color: Colors.black),
                                                          ),
                                                        ),
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(
                                                            right: 20.0,top: 5.0),
                                                        child: Align(
                                                            alignment: Alignment.topRight,
                                                            child: Text(
                                                              snapshot.data[index].desc,
                                                              style: TextStyle(
                                                                  fontSize: 12.0),
                                                            )),
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 5.0),
                                                        child: Align(
                                                          alignment: Alignment.topRight,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.only(
                                                                    right: 3.0),
                                                                child: Text(
                                                                  'صنف',
                                                                  style: TextStyle(
                                                                      color: Colors.red,
                                                                      fontSize: 12.0),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.only(
                                                                    right: 20.0,top: 2.0),
                                                                child: Text(
                                                                  '22',
                                                                  style: TextStyle(
                                                                      color: Colors.red,
                                                                      fontSize: 12.0),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      flex: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              flex: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                  );
                                }),
                              ),
                            ),
                          )
                        ]),
                      );
                    }
                  }),
              Positioned(
                top: 120.0,
                left: 20.0,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                        width: 100.0,
                        height: 100.0,
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: new BorderRadius.circular(50.0),
                          child: Image.asset(
                            'image/chicken.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        controller: _navigationController,
        barHeight: 50.0,
        selectedCallback: (int selectedPos) {
          bottom_nav(selectedPos);
        },
      ),

    );
  }
}
