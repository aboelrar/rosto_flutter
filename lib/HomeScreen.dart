import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rosto_f/apis.dart';
import 'package:rosto_f/home_list.dart';
import 'package:rosto_f/home_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homestate();
  }
}

/**
 * GET DATA FROM SERVER
 */
class homestate extends State<HomeScreen> {
  List<home_list> mylist = new List<home_list>();
  static List<home_list> home_lists = new List<home_list>();
  Map map = new Map();
  Map branchess = new Map();

  Future<List<home_list>> getData() async {
    var response = await http.get(apis.branshes);
    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      map.addAll(data);
      if (map['status'] == 1) {
        for (int index = 0; index < map.length; index++) {
          branchess.addAll(map['branches'][index]);
          mylist.add(new home_list(
              branchess['id'], branchess['name'], branchess['address']));
        }
      }
    }
    return mylist;
  }

  @override
  void initState() {
    print(home_lists.length);
  }

  /* List<Widget> _tabList = [

    Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 150,
            width: 411.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image/topimage.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Transform.translate(
              offset: Offset(25, 35),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  'image/rostologo.png',
                  alignment: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 10.0),
            child: Align(
              alignment: Alignment.topRight,

            ),
          ),

        ],
      ),
    ),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.purple,
    )
  ];*/

  List<Widget> _list() {
    List<Widget> weight = new List<Widget>();
    weight.add(branches());
    weight.add(branches());
    weight.add(branches());
    return weight;
  }

  Widget branches() {
    // return FutureBuilder(
    //future: getData(),
    //builder: (BuildContext context,AsyncSnapshot snapshot)
    //{
    return Container(
        child: Column(
      children: <Widget>[
        Expanded(
          child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Text('loading');
                } else {
                  return Container(
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
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'الفروع',
                                style: TextStyle(
                                    fontSize: 14, fontFamily: "thesansbold"),
                              )),
                        ),

                        Expanded(
                          child: ListView.builder(itemBuilder: (BuildContext context,index)
                          {
                            return Container(
                              margin: EdgeInsets.only(right: 10,left: 10,bottom: 10),
                              child: Card(
                                elevation: 10,
                                child: Container(
                                  margin:
                                  const EdgeInsets.only(right: 10.0, left: 10.0),
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 10,top: 14),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data[index].name,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "thesansbold"),
                                            ),
                                            Transform.translate(
                                              offset: Offset(0,13),
                                              child: Text(
                                                snapshot.data[index].descripition,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Card(
                                        child: Image.asset(
                                          'image/topimage.png',
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                        elevation: 5,
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          },itemCount: 2,),
                        ),
                      ],
                    ),
                  );
                }
              }),
        )
      ],
    ));
    // },
    //);
  }

  int index = 2;

  void change_index_bottom(int value) {
    setState(() {
      index = value;
      _list()[index];
      getData().then((value) {
        home_lists.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _list()[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: change_index_bottom,
        type: BottomNavigationBarType.fixed,
        iconSize: 20.0,
        fixedColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            title: Text('انا'),
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            title: Text('الطلبات'),
            icon: Icon(Icons.shopping_cart),
          ),
          BottomNavigationBarItem(
            title: Text('الفروع'),
            icon: Icon(Icons.flag),
          ),
        ],
      ),
    );
  }
}
