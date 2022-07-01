import 'dart:async';

import 'package:flutter/material.dart';

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
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Loading....",style: TextStyle(fontSize: 25)),
          ],
        ),
      ),
    );
  }
}
