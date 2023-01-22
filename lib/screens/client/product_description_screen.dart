import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projet/blocs/favorite_list/favorite_list_cubit.dart';
import 'package:mini_projet/blocs/order/order_cubit.dart';
import 'package:mini_projet/models/product_model.dart';
import 'package:mini_projet/screens/constants/constants.dart';

import '../../blocs/product/product_cubit.dart';
import '../../blocs/user/user_cubit.dart';

class ProductDescriptionScreen extends StatefulWidget {
  // Product product = Product(
  //     nom: "Nike Air 22",
  //     price: 220,
  //     description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
  //     imageSrc:
  //         "https://images.pexels.com/photos/4263994/pexels-photo-4263994.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  // );
  final Product product;

  ProductDescriptionScreen({Key? key,required this.product}) : super(key: key);

  @override
  _ProductDescriptionScreenState createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Produit"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth,
            ),
            Center(
              child: ClipRRect(
                child: Image.network(
                  "${widget.product.image}",
                  height: screenWidth * 0.8,
                  width: screenWidth,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 8,
              ),
              child: Text(
                "${widget.product.nom}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20 , bottom: 8),
              child: Text(
                "${(widget.product.price).toInt()} TND",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "${widget.product.description}",
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.4
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                      ),
                      width: 280,
                      height: 150,
                    ),
                    SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white
                            ),
                            child: Icon(Icons.favorite_border , size: 30,color: kAccentColor,),
                            height: 60,
                            width: 60,
                          ),
                          onTap: (){
                            String token = (context.read<UserCubit>().state as UserLoggedInState).token;
                            BlocProvider.of<FavoriteListCubit>(context).addProductToFavoriteList(token, widget.product);
                          },
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white
                            ),
                            child: Icon(Icons.add , size: 30,color: kAccentColor,),
                            height: 60,
                            width: 60,
                          ),
                          onTap: (){
                            String token = (context.read<UserCubit>().state as UserLoggedInState).token;
                            BlocProvider.of<OrderCubit>(context).makeOrder(widget.product, token);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )

          ],
        )
    );
  }
}
