import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/providers/checkout_provider.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/providers/wishlist_provider.dart';
import 'package:food_app/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // ignore: prefer_const_constructors
    options: FirebaseOptions(
        apiKey: "AIzaSyDUEjdwhqEOpZXaro7s5Z5rKCnaZS7ZxW0",
        appId: "",
        messagingSenderId: "",
        projectId: "foodapp-18cbb"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<ProductProvider>(
      create: (BuildContext context)=>ProductProvider(),
      ),
      ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context)=>UserProvider(),
      ),
      ChangeNotifierProvider<ReviewCartProvider>(
      create: (BuildContext context)=>ReviewCartProvider(),
      ),
      ChangeNotifierProvider<WishListProvider>(
      create: (BuildContext context)=>WishListProvider(),
      ),
      ChangeNotifierProvider<CheckOutProvider>(
      create: (BuildContext context)=>CheckOutProvider(),
      )
    ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor, 
        ),
        debugShowCheckedModeBanner: false,
        // home:SignIn(),
        home: SignIn(),
      ),
    );
  }
}
