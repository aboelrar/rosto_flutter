import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rosto_f/apis.dart';
import 'package:rosto_f/categories.dart';
import 'package:rosto_f/home_list.dart';
import 'package:rosto_f/home_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

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

  static int get Pos => 2;

  Future<List<home_list>> getData() async {
    var response = await http.get(apis.branshes);
    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      map.addAll(data);
      if (map['status'] == 1) {
        for (int index = 0; index < map.length; index++) {
          branchess.addAll(map['branches'][index]);
          mylist.add(new home_list(branchess['id'], branchess['name'],
              branchess['address'], branchess['phone']));
        }
      }
    }
    return mylist;
  }

  @override
  void initState() {
    print(home_lists.length);
  }

  List<Widget> _list() {
    List<Widget> weight = new List<Widget>();
    weight.add(branches());
    weight.add(branches());
    weight.add(branches());
    return weight;
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

  //PRESSED ON TABLIST
  void pressed_list(String id) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return categories(id);
    }));
  }

  Widget branches() {
    // return FutureBuilder(
    //future: getData(),
    //builder: (BuildContext context,AsyncSnapshot snapshot)
    //{
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
          padding: const EdgeInsets.only(right: 30, top: 10),
          child: Align(
              alignment: Alignment.topRight,
              child: Text(
                'الفروع',
                style: TextStyle(fontSize: 14, fontFamily: "thesansbold"),
              )),
        ),
        Expanded(
          child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: SizedBox(
                      child: CircularPercentIndicator(
                        radius: 90.0,
                        lineWidth: 8.0,
                        percent: 1.0,
                        center: new Text(
                          "انتظر...",
                          style: TextStyle(fontSize: 12, color: Colors.black,fontFamily: 'thesansbold'),
                        ),
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
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                onTap: () {
                                  save_user_data(snapshot.data[index].id);
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return categories(snapshot.data[index].id);
                                  }));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 20, left: 20, bottom: 10),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 10,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 10.0, left: 10.0),
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Flexible(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    right: 10, top: 14),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text(
                                                      snapshot.data[index].name,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                              "thesansbold"),
                                                    ),
                                                    Transform.translate(
                                                      offset: Offset(0, 13),
                                                      child: Text(
                                                        snapshot.data[index]
                                                            .descripition,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13.0),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    Transform.translate(
                                                      offset: Offset(0, 13),
                                                      child: Text(
                                                        snapshot
                                                            .data[index].phone,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13.0),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              flex: 4),
                                          Flexible(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'image/topimage.png',
                                                width: 75,
                                                height: 78,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            flex: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: 2,
                          ),
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

  CircularBottomNavigationController _navigationController =
      new CircularBottomNavigationController(2);

  @override
  Widget build(BuildContext context) {
    _navigationController.value = 0;
// Read the latest value
    int latest = _navigationController.value;
    // TODO: implement build
    return Scaffold(
        body: _list()[index],
        bottomNavigationBar: CircularBottomNavigation(
          tabItems,
          controller: _navigationController,
          selectedCallback: (int selectedPos) {
            print("clicked on $selectedPos");
          },
        )

        /* BottomNavigationBar(
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
      ),*/
        );
  }

  save_user_data(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("category_id", id);
  }
}
