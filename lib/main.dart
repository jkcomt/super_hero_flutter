import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DetailPage.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
              body1: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 211, 214, 216)))),
      home: SuperHeroList(),
    );
  }
}

class SuperHeroList extends StatefulWidget {
  _SuperHeroListState createState() => _SuperHeroListState();
}

class _SuperHeroListState extends State<SuperHeroList> {
  String url = "http://superherof.herokuapp.com/api/superhero";
  List data;

  @override
  void initState() {
    makeRequest();
  }

  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractData = json.decode(response.body);
      data = extractData["data"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        GradientAppBar(this, "Marvel Heroes"),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [Colors.blueGrey[300], Color(0xFF02040f)])),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, i) {
              String image = data[i]["image"];
              return GestureDetector(
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  color: Color(0xFF291970),
                  child: Row(
                    children: <Widget>[
                      Hero(
                          tag: "superhero$i",
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 8.5,
                                      offset: Offset(6.5, 0))
                                ]),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/thumbnail_$image.jpg',
                                scale: 3.5,
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        data[i]["alias"],
                        style: TextStyle(fontFamily: 'BebasNeue-Regular'),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(data[i], i)));
                },
              );
            },
          ),
        ))
      ],
    ));
  }
}

class GradientAppBar extends StatelessWidget {
  _SuperHeroListState parent;
  final String title;
  final double barHeight = 66.0;
  GradientAppBar(this.parent, this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: barHeight + statusBarHeight,
      child: ListTile(
        contentPadding:
            EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
        title: Center(
          child: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF1c2430), Color(0xFF22007c)],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.5, 0.0),
              stops: [0.0, 0.5],
              tileMode: TileMode.clamp)),
    );
  }
}
