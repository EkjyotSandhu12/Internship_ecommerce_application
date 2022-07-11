import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'DetailsPage.dart';
import 'GlobalData.dart';

String catId = "";


class ItemPage extends StatelessWidget {

  String categoryId;

  ItemPage(this.categoryId);

  final Future<List<ItemsList>> list = getData();

  @override
  Widget build(BuildContext context) {

    catId = categoryId;

    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Items'),
        ),
        body: Container(
          child: FutureBuilder<List<ItemsList>>(
            future: list,
            builder: (context, itemData) {
              if (itemData.hasData) {
                return ListView.builder(
                    itemCount: itemData.data!.length,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: itemData.data![position].name,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_SHORT);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(itemData.data![position].name,itemData.data![position].price,itemData.data![position].description)));
                        },
                        child: Card(
                          elevation: 5,
                          child: Row(children: [
                            Image.network(
                              itemData.data![position].image,
                              width: 100,
                              height: 100,
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    itemData.data![position].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                   "Rs. " + itemData.data![position].price,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  itemData.data![position].description,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      );
                    });
              } else {
                return Text(itemData.error.toString());
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<List<ItemsList>> getData() async {
  Map map = {'categoryId': catId};
  var jsonResponse =
  await http.post(Uri.parse(AppUrl.BASE_URL + "getProduct.php"), body: map, headers: {
  'Accept': 'application/json',
  'Access-Control_Allow-origin': '*'
  });

  if (jsonResponse.statusCode == 200) {
    return compute(parseList, jsonResponse.body);
  } else {
    throw Exception("Data Loading Error");
  }
}

List<ItemsList> parseList(String message) {
  final response = json.decode(message).cast<Map<String, dynamic>>();
  return response
      .map<ItemsList>((json) => ItemsList.fromJson(json))
      .toList();
}

class ItemsList {
  String name = "";
  String price = "";
  String description = "";
  String image = "";

  ItemsList({required this.name, required this.image, required this.description, required this.price});

  factory ItemsList.fromJson(Map<String, dynamic> map) {
    return ItemsList(name: map['name'], price: map['price'], description: map['description'], image: map['image']);
  }
}

