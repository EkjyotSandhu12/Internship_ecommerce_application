import 'package:flutter/material.dart';

import 'DetailsPage.dart';

class ItemPage extends StatelessWidget {
  String categroyName;

  ItemPage(this.categroyName);

  List<Map<String, List<String>>> CategoryItems = [
    {
      'items': ["apple", "apple", "apple", "apple"],
      'price': ["12", "55", "23", "12"],
      'description': [
        "Information",
        "Information",
        "Information",
        "Information"
      ]
    },
    {
      'items': ["lamborghini", "lamborghini", "lamborghini", "lamborghini"],
      'price': ["12", "55", "23", "12"],
      'description': [
        "Information",
        "Information",
        "Information",
        "Information"
      ]
    },
    {
      'items': ["loki", "loki", "loki", "loki"],
      'price': ["12", "55", "23", "12"],
      'description': [
        "Information",
        "Information",
        "Information",
        "Information"
      ]
    }
  ];

  Widget build(BuildContext ctx) {
    var selectedCategory = (categroyName == 'fruits')
        ? 0
        : (categroyName == 'vehicles')
            ? 1
            : 2;

    var itemList = CategoryItems[selectedCategory];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Items")),
        body: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: itemList['items']?.length,
            itemBuilder: (ctx, position) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    ctx,
                    MaterialPageRoute(
                      builder: (_) {
                        return DetailsPage(
                            itemList['items']![position],
                            int.parse(itemList['price']![position]),
                            itemList['description']![position]);
                      },
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.asset(
                        "images/${categroyName}/${itemList['items']![position]}.jpg",
                        width: 150,
                        height: 150,
                      ),
                      Text(itemList['items']![position]),
                      Text(itemList['price']![position]),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
