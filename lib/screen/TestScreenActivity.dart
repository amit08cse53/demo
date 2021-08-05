import 'dart:convert';
import 'dart:typed_data';

import 'package:demo/main.dart';
import 'package:demo/screen/LoginScreenActivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io' as Io;
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScreenActivity extends StatefulWidget {
  static const String routeName = 'TestScreen';

  TestScreenActivity({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TestScreenActivityState createState() => new _TestScreenActivityState();
}

class _TestScreenActivityState extends State<TestScreenActivity> {



  @override
  initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Center(child: new Text("Test")),
      ),
      body: Column(
        children: <Widget>[
         Container(height: 150,),
         Container(height: 200,child: FlatButton(onPressed: (){}, child: Text("dfd"),minWidth: double.infinity,),)
        ],
      ),
    );
  }
}
