import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosto_f/personal_information.dart';
import 'add_new_product.dart';
import 'package:toast/toast.dart';

class mycart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mycart_state();
  }
}

class mycart_state extends State<mycart> {
  List data = new List();

//GETdATA
  void getData() async {
    add_new_product().getData().then((result) {
      setState(() {
        data.addAll(result);
      });
    });
  }

  @override
  void initState() {
    getData();
  }

  String total_price() {
    int total_price = 0;
    for (int index = 0; index < data.length; index++) {
      int price = int.parse(data[index]['price']);
      total_price += price;
    }

    String price = total_price.toString();
    return price;
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
                    image: AssetImage("image/topimage.png"), fit: BoxFit.cover),
              ),
            ),
            Container(
              height: 200,
              child: show_card_data(),
            ),
            get_total_price(),
            Container(
              margin: EdgeInsets.only(top: 25),
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
                  /*...*/
                },
                child: Text(
                  "اضافة طلب",
                  style: TextStyle(fontSize: 13.0, fontFamily: 'thesansbold'),
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
                  Navigator.pushReplacement(context, MaterialPageRoute(
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

  //CARD OF LIST VIEW
  Widget show_card_data() {
    if (data != null && data.length > 0) {
      return Container(
        child: Card(
          margin: EdgeInsets.all(15.0),
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 5.0),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(right: 10.0),
                            width: 10.0,
                            height: 10.0,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(40.0))),
                      ),
                      Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Container(
                            padding: EdgeInsets.only(right: 10.0),
                            alignment: Alignment.topRight,
                            child: Text(
                              data[index]['name'],
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'thesansbold',
                                  color: Colors.black),
                            )),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              data[index]['size'],
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'thesansbold',
                                  color: Colors.black),
                            )),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          data[index]['quantity'],
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'thesansbold',
                              color: Colors.black),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          data[index]['price'],
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'thesansbold',
                              color: Colors.black),
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        title: new Text("حذف المنتج"),
                                        content: new Text(
                                            "هل انت متاكد من حذف المنتج"),
                                        actions: <Widget>[
                                          FlatButton(
                                              child: Text('نعم'),
                                              onPressed: () {
                                                add_new_product addNewProduct =
                                                    new add_new_product();
                                                addNewProduct
                                                    .delete(data[index]['id']);
                                                setState(() {
                                                  data.removeAt(index);
                                                });
                                                Navigator.pop(context);
                                              }),
                                          FlatButton(
                                            child: Text('لا'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ));
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Image.asset(
                                'image/error.png',
                                width: 15.0,
                                height: 15.0,
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              },
              itemCount: data.length,
            ),
          ),
        ),
      );
    } else {
      return Card();
    }
  }

  //TOTAL PRICE
  Widget get_total_price() {
    if (data != null && data.length > 0) {
      return Card(
        elevation: 10.0,
        margin: EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
        child: Container(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 50.0,
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'السعر الاجمالى',
                style: TextStyle(
                    fontFamily: 'thesansbold',
                    color: Colors.deepOrange,
                    fontSize: 13.0),
              ),
              Text(
                '${total_price()}',
                style: TextStyle(
                    fontFamily: 'thesansbold',
                    color: Colors.deepOrange,
                    fontSize: 13.0),
              )
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }
}
