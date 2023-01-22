import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projet/blocs/order/order_cubit.dart';
import 'package:mini_projet/blocs/user/user_cubit.dart';
import 'package:mini_projet/models/order_model.dart';
import 'package:mini_projet/models/user_model.dart';
import '../../models/product_model.dart';


class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);


  List<Order> orders=[
    // Order(
    //     client: User(username: 'Aymen', email: "aymenfzfzfze"),
    //     product:  Product(nom: "Nike Air 22", price: 220 , imageSrc:"https://images.pexels.com/photos/4263994/pexels-photo-4263994.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" ),
    //     state: OrderClassState.refused
    // ),
    // Order(
    //     client: User(username: 'Ahmed', email: "aymenfzfzfze"),
    //     product: Product(nom: "Vans 2001", price: 120, imageSrc: "https://images.pexels.com/photos/8472857/pexels-photo-8472857.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    //     state: OrderClassState.accepted
    // ),
    // Order(
    //     client: User(username: 'Anas', email: "aymenfzfzfze"),
    //     product: Product(nom: "Adidas F20", price: 170, imageSrc: "https://images.pexels.com/photos/684152/pexels-photo-684152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    //     state: OrderClassState.enCours
    // ),
    // Order(
    //     client: User(username: 'Oussema', email: "aymenfzfzfze"),
    //     product: Product(nom: "Nike M32", price: 330, imageSrc: "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    //     state: OrderClassState.accepted
    // ),
    // Order(
    //     client: User(username: 'Khaoula', email: "aymenfzfzfze"),
    //     product: Product(nom: "Vans Dragon 230", price: 190, imageSrc: "https://images.pexels.com/photos/1598508/pexels-photo-1598508.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    //     state: OrderClassState.enCours
    // ),

  ];


  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {



  @override
  Widget build(BuildContext context) {

    String token = (context.read<UserCubit>().state as UserLoggedInState).token;
    bool isAdmin= (context.read<UserCubit>().state as UserLoggedInState).isAdmin;

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
        child: BlocBuilder<OrderCubit,OrderState>(
          builder: (context, state) {
            if(state is OrderLoadingState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is OrderLoadedState){
              return ListView.builder(
                  itemCount: state.order.length,
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
                            foregroundImage: NetworkImage("${state.order[index].product.image}"),
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
                                Text("Nom: ${state.order[index].product.nom}"),
                                Text("Prix: ${state.order[index].product.price} TND"),
                                isAdmin? Text("Client: ${state.order[index].client.username}")
                                    : Text("Etat: ${state.order[index].state}")
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
                                  onPressed: (){
                                    BlocProvider.of<OrderCubit>(context).changeOrderClassState(state.order[index], "Accepté", token);
                                  },
                                  icon: Icon(Icons.check_circle,)
                              ),
                              IconButton(
// enableFeedback: false,
                                padding: EdgeInsets.zero,
                                iconSize: 45,
                                onPressed: (){
                                  BlocProvider.of<OrderCubit>(context).changeOrderClassState(state.order[index], "Refusé", token);
                                },
                                icon: Icon(Icons.cancel,),
                              )
                            ],
                          ) :
                          Container()
                        ],
                      ),
                    );
                  }
              );
            }
            return Container();
          }),
        )
      );

  }
}

