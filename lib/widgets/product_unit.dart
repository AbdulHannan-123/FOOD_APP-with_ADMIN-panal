import 'package:flutter/material.dart';
import 'package:food_app/config/color.dart';

class ProductUnit extends StatelessWidget {
  final void Function()? onTap;
  final String? title;

  ProductUnit({this.onTap,this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell( 
                                    onTap:onTap,
                                    child: Container(
                                      
                                      padding: const EdgeInsets.only(left: 4),
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children:  [
                                          Expanded(child:Text('$title',style: TextStyle(fontSize: 10),)),
                                          Center(child:Icon(Icons.arrow_drop_down,color: Color(0xffd6b738),))
                                        ],
                                      )
                                    ),
                                  );
  }
}