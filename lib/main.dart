import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:food_app/screens/home_screen/home_screen.dart';

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomeScreen(),
    );
  }
}
