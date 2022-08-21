import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/config/color.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/home_screen/drawer.dart';

class MyProfile extends StatefulWidget {

  UserProvider? userProvider;

  MyProfile({this.userProvider});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Widget listTile ({IconData? icon , String? title}){
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title??""),
          trailing: Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider!.currentUserData;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        shadowColor: Colors.white,
        elevation: 0.0,
        title: Text('My Profile' , style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),),
      ),
      drawer:DrawerSide(
        userProvider: widget.userProvider,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
               height: 100,
                color: primaryColor,
              ),
              Container(
                height: 548,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                    )
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 250,
                          height: 80,
                          padding: const EdgeInsets.only(left: 20,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(userData!.userName,style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,

                                  ),),
                                  SizedBox(height: 10,),
                                  Text(userData.userEmail,style: TextStyle(

                                  ),)
                                ],
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: primaryColor,
                                child: CircleAvatar(
                                  radius: 12,
                                  child: Icon(Icons.edit,color: primaryColor,),
                                  backgroundColor: scaffoldBackgroundColor ,
                                ),
                                
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    listTile(
                      icon: Icons.shop_outlined,
                      title: "My Order's"
                    ),
                    listTile(
                      icon: Icons.location_on_outlined,
                      title: "My Delivery Address"
                    ),
                    listTile(
                      icon: Icons.person_outlined,
                      title: "Refer a Friend"
                    ),
                    listTile(
                      icon: Icons.file_copy_outlined,
                      title: "Terms and Conditions"
                    ),
                    listTile(
                      icon: Icons.policy_outlined,
                      title: "Privacy Policy"
                    ),
                    listTile(
                      icon: Icons.add_chart_outlined,
                      title: "About"
                    ),
                    listTile(
                      icon: Icons.exit_to_app_outlined,
                      title: "Log Out"
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40,left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: scaffoldBackgroundColor,
                backgroundImage:NetworkImage(userData.userImage),
              ),
            ),
          )
        ],
      ),
    );
  }
}