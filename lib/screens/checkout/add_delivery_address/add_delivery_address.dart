import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/providers/checkout_provider.dart';
import 'package:food_app/screens/checkout/google_map/google_map.dart';
import 'package:food_app/widgets/cumtome_text_field.dart';
import 'package:provider/provider.dart';

class AddDeliveryAddress extends StatefulWidget {

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

enum AddressTypes{
  Home,
  Work,
  Others,
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    // var addressType = AddressTypes.Home=="";
    CheckOutProvider checkOutProvider = Provider.of(context);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Add Delivery Address",style: TextStyle(fontSize: 18),),
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child:checkOutProvider.isloading== false? MaterialButton(
          onPressed: (){
            checkOutProvider.validator(context,myType);
          },
          child: const Text("Add Address",style: TextStyle(
            // color: textColor,
          ),),
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),

        ):Center(
          child: CircularProgressIndicator(),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,),
        child: ListView(
          children: [
            CostumTextField(
              labtext: "First Name",
              controller: checkOutProvider.firstName,
            ),
            CostumTextField(
              labtext: "Last Name",
              controller: checkOutProvider.lastName,
            ), 
            CostumTextField(
              labtext: "Mobile No",
              controller: checkOutProvider.mobileNo,
            ), 
            CostumTextField(
              labtext: "Society",
              controller: checkOutProvider.scoiety,
            ), 
            CostumTextField(
              labtext: "Street",
              controller: checkOutProvider.street,
            ), 
            CostumTextField(
              labtext: "LandMark",
              controller: checkOutProvider.landmark,
            ), 
            CostumTextField(
              labtext: "City",
              controller: checkOutProvider.city,
            ), 
            CostumTextField(
              labtext: "Area",
              controller: checkOutProvider.aera,
            ), 
            CostumTextField(
              labtext: "Postal Code",
              controller: checkOutProvider.pincode,
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>CustomGoogleMap()));
                
              },
              child: Container(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,                  
                  children: [
                    checkOutProvider.setLoaction == null
                    ?Text("Set Location")
                    :Text("You'r Done")

                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black
            ),
            ListTile(
            title: Text("Address Type* "),
            ),
            RadioListTile(
              value: AddressTypes.Home, 
              groupValue: myType, 
              title: Text("Home"),
              onChanged: (AddressTypes? value){
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(Icons.home, color: primaryColor,),

              ),
              RadioListTile(
              value: AddressTypes.Work, 
              groupValue: myType, 
              title: Text("Work"),
              onChanged: (AddressTypes? value){
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(Icons.work_outlined, color: primaryColor,),
              ), 

              RadioListTile(
              value: AddressTypes.Others, 
              groupValue: myType, 
              title: Text("Others"),
              onChanged: (AddressTypes? value){
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(Icons.other_houses_outlined, color: primaryColor,),
              ),       
              ],
        ),
      ),
    );
  }
}