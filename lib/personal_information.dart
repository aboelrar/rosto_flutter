import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rosto_f/HomeScreen.dart';
import 'package:rosto_f/add_new_product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class personal_information extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return personal_state();
  }
}

class personal_state extends State<personal_information> {
  var key = GlobalKey<FormState>();

  var a = "";

  List list_data = new List();

//GETdATA
  void getData() async {
    add_new_product().getData().then((result) {
      setState(() {
        list_data.addAll(result);
      });
    });
  }

  //SEND DATA TO SERVER
  Future<http.Response> callWebServiceForsendinfo(
      String name,
      String street,
      String building,
      String floor,
      String flat,
      String mobile,
      String notes) async {
    //PROGREES DIAOLG
    ProgressDialog pr = new ProgressDialog(context);
    pr.style(
        message: 'جارى ارسال الاوردر...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    pr.show();

    String id = null;
    String category_id = null;

    //SHREDPREFRENCES DATA
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id");
      category_id = prefs.getString("category_id");
    });

    for (int index = 0; index < list_data.length; index++) {
      if (index + 1 == list_data.length) {
        a +=
            "[${list_data[index]['id']},${list_data[index]['quantity']},${list_data[index]['price']},1]";
      } else {
        a +=
            "[${list_data[index]['id']},${list_data[index]['quantity']},${list_data[index]['price']},1],";
      }
    }

    final paramDic = {
      "name": name,
      "street": street,
      "building": building,
      "floor": floor,
      "flat": flat,
      "mobile": mobile,
      "longitude": "0.0",
      "latitude": "0.0",
      "notes": notes,
      "id_user": id,
      "id_branch": category_id,
      "products": "[${a}]",
    };

    final information = await http.post(
        "https://webdesign.be4em.info/rosto_api_ar/cart/sendOrder/549834453/25598",
        body: paramDic);
    var data = convert.jsonDecode(information.body);

    if (data['status'] == 1) {
      pr.dismiss();
      Toast.show('تم ارسال الاوردر بنجاح', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      add_new_product().deleteAll();

      //GO TO HOME
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return HomeScreen();
      }));
    }
    return information;
  }

  @override
  void initState() {
    getData();
  }

  //CONTROLLER DEFINED LIKE ID
  TextEditingController nameController = new TextEditingController();
  TextEditingController regionController = new TextEditingController();
  TextEditingController streetController = new TextEditingController();
  TextEditingController buildingController = new TextEditingController();
  TextEditingController floorController = new TextEditingController();
  TextEditingController flatController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Form(
        key: key,
        child: Container(
          child: ListView(
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
              text_field('الاسم', nameController, 'من فضلك ادخل الاسم'),
              text_field('المنطقه', regionController, 'من فضلك ادخل المنطقه'),
              text_field('الشارع', streetController, 'من فضلك ادخل الشارع'),
              text_field('المبنى', buildingController, 'من فضلك ادخل المبنى'),
              text_field('الدور', floorController, 'من فضلك ادخل الدور'),
              text_field('الشقه', flatController, 'من فضلك ادخل الشقه'),
              Container(
                margin: EdgeInsets.only(top: 20.0, right: 15, left: 15.0),
                height: 40.0,
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'من فضلك ادخل رقم الهاتف';
                    } else {
                      return null;
                    }
                  },
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontFamily: 'thesansbold'),
                  decoration: InputDecoration(
                    hintText: 'رقم الهاتف',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, right: 15, left: 15.0),
                height: 100.0,
                child: TextFormField(
                  controller: notesController,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'thesansbold',
                    height: 2.5,
                  ),
                  decoration: InputDecoration(
                    hintText: 'ملاحظات',
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return personal_information();
                    }));
                  },
                  child: GestureDetector(
                    onTap: () {

                      if(key.currentState.validate())
                        {
                          String notes=notesController.text;

                          if(notesController.text==null)
                            {
                              notes="no notes";
                            }

                          callWebServiceForsendinfo(
                              nameController.text,
                              streetController.text,
                              buildingController.text,
                              floorController.text,
                              flatController.text,
                              phoneController.text,
                              notes);
                        }
                    },
                    child: Text(
                      "متابعة لانهاء الطلب",
                      style:
                          TextStyle(fontSize: 13.0, fontFamily: 'thesansbold'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget text_field(String txt_n, var con_name, var validate) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, right: 15, left: 15.0),
      height: 40.0,
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return validate;
          } else {
            return null;
          }
        },
        controller: con_name,
        textAlign: TextAlign.right,
        style: TextStyle(fontFamily: 'thesansbold'),
        decoration: InputDecoration(
          hintText: txt_n,
        ),
      ),
    );
  }
}
