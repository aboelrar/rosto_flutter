import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosto_f/person_list.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class personal_info_edits extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return personal_state();
  }
}

class personal_state extends State<personal_info_edits> {
  //GET DATA FROM SERVER
  List<person_list> mylist = new List<person_list>();
  Map map = new Map();
  Map map_list = new Map();
  static String user_id;

  Future<List<person_list>> get_data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString("id");
    });

    var response = await http.get(
        'https://webdesign.be4em.info/rosto_api_ar/User/view/549834453/25598/${user_id}');
    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      map.addAll(data);
      if(map['status']==1)
        {
          map_list.addAll(map['user']);
          mylist.add(person_list(map_list['id'],map_list['name'],map_list['phone'],map_list['mail']));
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
          Container(
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
                Transform.translate(
                  offset: Offset(0.0, 20),
                  child: Text(
                    'تعديل البيانات الشخصيه',
                    style: TextStyle(
                        fontFamily: 'thesansbold',
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Image.asset(
                    'image/client.png',
                    width: 65,
                    height: 65,
                  ),
                ),
                new Container(
                  height: 200.0,
                  child: new Container(
                    margin: EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                        color: Colors.black12,
                        borderRadius: new BorderRadius.circular(8.0)),
                    child: new Center(
                      child: Container(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
                        margin: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: FutureBuilder(
                          future: get_data(),
                          builder: (BuildContext context,AsyncSnapshot snapshot)
                            {
                              if(snapshot.data == null )
                                {

                                  return Card(
                                    child: Text('${snapshot.data}',style: TextStyle(fontSize: 17,),),
                                  );
                                }
                              else{
                                return Form(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 13.0),
                                        child: Container(
                                          height: 40.0,
                                          child: TextFormField(
                                            initialValue: snapshot.data[0].name,
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.person,
                                                size: 25.0,
                                                color: Colors.black,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 13.0),
                                        child: Container(
                                          height: 40.0,
                                          child: TextFormField(
                                            initialValue: snapshot.data[0].email,
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.email,
                                                size: 25.0,
                                                color: Colors.black,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 40.0,
                                        child: TextFormField(
                                          initialValue: snapshot.data[0].phone,
                                          decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.phone,
                                              size: 25.0,
                                              color: Colors.black,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              },

                        ),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    /* Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return personal_information();
              }));*/
                  },
                  child: Text(
                    "تعدبل",
                    style: TextStyle(fontSize: 13.0, fontFamily: 'thesansbold'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
