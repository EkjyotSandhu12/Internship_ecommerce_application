import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget{

  String itemName;
  String itemPrice;
  String itemDescription;

  DetailsPage(this.itemName, this.itemPrice, this.itemDescription);

  Widget build(BuildContext ctx){

    return Scaffold(

      appBar: AppBar(title: Text(itemName + " Details")),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(ctx).size.height/2 ),
        child: Center(
          child: Container(
            child: Column(
              children: [
                Text(itemName),
                Text("Price: " + itemPrice.toString()),
                Text(itemDescription),
              ],
            ),
          ),
        ),
      ),
    );
  }
}