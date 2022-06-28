import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CategoryPage.dart';
import 'SignUpPage.dart';

GlobalKey<FormState> formKey = new GlobalKey();

void main() {
  runApp(MyApp());
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
                  print("saved");
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
                      onPressed: () {
                        //  if (formKey.currentState!.validate()) {
                        //  formKey.currentState!.save();
                        //   }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text("Login"),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return SignupPage();
                            },
                          ),
                        );
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
}
