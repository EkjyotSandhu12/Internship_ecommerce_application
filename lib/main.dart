import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internship_personal/GlobalData.dart';

import 'CategoryPage.dart';
import 'SignUpPage.dart';
import 'SplashScreen.dart';

GlobalKey<FormState> formKey = new GlobalKey();

void main() {
  runApp(SplashApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: "Login Form",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  State<MyHomePage> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {

  String sPassword = '';
  String sEmail = '';

  Widget build(BuildContext btx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Login form"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onSaved: (email) {
                  sEmail = email!;
                },
                validator: (email) {
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(email!)) {
                    return "Enter Valid Email Id";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Email Id",
                  icon: Icon(Icons.email),
                  hintText: "Enter Email Id",
                ),
              ),
              TextFormField(
                obscureText: true,
                onChanged: (password){
                  sPassword = password;
                },
                validator: (pass) {
                  if (pass!.isEmpty) {
                    return "You cant keep this field empty";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Password",
                  icon: Icon(Icons.email),
                  hintText: "Password",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          var connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResult == ConnectivityResult.mobile ||
                              connectivityResult == ConnectivityResult.wifi) {
                            loginData(sEmail, sPassword);
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CategoryPage(),
                              ),
                            );*/
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Please Check Your Internet Connection")));
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text("Login"),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return SignupPage();
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Please Check Your Internet Connection")));
                        }
                      },
                      child: Text("Sign Up")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginData(String sEmail, String sPassword) async {
    Map map = {'email': sEmail, 'password': sPassword};
     var response = await http.post(Uri.parse(GlobalData.BASE_URL + "login.php"),
        body: map);
    /*if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse["Status"] == true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(jsonResponse['Message'])));

        String jsonId = jsonResponse['UserData'][0]['Userid'];
        String jsonName = jsonResponse['UserData'][0]['Name'];
        String jsonEmail = jsonResponse['UserData'][0]['Email'];
        String jsonContact = jsonResponse['UserData'][0]['Contact'];
        String jsonGender = jsonResponse['UserData'][0]['Gender'];
        String jsonCity = jsonResponse['UserData'][0]['City'];

        print(jsonId +
            "\n" +
            jsonName +
            "\n" +
            jsonEmail +
            "\n" +
            jsonContact +
            "\n" +
            jsonGender +
            "\n" +
            jsonCity);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(jsonResponse['Message'])));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Server Error Code : ${response.statusCode}')));
    }*/
  }
}
