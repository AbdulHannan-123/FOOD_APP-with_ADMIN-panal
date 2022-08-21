import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/home_screen/drawer.dart';
import 'package:food_app/screens/home_screen/single_product.dart';
import 'package:food_app/screens/product_overview/product_overview.dart';
import 'package:food_app/screens/review_cart/review_cart.dart';
import 'package:food_app/screens/search/search.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 ProductProvider ?productProvider;
  
  Widget listTile({required IconData icon,required String title}){
    return ListTile(
      leading:Icon(icon,size: 32,),
      title: Text(title,style: TextStyle(color: Colors.black45),),
    );
  }

  Widget _buildHerbsProduct(context){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const Text('Herbs Seasoning',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder:(context)=> Search(
                        search: productProvider!.getHerbsProductDataList,
                      )));
                    },
                    child: Text('View all',style: TextStyle(
                      color: Colors.grey
                    ),),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:  productProvider!.getHerbsProductDataList.
                map(
                  (herbsProductData){  
                   return SingleProduct(
                    productId: herbsProductData.productId,
                    productName: herbsProductData.productName,
                    productImage:herbsProductData.productImage,
                    productPrice: herbsProductData.productPrice,
                    productUnit: herbsProductData,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductOverview(
                    productImage:herbsProductData.productImage,
                    productName: herbsProductData.productName,
                    productPrice: herbsProductData.productPrice,
                    productId: herbsProductData.productId,
                  )));
                },
                );
                  
                }).toList(),

            )
            ),
      ],
    );
  }

  Widget _buildFreshFruits(context){
    return Column(
      children: [
        Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Fresh Fruits',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder:(context)=> Search(
                        search: productProvider!.getFreshProductDataList,
                      )));
                    },
                    child: Text('View all',style: TextStyle(
                      color: Colors.grey
                    ),),
                  ),
                ],
              ),
            ),
             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:  productProvider!.getFreshProductDataList.
                map(
                  (freshProductData){  
                   return SingleProduct(
                    productId: freshProductData.productId,
                    productName: freshProductData.productName,
                    productImage:freshProductData.productImage,
                    productPrice: freshProductData.productPrice,
                    productUnit: freshProductData,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductOverview(
                    productImage:freshProductData.productImage,
                    productName: freshProductData.productName,
                    productPrice: freshProductData.productPrice,
                    productId: freshProductData.productId,
                  )));
                },
                );
                  
                }).toList(),

            )
            ),

      ],
    );
  }

  Widget _buildRootFruits(context){
    return Column(
      children: [
        Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text('Root Products',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder:(context)=> Search(
                        search: productProvider!.getRootProductDataList,
                      )));
                    },
                    child: Text('View all',style: TextStyle(
                      color: Colors.grey
                    ),),
                  ),
                ],
              ),
            ),
             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:  productProvider!.getRootProductDataList.
                map(
                  (rootProductData){  
                   return SingleProduct(
                    productId: rootProductData.productId,
                    productName: rootProductData.productName,
                    productImage:rootProductData.productImage,
                    productPrice: rootProductData.productPrice,
                    productUnit: rootProductData,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductOverview(
                    productImage:rootProductData.productImage,
                    productName: rootProductData.productName,
                    productPrice: rootProductData.productPrice,
                    productId: rootProductData.productId,
                  )));
                },
                );
                  
                }).toList(),

            )
            ),

      ],
    );
  }
  @override
  void initState() {
    ProductProvider initproductProvider = Provider.of(context,listen: false);
    initproductProvider.fatchHerbsProductData();
    initproductProvider.fatchFreshProductData();
    initproductProvider.fatchRootProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider= Provider.of(context);
    userProvider.getUserData();
 
    return Scaffold(
      backgroundColor:const Color(0xffcbcbcb),
      drawer:DrawerSide(userProvider:userProvider),
      appBar: AppBar(

        backgroundColor:const Color(0xffd6b738),
        title:const Text('HOME',style: TextStyle(
          
        ),),
        actions: [
          CircleAvatar(
            backgroundColor: const Color(0xffd4d181),
            child: IconButton(
              icon: const Icon(Icons.search_rounded),
              color: Colors.white,
               onPressed:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search(
                  search: productProvider!.getAllProductSearch,
                )));
               },
              ),
          ),
          const SizedBox(width: 10.0,),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReviewCart()));
              },
              child:const CircleAvatar(
                backgroundColor: Color(0xffd4d181),
                child: Icon(Icons.shopping_bag,color: Colors.white,),
                ),
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        child: ListView(
          children: [
            
            Stack(children: <Widget>[
          
        Container(
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi0Xg-k622Sbztlrb-L1o1CAla3zCbVc2lUw&usqp=CAU'),
            //       ),
            ),
          ),

          height: 150.0,
        ),
        Container(
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.centerRight,
                  end: FractionalOffset.centerLeft,
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.black,
                  ],
                  stops: const [
                    0.0,
                    1.0
                  ])),
          child: Row(
            children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.red,  //// to check the container
                      child: Column(children: [
                        Padding(
                          
                          padding: const EdgeInsets.only(right: 140.0),
                          child: Container(
                            height: 50.0,
                            width: 100.0,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50.0),
                                bottomLeft: Radius.circular(50.0),
                                // topLeft: Radius.circular(),
                              ),
                              
                            color: Color(0xffd6b738),
                            ),
                            child:
                              Center(
                                
                                child: DecoratedText(
                                  'Vegi',
                                  borderColor: Colors.green[900],
                                  borderWidth: 2,
                                  
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  shadows: const [
                                    Shadow(
                                        color: Colors.black, blurRadius: 4, offset: Offset(4, 4))
                                  ],
                                  fillGradient: const LinearGradient(colors: [Colors.white54, Colors.green]),
                                ),
                              ),
                            ),
                          ),
                          const Text("30% OFF",style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            // fontStyle: FontStyle.italic,
                          ),),
                          const Text("On all Vegetales Product",style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,                          
                          ),)
                      ]),
                    ),
                    ),
              Expanded(child: Container(),)
            ],
          ),            
        )
      ]),
            _buildHerbsProduct(context),
            _buildFreshFruits(context),
            _buildRootFruits(context)
          ],
        ),
      ),
    );
  }
}