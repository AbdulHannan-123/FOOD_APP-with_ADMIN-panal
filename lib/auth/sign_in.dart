import 'package:decorated_text/decorated_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/home_screen/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  UserProvider ?userProvider;

    Future<User?> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      //  print("signed in ${user?.displayName}");
      userProvider!.addUserData(
        currentUser: user,
        userEmail: user?.email,
        userImage: user?.photoURL,
        userName: user?.displayName,
      );

      return user;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:AssetImage('assets/background.png'), 
            fit: BoxFit.cover
          )
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: 400.0,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Sign In to Continue', style: TextStyle(color: Colors.grey),),
                  // const Text('Vegi',style: TextStyle(
                  //   fontSize: 50.0,
                  //   color: Colors.white,
                  //   shadows: [
                  //     BoxShadow(
                  //       blurRadius: 5,
                  //       color: Colors.green,
                  //       offset: Offset(3,3),
                  //     )
                  //   ],
                  // ),
                  // ),
                  DecoratedText(
                    'Vegi',
                    borderColor: Colors.green[900],
                    borderWidth: 5,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    shadows: const [
                      Shadow(
                          color: Colors.black, blurRadius: 4, offset: Offset(4, 4))
                    ],
                    fillGradient: const LinearGradient(colors: [Colors.white54, Colors.green]),
                  ),

                  Column(
                    children: [
                      SignInButton(
                        Buttons.Apple,
                        text: "Sign in with Apple",
                        onPressed: () {},
                      ),

                      SignInButton(
                        Buttons.Google,
                        text: "Sign in with Google",
                        onPressed: () {
                          // ignore: prefer_const_constructors
                          _googleSignUp().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen())));
                        },
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Text('By Signing In You are agreeing our',style: TextStyle(color: Colors.grey[800]),),
                      Text('Terms and Privacy Policy',style: TextStyle(color: Colors.grey[800]),),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}