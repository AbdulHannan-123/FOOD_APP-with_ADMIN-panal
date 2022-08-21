import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/models/delivery_address.dart';
import 'package:food_app/providers/checkout_provider.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/screens/checkout/delivery_datails/single_delivery_item.dart';
import 'package:food_app/screens/checkout/payment_summary/custom_google_pay.dart';
import 'package:food_app/screens/checkout/payment_summary/order_item.dart';
import 'package:provider/provider.dart';

class PaymentSummary extends StatefulWidget {

  final DeliveryAddressModel? deliveryAddressList;

  PaymentSummary({this.deliveryAddressList});

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}
enum AddressTypes{
  Cash_On_Delivery,
  Online_Payment
}

class _PaymentSummaryState extends State<PaymentSummary> {
    var myType = AddressTypes.Cash_On_Delivery;
  @override

  
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    double discount=30;
    double deliveryCharges= 3.7;
    double discountValue;
    double? total;

    double totalPrice = reviewCartProvider.getTotalPrice();
    if(totalPrice > 300){
    discountValue = (totalPrice * discount)/100;
    total = totalPrice - discountValue;

    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Payment Summary",style: TextStyle(
          fontSize: 18,
        ),),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text("\$ ${total ?? totalPrice }",style: TextStyle(
          color: Colors.green[900],
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),),

        trailing: Container(
          width: 160,
          child: MaterialButton(
            color: primaryColor,
            onPressed: (){
              myType == AddressTypes.Online_Payment
              ? Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CustomGooglePay(
                total: total,
              )))
              :Container();
            },
            child: Text("Place Order",style: TextStyle(
              color: textColor,
            ),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10,),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index){
            return Column(
              children:  [
                SingleDeliveryItem(
                address: "area ${widget.deliveryAddressList?.area} , ",
                tital: "${widget.deliveryAddressList?.firstname} ${widget.deliveryAddressList?.lastname}",
                addresstype: widget.deliveryAddressList?.addressType=="AddressType.Other"?"Other" : widget.deliveryAddressList?.addressType=="AddressType.Home" ? "Home" : "Work",
                number: "${widget.deliveryAddressList?.mobileNo}",
              ),
                Divider(),
                ExpansionTile(
                  children: reviewCartProvider.getReviewCartDataList.map((e) {
                    return OrderItem( e: e,);
                  }).toList(),
                  title: Text("Order Item ${reviewCartProvider.getReviewCartDataList.length}  ")
                  ),
                  Divider(),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text("Sub  Total ", style: TextStyle(
                      fontWeight: FontWeight.bold,                      
                    ),),
                    trailing: Text("\$ ${totalPrice+deliveryCharges}", style: TextStyle(
                      fontWeight: FontWeight.bold,                      
                    ),),
                  ),

                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text("Shipping Charges", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]                      
                    ),),
                    trailing: Text("\$ ${deliveryCharges}", style: TextStyle(
                      fontWeight: FontWeight.bold,                      
                    ),),
                  ),

                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text("Compen Discount", style: TextStyle(
                      fontWeight: FontWeight.bold,     
                      color: Colors.grey[600]                   
                    ),),
                    trailing: Text("30% above \$300", style: TextStyle(
                      fontWeight: FontWeight.bold,                      
                    ),),
                  ),
                  Divider(),
                  ListTile(
                    leading: Text("Payment Option"),
                  ),
                   RadioListTile(
                    value: AddressTypes.Cash_On_Delivery, 
                    groupValue: myType, 
                    title: Text("Cash On Delivery"),
                    onChanged: (AddressTypes? value){
                      setState(() {
                        myType = value!;
                      });
                    },
                    secondary: Icon(Icons.money, color: primaryColor,),

                    ),
                    RadioListTile(
                    value: AddressTypes.Online_Payment, 
                    groupValue: myType, 
                    title: Text("Online Payment"),
                    onChanged: (AddressTypes? value){
                      setState(() {
                        myType = value!;
                      });
                    },
                    secondary: Icon(Icons.mobile_friendly_outlined,color: primaryColor,),
                    ), 
              ],
            );
          },
          ),
      ),
    );
  }
}