import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homestate();
  }
}

class homestate extends State<HomeScreen> {
  List<Widget> _tabList = [
    Container(
      child: Row(
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
              offset:Offset (25,35),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  'image/rostologo.png',
                  alignment: Alignment.bottomRight,
                ),
              ),
            ),
          )
        ],
      ),
    ),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.purple,
    )
  ];

  int index = 2;

  void change_index_bottom(int value) {
    setState(() {
      index = value;
      _tabList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _tabList[index],
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
