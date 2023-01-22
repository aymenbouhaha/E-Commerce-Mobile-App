import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projet/blocs/favorite_list/favorite_list_cubit.dart';
import 'package:mini_projet/blocs/order/order_cubit.dart';
import 'package:mini_projet/blocs/user/user_cubit.dart';
import 'package:mini_projet/screens/constants/constants.dart';
import 'package:mini_projet/screens/shared/home_screen.dart';
import 'package:mini_projet/services/general_services.dart';

import '../../blocs/product/product_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  void _submit(BuildContext context){
    if(!_formKey.currentState!.validate()){
      return;
    }
    _formKey.currentState!.save();

    
    context.read<UserCubit>().login(email: email!, password: password!);


  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: BlocConsumer<UserCubit,UserState>(
              listener: (prevState , curState){
                if(curState is LoginError){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).errorColor,
                      content: Text(
                        curState.message,
                      ),
                    )
                  );
                }
                if(curState is UserLoggedInState){
                  BlocProvider.of<ProductCubit>(context).getProduct(curState.token);
                  BlocProvider.of<OrderCubit>(context).getOrderList(curState.token);
                  BlocProvider.of<FavoriteListCubit>(context).getFavoriteList(curState.token);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context)=> HomeScreen()
                    )
                  );
                }
              },
              builder: (context, state){
                if( state is LoginLoadingState){
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    top: 8,
                    right: 28,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        // height: screenHeight * 0.01,
                        width: screenWidth,
                      ),
                      const CircleAvatar(
                        foregroundImage: AssetImage("assets/logo.png"),
                        backgroundColor: kDarkPrimaryColor,
                        radius: 140,
                      ),
                      // SizedBox(
                      //   height: screenHeight * 0.03,
                      // ),
                      SizedBox(
                        width: screenWidth,
                        child: const Text(
                          "Se Connecter",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      TextFormField(
                        onSaved: (value){
                          email=value;
                        },
                        textInputAction: TextInputAction.next,
                        style: kCaptionTextStyle,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer votre mail";
                          }
                          if (!GeneralServices.isValidEmail(value)) {
                            return "Le mail n'est pas valide";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Email",
                            contentPadding: const EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      TextFormField(
                        onSaved: (value){
                          password=value;
                        },
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer votre mot de passe";
                          }
                          if (value.length < 8) {
                            return "Le mot de passe doit contenir au min 8 caractères";
                          }
                          return null;
                        },
                        style: kCaptionTextStyle,
                        decoration: InputDecoration(
                            hintText: "Mot De Passe",
                            contentPadding: const EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(width: 0.1, color: kAccentColor),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      Container(
                        width:  screenWidth*0.4,
                        decoration: const BoxDecoration(
                          color: kAccentColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: TextButton(
                          onPressed: (){
                            _submit(context);
                          },
                          child:  Text('Se Connecter' ,style: kButtonTextStyle,),
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ),
        ));
  }
}
