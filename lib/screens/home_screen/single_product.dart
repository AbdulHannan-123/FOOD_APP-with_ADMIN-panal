// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/widgets/count.dart';
import 'package:food_app/widgets/product_unit.dart';

class SingleProduct extends StatefulWidget {
  // const SingleProduct({Key? key}) : super(key: key);
  final String productImage; 
  final String productName;
  final int productPrice;
  final VoidCallback? onTap;
  final String? productId;
  final ProductModel? productUnit;

  SingleProduct({
    required this.productImage,
    required this.productName,
    required this. productPrice,
    required this.onTap,
    this.productUnit,
    this.productId
  });

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  var unitData;
  var firstValue;
  @override
  Widget build(BuildContext context) {
    widget.productUnit!.productUnit!.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
    return Container(
                  margin:EdgeInsets.symmetric(horizontal: 10) ,
                  height: 230,
                  width: 160,
                  decoration: BoxDecoration(
                  color: Color(0xffd9d8d9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Container(
                          height: 150,
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          child: Image.network(
                            widget.productImage,
                          ),
                        ),
                      ),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(widget.productName,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                           Text('${widget.productPrice}\$/${unitData ?? firstValue} ',style: const TextStyle(color: Colors.grey),),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ProductUnit(
                                    onTap: (){
                                      showModalBottomSheet(
                                        backgroundColor: primaryColor,
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: widget.productUnit!.productUnit!.map<Widget>((data){
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                                    child: InkWell(
                                                      onTap: ()async{
                                                        setState(() {
                                                          unitData = data;
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text(
                                                        data,
                                                        style: TextStyle(
                                                          color: Colors.white54,
                                                          fontSize: 18,

                                                        ),
                                                        ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            }).toList(),

                                          );
                                        });
                                    },
                                    title: unitData ?? firstValue,
                                  ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Expanded(
                                    child: Count(
                                      productId: widget.productId,
                                      productImage: widget.productImage,
                                      productName: widget.productName,
                                      productPrice: widget.productPrice,
                                      productUnit: unitData ?? firstValue,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                  ]),
                );
  }
}
