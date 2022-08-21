import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/providers/wishlist_provider.dart';
import 'package:food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  WishListProvider wishListProvider= WishListProvider();
   showAlertDialog(BuildContext context, ProductModel delete) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed:  () {
      wishListProvider.deletWishList(delete.productId);
      Navigator.of(context).pop();
      },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete WishList"),
    content: Text("You want to delete this Product in WishList?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider.getWishListData();
    return Scaffold(

      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("WishList")
      ),
      body: ListView.builder(
        itemCount: wishListProvider.getWishList.length,
        itemBuilder: (context, index) {
          ProductModel data = wishListProvider.getWishList[index];
          return Column(
            children: [
              SizedBox(height: 10,),
          SingleItem(
            wishlist: true,
            isBool: true,
            productImage: data.productImage,
            productName: data.productName,
            productPrice: data.productPrice,
            productId: data.productId,
            productQuantity: data.productQuantity,
            onDelete: (){
              showAlertDialog(context, data);
            },
            ),

            ],
          );
        },
      ),
    );
  }
}