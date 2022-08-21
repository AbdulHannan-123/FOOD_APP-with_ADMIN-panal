import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product_model.dart';

class ProductProvider with ChangeNotifier{

  ProductModel ?productModel;

  List<ProductModel> search = [];

  productModels(QueryDocumentSnapshot element){
      productModel = ProductModel(
        productId: element.get("productId"),
        productImage: element.get("productImage"),
        productName: element.get("productName"),
        productPrice: element.get("productPrice"),
        productUnit:  element.get("productUnit")
      );
      search.add(productModel!);
  }
  /////////////////////////////////FOR HERBS ONLY//////////////////////////////////

  List<ProductModel> herbsProductList = [];

   fatchHerbsProductData()async{
    
    List<ProductModel> newList = [];

    QuerySnapshot value= await FirebaseFirestore.instance.collection("HerbsProduct").get();


     value.docs.forEach((element) { 
      productModels(element);
      newList.add(productModel!);
    });
    herbsProductList = newList; 
    notifyListeners();

  }

  List<ProductModel> get getHerbsProductDataList {
    return herbsProductList;
  }
  /////////////////////////////////FOR HERBS ONLY//////////////////////////////////

  List<ProductModel> freshProductList = [];

   fatchFreshProductData()async{
    
    List<ProductModel> newList = [];

    QuerySnapshot value= await FirebaseFirestore.instance.collection("FreshProduct").get();


     value.docs.forEach((element) { 
      
      productModels(element);
      newList.add(productModel!);
    });
    freshProductList = newList; 
    notifyListeners();

  }

  List<ProductModel> get getFreshProductDataList {
    return freshProductList;
  }


  /////////////////////////////////FOR ROOTS ONLY//////////////////////////////////

  List<ProductModel> rootProductList = [];

   fatchRootProductData()async{
    
    List<ProductModel> newList = [];

    QuerySnapshot value= await FirebaseFirestore.instance.collection("RootProduct").get();


     value.docs.forEach((element) { 
      // print(element.data());

      productModels(element);
      newList.add(productModel!);
    });
    rootProductList = newList; 
    notifyListeners();

  }

  List<ProductModel> get getRootProductDataList {
    return rootProductList;
  }



  List<ProductModel> get getAllProductSearch{
    return search;
  }

}