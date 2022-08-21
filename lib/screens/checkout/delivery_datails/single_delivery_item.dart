import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/config/color.dart';

class SingleDeliveryItem extends StatelessWidget {
  
    final String? tital;
    final String? address;
    final String? addresstype;
    final String? number;

    SingleDeliveryItem({
      this.tital,
      this.address,
      this.addresstype,
      this.number
    });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ListTile(
          title : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${tital}"),
              Container(
                width: 60,
                padding: EdgeInsets.all(1),
                height: 20.0,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("${addresstype}",style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),),
                ),
              ),
            ],
          ),
          leading: CircleAvatar(
            radius: 8,
            backgroundColor: primaryColor,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address.toString()),
              SizedBox(height: 5,),
              Text(number.toString()),
              Divider(height: 35,),
            ],
          ),
        ),

      ],
    );
  }
}