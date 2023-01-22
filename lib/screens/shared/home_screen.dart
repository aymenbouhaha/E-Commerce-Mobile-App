import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projet/blocs/user/user_cubit.dart';
import 'package:mini_projet/screens/client/favourite_screen.dart';
import 'package:mini_projet/screens/client/product_description_screen.dart';
import 'package:mini_projet/screens/constants/constants.dart';
import 'package:mini_projet/screens/shared/orders_screen.dart';
import 'package:mini_projet/screens/shared/profile_screen.dart';


import '../../blocs/product/product_cubit.dart';
import '../../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();


}


class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Accueil"),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context)=> FavoriteProductScreen()
                    )
                );
              },
              icon: const Icon(Icons.favorite , color: Colors.red ,size: 40 ,)
          ),
          SizedBox(
            width: screenWidth * 0.03,
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: kAccentColor,
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
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context)=> ProfileScreen()
                          )
                      );
                    },
                    icon: const Icon(Icons.account_circle , size: 40 ,)
                ),
                IconButton(
                  enableFeedback: false,
                    onPressed: (){},
                    icon: const Icon(Icons.home , size: 40 ,)
                ),
                IconButton(
                  enableFeedback: false,
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context)=> OrdersScreen()
                          )
                      );
                    },
                    icon: const Icon(Icons.shopping_cart  ,size: 40 ,)
                ),
              ],
            ),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: BlocConsumer<ProductCubit,ProductState>(
          buildWhen: (prevState,currState) => prevState!=currState ,
          listener: (prevState,currState){
            if(currState is ProductError){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Theme.of(context).errorColor,
                    content: Text(
                      currState.message,
                    ),
                  )
              );
            }
          },
          builder: (context, state) {
            if(state is ProductLoadingState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is ProductLoadedState){
              List<Product> products=state.products;
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15
                  ),
                  itemCount: products.length,
                  itemBuilder: (context , index){
                    return InkWell(
                      enableFeedback: false,
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder:
                                (context) => ProductDescriptionScreen(product:products[index])
                            )
                        );
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
                              foregroundImage: NetworkImage("${products[index].image}"),
                              radius: 60,
                            ),
                            SizedBox(
                              height:screenHeight *0.01,
                            ),
                            Text(
                              "${products[index].nom}" ,
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
                              "${products[index].price} TND" ,
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

                  });
            }
            return Container();

          }),
        )
      );

  }
}

