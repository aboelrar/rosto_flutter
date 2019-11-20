import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosto_f/apis.dart';
import 'package:rosto_f/categories.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rosto_f/categories_list.dart';
import 'package:rosto_f/product_list.dart';

class products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return products_state();
  }
}

class products_state extends State<products> {
  List<product_list> mylist = new List<product_list>();
  Map map = new Map();
  Map map_list = new Map();

  //GET CATEGORIES DATA
  Future<List<product_list>> get_data() async {
    var response = await http.get('https://webdesign.be4em.info/rosto_api_ar/Category/getCategoryProducutByBranchId/549834453/25598/1/3');
    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      map.addAll(data);
      if (map['status'] == 1) {
        print(map);
        for (int index = 0; index < map['products'].length; index++) {
          map_list.addAll(map['products'][index]);
          mylist.add(new product_list(map_list['image'],map_list['product_id'],map_list['name'],map_list['price']));
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
          FutureBuilder(
            future: get_data(),
            builder: (BuildContext context, AsyncSnapshot snapshot)
            {
              if(snapshot.data==null)
                {
                  return Text('Loading...');
                }
              else{
                return Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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
                      Padding(
                        padding: const EdgeInsets.only(right: 15,top: 10.0),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'المنتجات',
                              style:
                              TextStyle(fontSize: 14, fontFamily: "thesansbold"),
                            )),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: 1
                            , itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              margin:
                              EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 15.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data[index].title,
                                              style: TextStyle(
                                                  fontFamily: 'thesansbold',
                                                  fontSize: 14.0,
                                                  color: Colors.black),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                margin: EdgeInsets.only(top: 5.0),
                                                alignment: Alignment.topRight,
                                                width: 60,
                                                height: 25,
                                                decoration:
                                                BoxDecoration(
                                                    color: Colors.deepOrange),
                                                child: Center(
                                                  child: Text(
                                                    snapshot.data[index].price,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Image.network(snapshot.data[index].image, width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,)
                                  ],
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
          )
        ],
      ),
    );
  }
}
