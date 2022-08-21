import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/my_profile/my_profile.dart';
import 'package:food_app/screens/review_cart/review_cart.dart';
import 'package:food_app/screens/wish_list/wish_list.dart';

import 'home_screen.dart';

class DrawerSide extends StatefulWidget {
  UserProvider? userProvider;
  DrawerSide({this.userProvider});

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile({required IconData icon,required String title ,required Function()? onTap}){
    return ListTile(
      onTap: onTap,
      leading:Icon(icon,size: 32,),
      title: Text(title,style: TextStyle(color: Colors.black45),),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider?.currentUserData;
    return Drawer(
        child: Container(
          color: Color(0xffd1ad17),
          child: ListView(
            children: [
              DrawerHeader(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                       CircleAvatar(
                        backgroundColor: Colors.white54,
                        radius: 43,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xffd6b738),
                          backgroundImage: NetworkImage(userData?.userImage ?? "https://image.shutterstock.com/image-vector/empty-set-null-slashed-zero-260nw-2114797523.jpg"),
                        ),
                
                      ),
                      const SizedBox(height: 20,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Welcome Guests'),
                          const SizedBox(height: 7,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(userData!.userName),
                          Text(userData.userEmail),],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                ),
                
                listTile(icon: Icons.home,title:"Home",
                onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) => HomeScreen()));
                  },  ),
                listTile(
                  icon: Icons.shopping_bag_rounded,
                  title:"Review Cart",
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) => ReviewCart()));
                  }, ),
                listTile(
                  icon: Icons.person,
                  title:"My Profile", 
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) =>MyProfile(userProvider :widget.userProvider)));
                  },
                  ),
                listTile(icon: Icons.notifications,title:"Notifications",onTap: null  ),
                listTile(icon: Icons.star,title:"Rating & Reviwe",onTap: null  ),
                listTile(
                  icon: Icons.thumb_up,
                  title:"WishList",
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) =>WishList()));
                  },  
                  ),
                listTile(icon: Icons.plagiarism_sharp,title:"Raise Complaint",onTap: null ),
                listTile(icon: Icons.remove_from_queue_sharp,title:"FAQ's",onTap: null  ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  
                  height: 350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text('Contect Support'),
                    const SizedBox(height: 10,),
                    Row(
                      children: const [
                        Text('Call Us: '),
                        SizedBox(width: 10,),
                        Text('03352685087'),
                      ],
                    ),
                    SizedBox(height: 5,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: const [
                          Text('Mail Us: '),
                          SizedBox(width: 10,),
                          Text('ah6475774@gmail.com'),
                        ],
                      ),
                    ),
                  ]),
                )

            ],
          ),
        ),
      );
  }
}