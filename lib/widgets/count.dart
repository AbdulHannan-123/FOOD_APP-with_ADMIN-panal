import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {

  String? productName;
  String? productImage;
  String? productId;
  int? productPrice;
  var productUnit;


  Count({this.productId, this.productImage, this.productName, this.productPrice, this.productUnit});


  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {

  int count = 1;
  bool isTrue= false;

  getAddandQuantity(){
    FirebaseFirestore.instance.collection("ReviewCart")
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .collection("YourReviewCart")
    .doc(widget.productId)
    .get()
    .then((value) => {
      if(this.mounted){
        if(value.exists){
          setState((){
            count = value.get("cartQuantity");
            isTrue =value.get("isAdd");
          }),
        }
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    getAddandQuantity();
    ReviewCartProvider reviewCartProvider= Provider.of(context);
    return Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                       child: isTrue==true? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:[
                                          InkWell(
                                            onTap: () {
                                              if(count == 1){
                                              setState(() {
                                                isTrue = false;
                                              });
                                              
                                              reviewCartProvider.reviewCartDataDelete(widget.productId); 
                                            }if(count>1){
                                              setState(() {
                                                count--;
                                              });
                                              reviewCartProvider.updateReviewCartData(
                                                cartId: widget.productId,
                                                cartImage: widget.productImage,
                                                cartName: widget.productName,
                                                cartPrice: widget.productPrice,
                                                cartQuantity: count,
                                              );
                                            }

                                            },
                                            child: Icon(Icons.remove,size: 15,color: Color(0xffd6b738),)),
                                             Text("$count",style: TextStyle(fontWeight: FontWeight.bold),),
                                           InkWell(
                                            onTap:(){
                                              setState(() {
                                                count++;
                                              });
                                              reviewCartProvider.updateReviewCartData(
                                                cartId: widget.productId,
                                                cartImage: widget.productImage,
                                                cartName: widget.productName,
                                                cartPrice: widget.productPrice,
                                                cartQuantity: count,
                                              );
                                            },
                                            child: Icon(Icons.add,size: 15,color: Color(0xffd6b738),))
                                        ],
                                       ):Center(
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              isTrue=true;
                                            });
                                            reviewCartProvider.addReviewCartData(
                                              cartId: widget.productId,
                                              cartImage: widget.productImage,
                                              cartName: widget.productName,
                                              cartPrice: widget.productPrice,
                                              cartQuantity: count,
                                              cartUnit: widget.productUnit
                                            );
                                          },
                                          child: Text("ADD",style: TextStyle(
                                            color: primaryColor,
                                          ),),
                                        ),
                                       ),  
                                  );
  }
}