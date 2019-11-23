import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rosto_f/product_details_list.dart';
import 'package:toast/toast.dart';
import 'add_new_product.dart';
import 'my_cart.dart';

class product_details extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return product_state();
  }
}

class product_state extends State<product_details> {
  int quantity = 1;

  //PLUS CLICK
  void plusClick() {
    setState(() {
      quantity = quantity + 1;
    });
  }

  //MINUS CLICK
  void minusClick() {
    setState(() {
      if (quantity >= 2) {
        quantity = quantity - 1;
      }
    });
  }

  var size_list = ['Small', 'Big'];
  var selected_item = 'Small';

  void on_select_item(String newvalueSelected) {
    setState(() {
      this.selected_item = newvalueSelected;
    });
  }

  List<product_details_list> mylist = new List();
  Map map = new Map();
  Map map_list = new Map();
  Map map_price = new Map();

  //GET DATA
  Future<List<product_details_list>> get_data() async {
    var response = await http.get(
        'https://webdesign.be4em.info/rosto_api_ar/Product/productdetails/549834453/25598/1');
    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      print(data);
      map.addAll(data);
      if (map['status'] == 1) {
        map_list.addAll(map['product']);
        map_price.addAll(map['prices'][0]);
        mylist.add(new product_details_list(
            map_list['image'],
            map_list['name'],
            map_list['id'],
            map_list['description'],
            map_price['size'],
            map_price['price']));
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
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Text('Loading....');
                } else {
                  int total_price =
                      int.parse(snapshot.data[0].price) * quantity;

                  return Container(
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
                        ),
                        Card(
                          elevation: 5.0,
                          margin: EdgeInsets.only(
                              top: 20.0, right: 20.0, left: 20.0),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Image.network(
                                  snapshot.data[0].image,
                                  width: MediaQuery.of(context).size.width,
                                  height: 140.0,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    snapshot.data[0].name,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'thesansbold',
                                        color: Colors.black),
                                  ),
                                ),
                                Text(
                                  snapshot.data[0].descripition,
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'thesansbold',
                                      color: Colors.grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 7.0),
                                  height: 40.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      textDirection: TextDirection.rtl,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: plusClick,
                                          child: Container(
                                            width: 30.0,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        40.0)),
                                            child: Center(
                                              child: Text(
                                                '+',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 60.0,
                                          height: 30.0,
                                          child: Center(
                                            child: Text(
                                              '${quantity}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: minusClick,
                                          child: Container(
                                            width: 30.0,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        40.0)),
                                            child: Center(
                                              child: Text(
                                                '-',
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
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new Text(
                                          "الحجم",
                                          style: TextStyle(
                                              fontFamily: 'thesansbold',
                                              fontSize: 13.0,
                                              color: Colors.grey),
                                        ),
                                        flex: 1,
                                      ),
                                      DropdownButton<String>(
                                        items: size_list
                                            .map((String dropDownString) {
                                          return DropdownMenuItem<String>(
                                            value: dropDownString,
                                            child: Text(
                                              dropDownString,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black,
                                                  fontFamily: 'thesansbold'),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: on_select_item,
                                        value: selected_item,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      Text(
                                        'السعر',
                                        style: TextStyle(
                                            fontFamily: 'thesansbold',
                                            fontSize: 14.0,
                                            color: Colors.grey),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 3.0, left: 3.0),
                                        child: Text(
                                          '${total_price}',
                                          style: TextStyle(
                                              fontFamily: 'thesansbold',
                                              fontSize: 14.0,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      Text(
                                        'جنيه',
                                        style: TextStyle(
                                            fontFamily: 'thesansbold',
                                            fontSize: 14.0,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    int add = await add_new_product().create({
                                      'name': snapshot.data[0].name,
                                      'description':
                                          snapshot.data[0].descripition,
                                      'size':snapshot.data[0].size,
                                      'quantity':'${quantity}',
                                      'product_id':snapshot.data[0].id,
                                      'price':snapshot.data[0].price,
                                      'size_id':"1"
                                    });
                                    print(add);
                                    if(add>=1)
                                      {
                                        Toast.show("Added Successfully", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (BuildContext context)
                                            {
                                              return mycart();
                                            }
                                        ));
                                      }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    width: MediaQuery.of(context).size.width,
                                    height: 30.0,
                                    color: Colors.deepOrange,
                                    child: Center(
                                      child: Text(
                                        'اضف الى الطلبات',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'thesansbold',
                                            fontSize: 13.0),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
