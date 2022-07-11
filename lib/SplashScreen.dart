import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internship_personal/GlobalData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CategoryPage.dart';
import 'main.dart';

class SplashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    doSplash();
  }

  Future<Timer> doSplash() async {
    return new Timer(Duration(seconds: 3), afterLoading);
  }

  afterLoading() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.getString(AppUrl.USERID) == null ||
        sp.getString(AppUrl.USERID) == '') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CategoryPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Loading....", style: TextStyle(fontSize: 25)),
          ],
        ),
      ),
    );
  }
}
