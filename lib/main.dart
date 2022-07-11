import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'CategoryPage.dart';
import 'GlobalData.dart';
import 'SignUpPage.dart';
import 'SplashScreen.dart';

void main() {
  runApp(SplashApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> formKey = new GlobalKey();
  String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
  String sEmail = "";
  late String sPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Form",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Enter Email Id",
                          labelText: "Email Id",
                        ),
                        validator: (email) {
                          if (email!.isEmpty) {
                            return "Email Id Required";
                          } else if (!RegExp(emailPattern).hasMatch(email)) {
                            return "Valid Email Id Required";
                          }
                        },
                        onSaved: (emailValue) {
                          sEmail = emailValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (password) {
                          if (password!.isEmpty) {
                            return "Password Required";
                          } else if (password.length < 6) {
                            return "Minimum 6 Char Required";
                          }
                        },
                        onSaved: (passwordValue) {
                          sPassword = passwordValue!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Enter Password",
                          labelText: "Password",
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      color: Colors.blueAccent,
                      child: FlatButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              var connectivityResult =
                              await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                  ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                // I am connected to a mobile network.
                                // Fluttertoast.showToast(
                                //     msg: 'Internet/Wifi Connected',
                                //     backgroundColor: Colors.green,
                                //     textColor: Colors.white,
                                //     toastLength: Toast.LENGTH_SHORT);

                                loginData(sEmail, sPassword);
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Internet/Wifi Disconnected',
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    toastLength: Toast.LENGTH_SHORT);
                              }
                              // if (sEmail == "admin@gmail.com" &&
                              //     (sPassword == "admin@007" ||
                              //         sPassword == "admin@123")) {
                              //   //print("Login Successfully \n Email Id Is : " +sEmail +"\n Password Is : " +sPassword);
                              //   print("Login Successfully \n Email Id Is : $sEmail \n Password Is : $sPassword");
                              //   Fluttertoast.showToast(
                              //     msg: "Login Successfully",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     backgroundColor: Colors.black,
                              //     textColor: Colors.white,
                              //     gravity: ToastGravity.TOP,
                              //   );
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => CategoryPage()));
                              //   //HomePage(sEmail, sPassword)
                              // } else {
                              //   print("Email Id & Password Invalid");
                              //   Fluttertoast.showToast(
                              //     msg: "Email Id & Password Invalid",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     backgroundColor: Colors.black,
                              //     textColor: Colors.white,
                              //     gravity: ToastGravity.TOP,
                              //   );
                              // }
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 200,
                      height: 50,
                      color: Colors.blueAccent,
                      child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          child: Text(
                            "Create An Account",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ],
                ))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void loginData(String sEmail, String sPassword) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    Map map = {'email': sEmail, 'password': sPassword};
    var response =
    await http.post(Uri.parse(AppUrl.BASE_URL + "login.php"), body: map);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse["Status"] == true) {
        Fluttertoast.showToast(
            msg: jsonResponse['Message'],
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white);

        String jsonId = jsonResponse['UserData'][0]['id'];
        String jsonName = jsonResponse['UserData'][0]['name'];
        String jsonEmail = jsonResponse['UserData'][0]['email'];
        String jsonContact = jsonResponse['UserData'][0]['contact'];
        String jsonGender = jsonResponse['UserData'][0]['gender'];
        String jsonCity = jsonResponse['UserData'][0]['city'];

        sp.setString(AppUrl.USERID, jsonId);
        sp.setString(AppUrl.NAME, jsonName);
        sp.setString(AppUrl.EMAIL, jsonEmail);
        sp.setString(AppUrl.CONTACT, jsonContact);
        sp.setString(AppUrl.GENDER, jsonGender);
        sp.setString(AppUrl.CITY, jsonCity);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CategoryPage()));

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
        Fluttertoast.showToast(
            msg: jsonResponse['Message'],
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Server Error Code : ${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }
}
