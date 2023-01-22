import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projet/blocs/user/user_cubit.dart';
import 'package:mini_projet/screens/constants/constants.dart';
import 'package:mini_projet/screens/shared/login_screen.dart';

import 'blocs/favorite_list/favorite_list_cubit.dart';
import 'blocs/order/order_cubit.dart';
import 'blocs/product/product_cubit.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
            create: (context)=>UserCubit()
        ),
        BlocProvider<ProductCubit>(
            create: (context)=>ProductCubit()
        ),
        BlocProvider<FavoriteListCubit>(
            create: (context)=>FavoriteListCubit()
        ),
        BlocProvider<OrderCubit>(
            create: (context)=>OrderCubit()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        theme: kDarkTheme,
        home: LoginScreen(),
      ),
    );
  }
}


