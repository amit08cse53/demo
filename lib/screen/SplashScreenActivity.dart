import 'dart:async';

import 'package:demo/main.dart';
import 'package:demo/screen/HomeScreenActivity.dart';
import 'package:demo/screen/LoginScreenActivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenActivity extends StatefulWidget {
  static const String routeName = '/';

  SplashScreenActivity({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SplashScreenActivityState createState() => _SplashScreenActivityState();
}

class _SplashScreenActivityState extends State<SplashScreenActivity> {
  SharedPreferences _prefs;

  void initialization() async {
    _prefs = sharedPreferences = await SharedPreferences.getInstance();

    _waitFornavigationPage();
  }

  @override
  initState() {
    super.initState();

    initialization();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the SplashScreenActivity object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: 200,
                child: Image(image: AssetImage('assets/ic_flutter_logo.png'))),
          ],
        ),
      ),
    );
  }

  _waitFornavigationPage() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  Future navigationPage() async {
    // Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);

    if (_prefs.getBool("isLogin") ?? false) {
      Navigator.pushReplacementNamed(context, HomeScreenActivity.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreenActivity.routeName);
    }
  }
}
