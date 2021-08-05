import 'package:demo/main.dart';
import 'package:demo/screen/HomeScreenActivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenActivity extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  @override
  _LoginScreenActivityState createState() => _LoginScreenActivityState();
}

class _LoginScreenActivityState extends State<LoginScreenActivity> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SharedPreferences _prefs;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  void initialization() async {
    _prefs = sharedPreferences;
  }

  @override
  initState() {
    super.initState();

    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sample App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _key,
              autovalidate: _validate,
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                          height: 200,
                          child: Image(
                              image: AssetImage('assets/images/login.png')))),
                  InkWell(onLongPress: (){
    // UserName :
    // Password :

    // getDataApi({
    // "UserName": "${}",
    // "Password": "${}"
                    nameController.text = "9426264288";
                    passwordController.text = "123456";


                  },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.redAccent),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      onSaved: (String value) {},
                      validator: (String value) {
                        if (value.length != 10)
                          return 'Mobile Number must be of 10 digit';
                        else
                          return null;
                      },
                      controller: nameController,
                      decoration: new InputDecoration(
                          border:
                              UnderlineInputBorder(borderSide: BorderSide()),
                          errorBorder:
                              UnderlineInputBorder(borderSide: BorderSide()),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Mobile No",
                          counterText: "10"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      onSaved: (String value) {},
                      validator: (String value) {
                        String patttern =
                            r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
                        RegExp regExp = new RegExp(patttern);
                        if (value.isEmpty) {
                          return "Password is Required";
                        } else if (value.length < 4) {
                          return "Password must minimum eight characters";
                        }
                        /*else if (!regExp.hasMatch(value)) {
      return "Password at least one uppercase letter, one lowercase letter and one number";
    }*/
                        return null;
                      },
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text('Login'),
                        onPressed: () {
                          validateForm();

                          print(nameController.text);
                          print(passwordController.text);
                        },
                      )),
                ],
              ),
            )));
  }

  validateForm() {
    if (_key.currentState.validate()) {
      /// No any error in validation
      _key.currentState.save();

      // _prefs.setBool("isLogin", true);

      // Navigator.pushNamedAndRemoveUntil(context, HomeScreenActivity.routeName,
      //     (Route<dynamic> route) => false);

      // print("Email ${_loginData.email}");
      // print("Password ${_loginData.password}");
      // UserName : 	9426264288
      // Password :	123456

       Map<String, dynamic> map= {
        "UserName": "${nameController.text}",
        "Password": "${passwordController.text}"
      };


      getDataApi(map, "api/token");
    } else {
      ///validation error
      setState(() {
        _validate = true;
      });
    }
  }

  Future<dynamic> getDataApi(Map map, String endPoint) async {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        responseHeader: true,
        requestBody: true,
        requestHeader: true,
        error: true,
        request: true));

    var formData = FormData.fromMap(map);
    var response =
        await dio.post('http://115.124.96.40:8099/$endPoint', data: formData);

    print("");
  }
}
