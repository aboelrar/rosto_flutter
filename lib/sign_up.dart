import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'login.dart';

class sign_up extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return signup_state();
  }

}

class signup_state extends State<sign_up>
{
  var key = GlobalKey <FormState>();

  //SOMETHING LIKE ID USING TO GET TEXT FROM FIELD
  TextEditingController userController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  Map map=new Map();
  save_user_data(String id) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id", id);
    prefs.setBool("status", true);

  }

  Future<http.Response> callWebServiceForLofinUser(String email,String pass,String phone,String name) async {
    //PROGREES DIAOLG
    ProgressDialog  pr = new ProgressDialog(context);
    pr.style(
        message: 'يرجى الانتظار...',
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
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    pr.show();


    final paramDic = {
      "name": name,
      "mail": email,
      "phone": phone,
      "password": pass,
    };

    final loginData = await http.post(
      "https://webdesign.be4em.info/rosto_api_ar/User/register/549834453/25598",
      body: paramDic,
    );
    if (loginData.statusCode == 200) {
      var data = convert.jsonDecode(loginData.body);
      if(data['status']==1)
      {
        pr.dismiss();
        Toast.show("تم الدخول بنجاح", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        save_user_data(data['id_user']);

        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context)
            {
              return HomeScreen();
            }
        ));
      }
      else if(data['status']==2)
      {
        pr.dismiss();
      Toast.show('${data['message']}', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      return loginData;
    }
    else{
      pr.dismiss();
      return loginData;
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Form(
        key: key,
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("image/splash.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'image/rostologo.png',
                    width: 200.0,
                    height: 150.0,
                  ),
                  text_field('الاسم',userController,false),
                  text_field('رقم الهاتف',phoneController,false),
                  text_field('البريد الالكترونى',emailController,false),
                  text_field('كلمة السر',passController,true),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 40.0, right: 40.0, left: 40.0),
                    height: 40.0,
                    child: FlatButton(
                      color: Colors.white,
                      textColor: Colors.white,
                      disabledColor: Colors.white,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                      child: Text(
                        "تسجيل",
                        style:
                        TextStyle(fontSize: 13.0, fontFamily: 'thesansbold',color: Colors.black),
                      ),
                      onPressed: ()
                      {
                        if(key.currentState.validate())
                        {
                          setState(() {
                            callWebServiceForLofinUser(emailController.text,passController.text,userController.text,phoneController.text);
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0,),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context)
                                {
                                  return login();
                                }
                            ));
                          },
                          child: Text(
                            'تسجيل الدخول؟',
                            style: TextStyle(color: Colors.white, fontSize: 13,fontFamily: 'thesansbold'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget text_field(String txt_n,var con_name,bool status ) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 40.0, right: 40, left: 40.0),
      height: 30.0,
      child: Theme(
        data: theme.copyWith(primaryColor: Colors.white),
        child: TextFormField(
          obscureText: status,
          controller: con_name,
          validator: (String value)
          {
            if(value.isEmpty)
            {
              return 'من فضلك ادخل جميع البيانات';
            }
            else{
              return null;
            }
          },
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: 'thesansbold', color: Colors.white),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
              hintText: txt_n,
              hintStyle: TextStyle(color: Colors.white, fontSize: 13.0)),
        ),
      ),
    );
  }


}