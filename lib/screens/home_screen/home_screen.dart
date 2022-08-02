import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget singleProduct(){
    return Container(
                  margin:EdgeInsets.symmetric(horizontal: 10) ,
                  height: 230,
                  width: 160,
                  decoration: BoxDecoration(
                  color: Color(0xffd9d8d9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Expanded(
                      flex: 2,
                      child: 
                      Image.network('https://pngimg.com/uploads/spinach/spinach_PNG10.png')
                      ),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Fresh Basil',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          const Text('50\$/50 grem ',style: TextStyle(color: Colors.grey),),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 4),
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: const [
                                        Expanded(child:Text('50 gram',style: TextStyle(fontSize: 10),)),
                                        Center(child:Icon(Icons.arrow_drop_down,color: Color(0xffd6b738),))
                                      ],
                                    )
                                  ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Expanded(
                                  child: Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                       child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Icon(Icons.remove,size: 15,color: Color(0xffd6b738),),
                                          Text('1',style: TextStyle(fontWeight: FontWeight.bold),),
                                          Icon(Icons.add,size: 15,color: Color(0xffd6b738),)
                                        ],
                                       ),  
                                  ),
                                  )
                              ],
                            ),
                          )
                         
                        ],
                      ),
                    ))
                  ]),
                );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      drawer: const Drawer(),
      appBar: AppBar(

        backgroundColor:const Color(0xffd6b738),
        title:const Text('HOME',style: TextStyle(
          
        ),),
        actions:const [
          CircleAvatar(
            backgroundColor: Color(0xffd4d181),
            child: Icon(Icons.search_rounded,color: Colors.white,),
          ),
          SizedBox(width: 10.0,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: CircleAvatar(
              backgroundColor: Color(0xffd4d181),
              child: Icon(Icons.shopping_bag,color: Colors.white,),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Herbs Seasoning',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),),

                  Text('View all',style: TextStyle(
                    color: Colors.grey
                  ),),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
              children: [
                singleProduct(),
                singleProduct(),
                singleProduct(),
                singleProduct()
              ],
            )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Fresh Fruits',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),),

                  Text('View all',style: TextStyle(
                    color: Colors.grey
                  ),),
                ],
              ),
            ),
             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
              children: [
                singleProduct(),
                singleProduct(),
                singleProduct(),
                singleProduct()
              ],
            )
            ),

          ],
        ),
      ),
    );
  }
}