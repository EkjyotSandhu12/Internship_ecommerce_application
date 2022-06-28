import 'package:flutter/material.dart';

import 'ItemPage.dart';

List<String> Category = ["fruits", "vegetables", "vehicles"];

class CategoryPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("category page")),
        body: GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: 3,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.4),
            itemBuilder: (_, position) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ItemPage(Category[position]),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Image.asset("images/${Category[position]}.jpg",
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width / 2,
                            height: 100),
                        Text(Category[position]),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
