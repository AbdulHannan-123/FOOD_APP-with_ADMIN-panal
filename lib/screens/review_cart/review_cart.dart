import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/screens/checkout/delivery_datails/delivery_details.dart';
import 'package:food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatelessWidget {
  // const ReviewCart({Key? key}) : super(key: key);
  ReviewCartProvider reviewCartProvider= ReviewCartProvider(); 

  showAlertDialog(BuildContext context, ReviewCartModel delete) {

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
      reviewCartProvider.reviewCartDataDelete(delete.cartId);
      Navigator.of(context).pop();
      },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete CartProduct"),
    content: Text("You want to delete this Product in Cart?"),
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
    reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: const Text("Total Amount"),
        subtitle: Text("\$ ${reviewCartProvider.getTotalPrice()}",style: TextStyle(color: Colors.green[900]),),
        // ignore: sized_box_for_whitespace
        trailing: Container(
          width: 160.0,
          child: MaterialButton(
            // ignore: sort_child_properties_last
            child: const Text("Submit"),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            ),
            onPressed: (){
              if(reviewCartProvider.getReviewCartDataList.isEmpty){
                 Fluttertoast.showToast(msg: "No Cart Dta Found");
              }else{
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DeliveryDetails()));
                }
            },
            ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Review Cart",
        )
      ),
      body:reviewCartProvider.getReviewCartDataList.isEmpty?const Center(
        child: Text("NO DATA"),
      ): ListView.builder(
        itemCount: reviewCartProvider.getReviewCartDataList.length,
        itemBuilder: (context, index) {
          ReviewCartModel data = reviewCartProvider.getReviewCartDataList[index];
          return Column(
            children: [
              const SizedBox(height: 10,),
          SingleItem(
            wishlist: false,
            isBool: true,
            productImage: data.cartImage,
            productName: data.cartName,
            productPrice: data.cartPrice,
            productId: data.cartId,
            productQuantity: data.cartQuantity,
            productUnit: data.cartUnit,
            onDelete: (){
              showAlertDialog(context,data);
            },
            ),

            ],
          );
        },
      ),
    );
  }
}