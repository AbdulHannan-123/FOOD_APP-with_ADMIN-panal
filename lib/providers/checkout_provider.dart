import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/models/delivery_address.dart';
import 'package:food_app/screens/checkout/add_delivery_address/add_delivery_address.dart';
import 'package:food_app/screens/checkout/delivery_datails/delivery_details.dart';
import 'package:location/location.dart';

class CheckOutProvider with ChangeNotifier{

  bool isloading = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();
  TextEditingController scoiety = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController aera = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController setLocation = TextEditingController();
  LocationData? setLoaction;

  void validator(context, AddressTypes myType) async {
    print(setLoaction);
     if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "firstname is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "lastname is empty");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "mobileNo is empty");
    } else if (scoiety.text.isEmpty) {
      Fluttertoast.showToast(msg: "scoiety is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "street is empty");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "landmark is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "city is empty");
    } else if (aera.text.isEmpty) {
      Fluttertoast.showToast(msg: "aera is empty");
    } else if (pincode.text.isEmpty) {
      Fluttertoast.showToast(msg: "pincode is empty");
    }else if (setLoaction == null) {
      Fluttertoast.showToast(msg: "setLoaction is empty");
    } else{
      isloading = true;
      notifyListeners();
      await FirebaseFirestore.instance.collection("AddDeliveryAddress")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mobileNo": mobileNo.text,
        // "alternateMobileNo": alternateMobileNo.text,
        "scoiety": scoiety.text,
        "street": street.text,
        "landmark": landmark.text,
        "city": city.text,
        "aera": aera.text,
        "pincode": pincode.text,
        // "setLocation":setLocation.text,
        "addressType": myType.toString(),
        "longitude": setLoaction?.longitude,
        "latitude": setLoaction?.latitude,
      }).then((value)async{
        isloading = false;
       await Fluttertoast.showToast(msg: "Add your Delivery Address");
         Navigator.of(context).pop();
         notifyListeners();
      });
      notifyListeners();

    }
  }
  List<DeliveryAddressModel> deliveryAddressList=[];

   getDeliveryAddressData()async{
      List<DeliveryAddressModel> newList=[];

    DeliveryAddressModel deliveryAddressModel;

    DocumentSnapshot _db = await FirebaseFirestore.instance.collection("AddDeliveryAddress")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

    if(_db.exists){
      deliveryAddressModel = DeliveryAddressModel(
        firstname: _db.get("firstname"),
        lastname:  _db.get("lastname"),
        landMark:  _db.get("landmark"),
        society:  _db.get("scoiety"),
        street:  _db.get("street"),
        addressType:  _db.get("addressType"),
        area:  _db.get("aera"),
        mobileNo:  _db.get("mobileNo"),
        city:  _db.get("city"),
        pincode:  _db.get("pincode"),
        
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }
      deliveryAddressList = newList;
      notifyListeners();
  }

  
  List<DeliveryAddressModel> get getDeliveryAddressList{
    return deliveryAddressList;
  }
}