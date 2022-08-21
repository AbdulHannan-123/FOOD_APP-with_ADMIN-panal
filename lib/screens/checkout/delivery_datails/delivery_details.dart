import 'package:flutter/material.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/models/delivery_address.dart';
import 'package:food_app/providers/checkout_provider.dart';
import 'package:food_app/screens/checkout/add_delivery_address/add_delivery_address.dart';
import 'package:food_app/screens/checkout/delivery_datails/single_delivery_item.dart';
import 'package:food_app/screens/checkout/payment_summary/payment_summary.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {



  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  DeliveryAddressModel? value;
  bool isAddress = false; 

  @override
  Widget build(BuildContext context) {
    CheckOutProvider deliveryaddressProvider = Provider.of(context);
    deliveryaddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Delivery Detals"),
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddDeliveryAddress()));
        },
      ),

      bottomNavigationBar: Container(
        height: 48,
        margin:const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: deliveryaddressProvider.getDeliveryAddressList.isEmpty ?Text("Add new Address"):Text("Payment Summary") ,
          onPressed: (){
            deliveryaddressProvider.getDeliveryAddressList.isEmpty
            ?Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddDeliveryAddress()))
            :Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaymentSummary(
              deliveryAddressList: value,
            )));
          },

          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), 
          ),

          ),

      ),

      body: ListView(
        children: [
          ListTile(
            title: Text("Deliver To"),
            leading: Icon(Icons.add_location_alt_sharp),
          ),

          Divider(
            height: 1.5,
          ),
          deliveryaddressProvider.getDeliveryAddressList.isEmpty
              ?Container(
                child: Center(
                  child:Text("NO DATA")
                ),
              )

          :Column(
            children: 
              deliveryaddressProvider.getDeliveryAddressList.map((e) {
                setState(() {
                  value = e;
                });
                return SingleDeliveryItem(
                address: "area ${e.area} , ",
                tital: "${e.firstname} ${e.lastname}",
                addresstype: e.addressType=="AddressType.Other"?"Other" : e.addressType=="AddressType.Home" ? "Home" : "Work",
                number: "${e.mobileNo}",
              );
              }).toList(),
          )
        ],
      ),
    );
  }
}