import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

import 'count.dart';

class SingleItem extends StatefulWidget {
  //  SingleItem({Key? key}) : super(key: key);

  bool ?isBool =false;
  bool ?wishlist= false;
  String ?productImage;
  String ?productName;
  int ?productPrice;
  String ?productId;
  int ?productQuantity;
  var productUnit;
  // Function onDelete;
  void Function()? onDelete;

  SingleItem({
    this.isBool, 
    this.productImage, 
    this.productName, 
    this.productPrice, 
    this.productId, 
    this.productQuantity,
    this.productUnit,
    required this.onDelete,
    this.wishlist,
    });

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  ReviewCartProvider reviewCartProvider = ReviewCartProvider();

  int count=0;
  getCount(){
    setState(() {
      count= widget.productQuantity!;
    });
  }

  // @override
  // void initState() {
  //   getCount();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    getCount();

    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Row(
            children: [
              Expanded(child: Container(
                height: 100,
                child: Center(
                  child: Image.network(widget.productImage??''),
                ),
              ),),
              Expanded(child: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment:widget.isBool==false? MainAxisAlignment.spaceAround : MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(widget.productName.toString(),style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold
                        ),),
                        Text("${widget.productPrice}\$/50 grams",style: TextStyle(
                          color: Colors.grey
                        ),),

                      ],
                    ),
                    widget.isBool==false? GestureDetector(
                      onTap:(){
                                      showModalBottomSheet(
                                        backgroundColor: primaryColor,
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              
                                              ListTile(
                                                title: new Text('50 Gram'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: new Text('500 Gram'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: new Text('1 Kg'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });

                                    },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                             Expanded(
                              child:Text("${widget.productUnit}",style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                
                              ),),
                              ),
                              Center(
                                child: Icon(Icons.arrow_drop_down,size: 20,color: primaryColor,),
                              )
                          ],
                        ),
                      ),
                    ): Text("${widget.productUnit}"),
                  ],
                ),
              ),),
              Expanded(child: Container(
                height: 100,
                padding:widget.isBool==false? EdgeInsets.symmetric(horizontal: 15,vertical: 32):EdgeInsets.only(left: 15,right: 15),
                child:widget.isBool==false? Count(
                                    productId: widget.productId,
                                    productImage: widget.productImage,
                                    productName: widget.productName,
                                    productPrice:widget.productPrice,
                                  ):Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    children: [
                      InkWell
                      (
                        onTap: widget.onDelete,
                        child: const Icon(Icons.delete,size: 30,color: Colors.black54,)
                      ),
                      SizedBox(height: 5,),
                      widget.wishlist==false?Container(
                    height: 25,
                    width: 70,
                    decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              if(count==1){
                                
                                Fluttertoast.showToast(msg: "You reach Minimum Limit");
                              }else{
                                setState(() {
                                  count--;
                                });
                                reviewCartProvider.updateReviewCartData(
                                  cartId: widget.productId,
                                  cartImage: widget.productImage,
                                  cartName: widget.productImage,
                                  cartPrice: widget.productPrice,
                                  cartQuantity: count

                                );
                              }
                            },
                            child: Icon(Icons.remove,size: 20,color: primaryColor,)
                            ),
                          Text("$count",style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                                
                              ),),
                          InkWell(
                            onTap: (){
                              if(count<5){
                                setState(() {
                                  count++;
                                });
                                reviewCartProvider.updateReviewCartData(
                                  cartId: widget.productId,
                                  cartImage: widget.productImage,
                                  cartName: widget.productImage,
                                  cartPrice: widget.productPrice,
                                  cartQuantity: count

                                );
                              }
                            },
                            child: Icon(Icons.add,size: 20,color: primaryColor,)
                            ),
                        ],
                      ),
                    ),
                  )
                  :Container(),
                    ],
                  ),
                ),
              ),),
            ],
          ),
        ),
        
          widget.isBool==false?Container():Divider(height: 1,color: Colors.black45,),
      ],
    );
  }
}