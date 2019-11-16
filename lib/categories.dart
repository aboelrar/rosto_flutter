import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosto_f/apis.dart';
import 'package:rosto_f/categories_list.dart';
import 'package:rosto_f/categories_list.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

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
  List<categories_list> mylist = new List<categories_list>();
  Map map = new Map();
  Map map_list = new Map();

  //GET CATEGORIES DATA
  Future<List<categories_list>> get_data() async {
    var response = await http.get('${apis.categories}2/2');
    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      map.addAll(data);
      if (map['status'] == 1) {
        for (int index = 0; index < map.length; index++) {
          map_list.addAll(map['catrgories'][index]);
          mylist.add(new categories_list(map_list['image'], map_list['name'],
              map_list['description'], '22'));
        }
      }
    }
    return mylist;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              FutureBuilder(
                future: get_data(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.data==null)
                    {
                    return Text('Loading....');
                    }
                  else{
                    return Container(
                      child: Column(children: <Widget>[
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("image/topimage.png"),
                                fit: BoxFit.cover),
                          ),
                          child: Column(
                            children: <Widget>[
                              Transform.translate(
                                  offset: Offset(0, 20),
                                  child: Text(
                                    'الفرع الاول',
                                    style: TextStyle(
                                        fontFamily: "thesansbold",
                                        color: Colors.white,
                                        fontSize: 14),
                                  )),
                              Transform.translate(
                                offset: Offset(-20, 70),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'الفرع الاول',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    )),
                              ),
                              Transform.translate(
                                offset: Offset(-20, 70),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '01141012485',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'الاصناف',
                                style: TextStyle(
                                    fontSize: 14, fontFamily: "thesansbold"),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: GridView.count(
                              crossAxisCount: 2,
                              children: List.generate(2, (index) {
                                return Center(
                                    child: Card(
                                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                                      elevation: 10.0,
                                      child: Container(
                                        height: 250.0,
                                        child: Column(
                                          children: <Widget>[
                                            Card(
                                              elevation: 10.0,
                                              child: Image.network(
                                                snapshot.data[index].image,
                                                height: 100.0,
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover,
                                              ),
                                              margin: EdgeInsets.only(
                                                  right: 15.0, left: 15.0, top: 15.0),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0, top: 5.0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  snapshot.data[index].title,
                                                  style: TextStyle(
                                                      fontFamily: 'thesansbold',
                                                      fontSize: 13.0,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 20.0),
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    snapshot.data[index].desc,
                                                    style: TextStyle(fontSize: 12.0),
                                                  )),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(right: 3.0),
                                                    child: Text(
                                                      'صنف',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 20.0),
                                                    child: Text(
                                                      '22',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              }),
                            ),
                          ),
                        )
                      ]),
                    );
                  }


      }

              ),
              Positioned(
                top: 120.0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Card(
                      elevation: 10,
                      child: Image.asset(
                        'image/dishes.jpg',
                        width: 60,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
