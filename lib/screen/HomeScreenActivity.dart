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

class HomeScreenActivity extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  HomeScreenActivity({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenActivityState createState() => new _HomeScreenActivityState();
}

class _HomeScreenActivityState extends State<HomeScreenActivity> {
  TextEditingController editingController = TextEditingController();

  // final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  // var items = List<String>();

  List<dynamic> jsonResult;
  List<dynamic> jsonResultOrignal;

  loadJson() async {
    String data = await rootBundle.loadString('assets/users.json');
    jsonResult = json.decode(data)["users"];
    jsonResultOrignal = json.decode(data)["users"];
    print(jsonResult);

    setState(() {});
  }

  dynamic byteToImage(String img64, int i) async {
    // img64 = iVBORw0KGgoAAAANSUhEUgAAB...
    final decodedBytes = base64Decode(img64);

    var file = Io.File("file$i.png");
    return file.writeAsBytesSync(decodedBytes);
  }

  String contactfinder(List list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i]["contact_type"] == "Primary") {
        return list[i]["contact_no"];
      }
    }
    return "null";
  }

  String productfinder(List listFavourite, List listVisited) {
    print("listFavourite :: $listFavourite :: listVisited ::$listVisited");

    String x = "";

    if (listFavourite.isEmpty) {
      for (int i = 0; i < listVisited.length; i++) {
        if (x == "") {
          x = "${listVisited[i]["product_id"]}";
        } else {
          x = "$x, ${listVisited[i]["product_id"]}";
        }
      }
    } else {
      for (int i = 0; i < listVisited.length; i++) {
        for (int j = 0; j < listFavourite.length; j++) {
          if (DeepCollectionEquality()
              .equals(listVisited[i], listFavourite[j])) {
            break;
          } else {
            if (listFavourite.length - 1 == j) {
              if (x == "") {
                x = "${listVisited[i]["product_id"]}";
              } else {
                x = "$x, ${listVisited[i]["product_id"]}";
              }
            }
          }
        }
      }
    }

    return "${x == "" ? "Not Found" : x}";
  }

  SharedPreferences _prefs;




  void initialization() async {
    _prefs = sharedPreferences;

  }

  @override
  initState() {
    super.initState();

    jsonResult = [];
    jsonResultOrignal = [];

    initialization();

    loadJson();

  }

  void filterSearchResults(String query) {
    List<dynamic> dummySearchList = [];
    dummySearchList.addAll(jsonResultOrignal);
    if (query.isNotEmpty) {
      List<dynamic> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item["username"].toLowerCase().contains(query.toLowerCase()) ||
            item["city"].toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        jsonResult.clear();
        jsonResult.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        jsonResult.clear();
        jsonResult.addAll(jsonResultOrignal);
      });
    }
  }


  void alphabetShort() {

    List<dynamic> dummySearchList = [];
    dummySearchList.addAll(jsonResultOrignal);

    dummySearchList.sort((a, b) {



      return a["username"].toLowerCase().compareTo(b["username"].toLowerCase());
    });


    setState(() {
      jsonResult.clear();
      jsonResult.addAll(dummySearchList);
    });

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Center(child: new Text("Home")),
        actions: [IconButton(icon: Icon(Icons.east_outlined), onPressed: (){

          _prefs.clear();
          Navigator.pushNamedAndRemoveUntil(context,
              LoginScreenActivity.routeName, (Route<dynamic> route) => false);
        })],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                          // labelText: "Search",
                          hintText: "Search by name",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                      onPressed: () {
                        alphabetShort();
                      },
                      icon: Icon(Icons.autorenew_outlined),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: jsonResult.length,
                itemBuilder: (context, index) {
                  // return ListTile(
                  //   title: Text('${items[index]}'),
                  // );
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Row(
                      children: [
                        Image.memory(
                          Base64Decoder().convert(
                              jsonResult[index]["profile_pic"].substring(22)),
                          // byteToImage(jsonResult[index]["profile_pic"],index),
                          width: 100,
                          height: 100,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                      "Name : ${jsonResult[index]["username"]}")),
                              Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                      "Email : ${jsonResult[index]["email"]}")),
                              Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                      "Primary Contact : ${contactfinder(jsonResult[index]["contact_numbers"])}")),
                              Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                      "City : ${jsonResult[index]["city"]}")),
                              Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                      "Products he may like : ${productfinder(jsonResult[index]["favourite_products"], jsonResult[index]["visited_products"])}")),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
