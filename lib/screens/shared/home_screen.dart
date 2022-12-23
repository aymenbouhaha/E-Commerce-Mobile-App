import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  List<Product> productList=[
    new Product(nom: "Nike Air 22", price: 220 , imageSrc:"https://images.pexels.com/photos/4263994/pexels-photo-4263994.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" ),
    new Product(nom: "Vans 2001", price: 120, imageSrc: "https://images.pexels.com/photos/8472857/pexels-photo-8472857.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    new Product(nom: "Adidas F20", price: 170, imageSrc: "https://images.pexels.com/photos/684152/pexels-photo-684152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    new Product(nom: "Nike M32", price: 330, imageSrc: "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    new Product(nom: "Vans Dragon 230", price: 190, imageSrc: "https://images.pexels.com/photos/1598508/pexels-photo-1598508.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    new Product(nom: "Adidas Predator S62", price: 400, imageSrc: "https://images.pexels.com/photos/1280064/pexels-photo-1280064.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    new Product(nom: "Nike Sunshine", price: 240, imageSrc: "https://images.pexels.com/photos/1598505/pexels-photo-1598505.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
  ];
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:const Color.fromRGBO(245, 245, 245, 15),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Accueil"),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.favorite , color: Colors.red ,size: 40 ,)
          ),
          SizedBox(
            width: screenWidth * 0.03,
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )
        ),
          height: screenHeight * 0.08,
          width: screenWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 30,right: 30,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  enableFeedback: false,
                    onPressed: (){},
                    icon: const Icon(Icons.account_circle , size: 40 ,)
                ),
                IconButton(
                  enableFeedback: false,
                    onPressed: (){},
                    icon: const Icon(Icons.home , size: 40 ,)
                ),
                IconButton(
                  enableFeedback: false,
                    onPressed: (){},
                    icon: const Icon(Icons.shopping_cart  ,size: 40 ,)
                ),
              ],
            ),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15
            ),
            itemCount: widget.productList.length,
            itemBuilder: (context , index){
              return InkWell(
                enableFeedback: false,
                onTap: (){
                },
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      SizedBox(
                        height: 15,
                      ),
                      CircleAvatar(
                        foregroundImage: NetworkImage("${widget.productList[index].imageSrc}"),
                        radius: 60,
                      ),
                      SizedBox(
                        height:screenHeight *0.01,
                      ),
                        Text(
                          "${widget.productList[index].nom}" ,
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(10, 23, 144 , 10)
                        ),
                      ),
                      SizedBox(
                        height: screenHeight *0.01,
                      ),
                       Text(
                        "${widget.productList[index].price} DT" ,
                         textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(7, 29, 220 , 10)
                        ),
                      )

                    ],
                  ),
                ),
              );

            }),
      ),
    );
  }
}

