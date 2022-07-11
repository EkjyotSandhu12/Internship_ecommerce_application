import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'GlobalData.dart';
import 'ItemPage.dart';


class CategoryPage extends StatelessWidget {
  final Future<List<CategoryList>> list = getData();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Category'),
        ),
        body: Container(
          child: FutureBuilder<List<CategoryList>>(
            future: list,
            builder: (context, categoryData) {
              if (categoryData.hasData) {
                return ListView.builder(
                    itemCount: categoryData.data!.length,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: categoryData.data![position].name,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_SHORT);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemPage(categoryData.data![position].id)));
                        },
                        child: Card(
                          elevation: 5,
                          child: Row(children: [
                            Image.network(
                              categoryData.data![position].image,
                              width: 100,
                              height: 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                categoryData.data![position].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                        ),
                      );
                    });
              } else {
                return Text(categoryData.error.toString());
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<List<CategoryList>> getData() async {
  var jsonResponse = await http
      .get(Uri.parse(AppUrl.BASE_URL + "getCategory.php"), headers: {
    'Accept': 'application/json',
    'Access-Control_Allow-origin': '*'
  });

  if (jsonResponse.statusCode == 200) {
    return compute(parseList, jsonResponse.body);
  } else {
    throw Exception("Data Loading Error");
  }
}

List<CategoryList> parseList(String message) {
  final response = json.decode(message).cast<Map<String, dynamic>>();
  return response
      .map<CategoryList>((json) => CategoryList.fromJson(json))
      .toList();
}

class CategoryList {
  String id = "";
  String name = "";
  String image = "";

  CategoryList({required this.id, required this.name, required this.image});

  factory CategoryList.fromJson(Map<String, dynamic> map) {
    return CategoryList(id: map['id'], name: map['name'], image: map['image']);
  }
}

