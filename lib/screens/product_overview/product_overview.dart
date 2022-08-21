import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/providers/wishlist_provider.dart';
import 'package:food_app/screens/review_cart/review_cart.dart';
import 'package:provider/provider.dart';

import '../../widgets/count.dart';

enum SignCharacter{
  fill, outline
}

class ProductOverview extends StatefulWidget {
  final String productName;
  final String productImage;
  final int productPrice;
  final int? productQuantity;
  final String? productId;

  ProductOverview({required this.productName,required this.productImage, required this.productPrice,required this.productId, this.productQuantity});
  

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {

  final SignCharacter _character= SignCharacter.fill;

  Widget _bottomNavigatorBar({
    required Color iconColor,
    required Color backgroundColor,
    required Color color,
    required String title,
    required IconData iconData,
    void Function()? onTap,
    }){
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(20),
            color: backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconData,size: 20,color: iconColor,),
                SizedBox(width: 5),
                Text(title,style: TextStyle(
                  color: color,
                ),)
              ],
            ),
          ),
        ),
        );
  }
  bool wishListbool= false;
  getWishListBool(){
    FirebaseFirestore.instance.collection("WishList")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("YourWishList")
    .doc(widget.productId)
    .get()
    .then(
      (value) => {
        if(mounted){
          if(value.exists){
          setState((){
            wishListbool = value.get("wishList");
          })
          }
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishListBool();
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          _bottomNavigatorBar(
            iconColor: Colors.grey, 
            backgroundColor: textColor, 
            color: Colors.white70, 
            title: "Add to WishList", 
            iconData: wishListbool? Icons.favorite:Icons.favorite_outline,
            onTap: (){
              setState(() {
                wishListbool= !wishListbool;
              });
              if(wishListbool){
                wishListProvider.addWishListData(
                  wishListId: widget.productId,
                  wishListImage: widget.productImage,
                  wishListName: widget.productName,
                  wishListPrice: widget.productPrice,
                  wishListQuantity: 2
                );
              }else{
                wishListProvider.deletWishList(widget.productId);
              }
            }
            ),
            _bottomNavigatorBar(
            iconColor: Colors.white70, 
            backgroundColor: primaryColor, 
            color: textColor, 
            title: "Go To Cart", 
            iconData: Icons.card_travel_sharp,
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReviewCart()));
            }
            )
        ],
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: textColor,
          ),
          title: Text(
            'Product Over view',style: TextStyle(
              color: textColor,
            ),
          ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.productName),
                    subtitle: Text("\$50"),
                  ),
                  Container(
                    height: 250,
                    padding: EdgeInsets.all(40),
                    child: Image.network(widget.productImage),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Text("Available Options",textAlign: TextAlign.start,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.green[700],
                            ),
                            Radio( 
                              value: SignCharacter.fill,
                              groupValue: _character,
                              activeColor: Colors.green[700],
                              onChanged: (value){
                                setState(() {
                                  _character!=value;
                                });
                              },

                            ),
                          ],
                        ),
                        Text("\$${widget.productPrice}"),
                        Count(
                                    productId: widget.productId,
                                    productImage: widget.productImage,
                                    productName: widget.productName,
                                    productPrice:widget.productPrice,
                                    productUnit: '500 Gram',
                                  ),
                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.grey
                        //     ),
                        //    borderRadius: BorderRadius.circular(30),                           
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(Icons.add,size: 15,color: primaryColor,),
                        //       Text("ADD",style: TextStyle(color: primaryColor),)
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
            ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About this Product",style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,

                  ),),
                  SizedBox(height: 10,),
                  Text("About this Product",style: TextStyle(
                    fontSize: 16.0,
                    color: textColor,
                    

                  ),),
              ]),
            )
            ),
        ],
      ),
    );
  }
}