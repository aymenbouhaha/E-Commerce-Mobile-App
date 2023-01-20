import 'package:flutter/material.dart';
import 'package:mini_projet/models/order_model.dart';
import 'package:mini_projet/models/user_model.dart';
import '../../models/product_model.dart';



class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  List<Order> orders=[
    Order(
        client: User(username: 'Aymen', email: "aymenfzfzfze"),
        product:  Product(nom: "Nike Air 22", price: 220 , imageSrc:"https://images.pexels.com/photos/4263994/pexels-photo-4263994.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" ),
        state: OrderState.refused
    ),
    Order(
        client: User(username: 'Ahmed', email: "aymenfzfzfze"),
        product: Product(nom: "Vans 2001", price: 120, imageSrc: "https://images.pexels.com/photos/8472857/pexels-photo-8472857.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
        state: OrderState.accepted
    ),
    Order(
        client: User(username: 'Anas', email: "aymenfzfzfze"),
        product: Product(nom: "Adidas F20", price: 170, imageSrc: "https://images.pexels.com/photos/684152/pexels-photo-684152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
        state: OrderState.enCours
    ),
    Order(
        client: User(username: 'Oussema', email: "aymenfzfzfze"),
        product: Product(nom: "Nike M32", price: 330, imageSrc: "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
        state: OrderState.accepted
    ),
    Order(
        client: User(username: 'Khaoula', email: "aymenfzfzfze"),
        product: Product(nom: "Vans Dragon 230", price: 190, imageSrc: "https://images.pexels.com/photos/1598508/pexels-photo-1598508.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
        state: OrderState.enCours
    ),

  ];


  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {



  bool isAdmin=true;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Commandes"),
        centerTitle: true,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: (){
            setState(() {
              isAdmin=!isAdmin;
            });
        },
        child: Text("Click Me"),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ListView.builder(
            itemCount: widget.orders.length,
            itemBuilder: (context, index){
              return Container(
                height: 120,
                margin: EdgeInsets.symmetric(vertical: 6) ,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(214, 214, 214, 10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    CircleAvatar(
                      foregroundImage: NetworkImage("${widget.orders[index].product.imageSrc}"),
                      backgroundColor: Colors.white,
                      radius: 40,
                    ),
                    SizedBox(
                      width: screenWidth*0.06,
                    ),
                    Container(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Nom: ${widget.orders[index].product.nom}"),
                          Text("Prix: ${widget.orders[index].product.price} DT"),
                          isAdmin? Text("Client: ${widget.orders[index].client.username}")
                              : Text("Etat: ${widget.orders[index].ConvertOrderState()}")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: isAdmin? screenWidth*0.07 : 0,
                    ),
                    isAdmin?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          // enableFeedback: false,
                          padding: EdgeInsets.zero,
                          iconSize: 45,
                            onPressed: (){},
                            icon: Icon(Icons.check_circle,)
                        ),
                        IconButton(
                          // enableFeedback: false,
                          padding: EdgeInsets.zero,
                          iconSize: 45,
                          onPressed: (){},
                          icon: Icon(Icons.cancel,),
                        )
                      ],
                    ) :
                        Container()

                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
