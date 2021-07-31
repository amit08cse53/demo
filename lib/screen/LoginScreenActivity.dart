import 'package:demo/main.dart';
import 'package:demo/screen/HomeScreenActivity.dart';
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
                              image:
                                  AssetImage('assets/ic_flutter_logo.png')))),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      onSaved: (String value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "User Name is Required";
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
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
                        } else if (value.length < 8) {
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

      _prefs.setBool("isLogin", true);

      Navigator.pushNamedAndRemoveUntil(context, HomeScreenActivity.routeName,
          (Route<dynamic> route) => false);

      // print("Email ${_loginData.email}");
      // print("Password ${_loginData.password}");

      // _parse_Login("${_loginData.email}", "${_loginData.password}");
    } else {
      ///validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
