import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => SignupState();
}

class SignupState extends State<SignupPage> {
  GlobalKey<FormState> formKey = new GlobalKey();
  String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
  String sEmail = "";
  String sName = "";
  late String sPassword;
  String sContact = "";

  int radioGroupValue = 0;

  List<String> cityArray = ["Ahmedabad", "Vadodara", "Surat", "Rajkot"];
  String sCity = "Ahmedabad";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Signup",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
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
                        hintText: "Enter Name",
                        labelText: "Name",
                      ),
                      validator: (name) {
                        if (name!.isEmpty) {
                          return "Name Required";
                        }
                      },
                      onSaved: (nameValue) {
                        sName = nameValue!;
                      },
                    ),
                  ),
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
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      validator: (contact) {
                        if (contact!.isEmpty) {
                          return "Contact No. Required";
                        } else if (contact.length < 10) {
                          return "Valid Contact No. Required";
                        }
                      },
                      onSaved: (contactValue) {
                        sContact = contactValue!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: "Enter Contact No.",
                        labelText: "Contact No.",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.number,
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
                  Row(
                    children: [
                      Radio(
                          value: 0,
                          groupValue: radioGroupValue,
                          onChanged: (radioValue) {
                            setState(() {
                              print("Male");
                              radioGroupValue = 0;
                            });
                          }),
                      Text("Male")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: 1,
                          groupValue: radioGroupValue,
                          onChanged: (radioValue) {
                            setState(() {
                              print(radioValue);
                              radioGroupValue = 1;
                            });
                          }),
                      Text("Female")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: 2,
                          groupValue: radioGroupValue,
                          onChanged: (radioValue) {
                            setState(() {
                              radioGroupValue = 2;
                              print("Transgender");
                            });
                          }),
                      Text("Transgender")
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'City',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: DropdownButton(
                          items: cityArray.map((String cityValue) {
                            return DropdownMenuItem(
                              child: Text(cityValue),
                              value: cityValue,
                            );
                          }).toList(),
                          onChanged: (cityValue) {
                            setState(() {
                              sCity = cityValue as String;
                              print(sCity);
                            });
                          },
                          value: sCity,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    color: Colors.blueAccent,
                    child: FlatButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                          }
                        },
                        child: Text(
                          "Signup",
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
