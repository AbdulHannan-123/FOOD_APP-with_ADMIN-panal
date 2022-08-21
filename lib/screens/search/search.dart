import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/widgets/single_item.dart';

import '../../widgets/single_item.dart';

class Search extends StatefulWidget {

  final List<ProductModel> search;

  Search({required this.search});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";

  searchItem(String query){
    List<ProductModel> searchFood=widget.search.where((element){
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }
  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchItem=searchItem(query);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Search'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.menu_rounded),
            )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Items'),
          ),
          Container(
            height: 52,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                print(value);
                setState(() {
                  query= value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(30),
                  borderSide: BorderSide.none,

                  ),
                  fillColor: Color(0xffc2c2c2),
                  filled: true,
                  hintText: "Search for Items",
                  suffixIcon: Icon(Icons.search)
              ),
            ),
          ),
          SizedBox(height: 10,),
          Column(
            children: _searchItem.map((data) {
              return SingleItem(
                isBool: false,
                productImage: data.productImage,
                productName: data.productName,
                productPrice: data.productPrice,
                 onDelete: () {  },
                );
                print(data.productPrice);
            } ).toList(),
          ),
        ],
      ),
    );
  }
}