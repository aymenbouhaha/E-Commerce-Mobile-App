import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projet/blocs/favorite_list/favorite_list_cubit.dart';
import 'package:mini_projet/screens/client/product_description_screen.dart';

import '../../models/product_model.dart';

class FavoriteProductScreen extends StatefulWidget {
  const FavoriteProductScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteProductScreen> createState() => _FavoriteProductScreenState();
}

class _FavoriteProductScreenState extends State<FavoriteProductScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor:const Color.fromRGBO(245, 245, 245, 15),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Produit Favoris"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: BlocConsumer<FavoriteListCubit,FavoriteListState>(
              buildWhen: (prevState,currState) => prevState!=currState ,
              listener: (prevState,currState){
                if(currState is FavoriteListErrorState){
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
                if(state is FavoriteListLoadingState){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(state is FavoriteListLoadedState){
                  List<Product> products=state.product;
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
