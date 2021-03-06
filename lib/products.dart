import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rosto_f/apis.dart';
import 'package:rosto_f/categories.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rosto_f/categories_list.dart';
import 'package:rosto_f/my_cart.dart';
import 'package:rosto_f/product_details.dart';
import 'package:rosto_f/product_list.dart';
import 'package:rosto_f/settings.dart';

class products extends StatefulWidget {
  static String numss;
  products(String num)
  {
    numss=num;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print('aaaaaaqqqqqqq${numss}');
    return products_state();
  }
}

class products_state extends State<products> {
  static int count_list = null;
  List<product_list> mylist = new List<product_list>();
  Map map = new Map();
  Map map_list = new Map();
  static int get selectedPos => 2;

  //GET CATEGORIES DATA
  Future<List<product_list>> get_data() async {
    var response = await http.get(
        'https://webdesign.be4em.info/rosto_api_ar/Category/getCategoryProducutByBranchId/549834453/25598/${1}/3');
    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      map.addAll(data);
      if (map['status'] == 1) {
        print(map);
        count_list = map['products'].length;
        for (int index = 0; index < count_list; index++) {
          map_list.addAll(map['products'][index]);
          mylist.add(new product_list(map_list['image'], map_list['product_id'],
              map_list['name'], map_list['price']));
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
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image/header.png"),
                fit: BoxFit.cover,
              ),
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
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 170.0),
            child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'المنتجات',
                  style: TextStyle(fontSize: 16, fontFamily: "thesansbold",color: Colors.black),
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
                  height: 100.0,
                  margin: EdgeInsets.only(top: 180.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            itemCount: count_list,
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return product_details();
                                  }));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                      right: 20.0, left: 20.0, bottom: 20.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Flexible(
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10.0),
                                                      child: Text(
                                                        snapshot
                                                            .data[index].title,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'thesansbold',
                                                            fontSize: 14.0,
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 5.0,
                                                            bottom: 5.0),
                                                        alignment:
                                                            Alignment.topRight,
                                                        width: 70,
                                                        height: 25,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .deepOrange),
                                                        child: Container(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            textDirection:
                                                                TextDirection.rtl,
                                                            children: <Widget>[
                                                              Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .price,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        13.0,
                                                                fontFamily: 'thesansbold'),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 3.0),
                                                                child: Text(
                                                                  'جنيه',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          13.0,
                                                                  fontFamily: 'thesansbold'),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            flex: 5,
                                          ),
                                          Flexible(
                                            child: Image.network(
                                              snapshot.data[index].image,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                         /*     loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return Container(
                                                  height: 80.0,
                                                  width: 80.0,
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
                                            flex: 2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              }
            },
          ),
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
      ),
        bottomNavigationBar: CircularBottomNavigation(
          tabItems,
          barHeight: 50.0,
          controller: _navigationController,
          selectedCallback: (int selectedPos) {
            bottom_nav(selectedPos);
          },
        )
    );
  }
}
