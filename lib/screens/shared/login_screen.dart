import 'package:flutter/material.dart';
import 'package:mini_projet/services/general_services.dart';

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
            child: Padding(
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
                    backgroundColor: Colors.white,
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
                    style: const TextStyle(fontSize: 21),
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
                    style: const TextStyle(fontSize: 21),
                    decoration: InputDecoration(
                        hintText: "Mot De Passe",
                        contentPadding: const EdgeInsets.only(left: 20, right: 20),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Container(
                    width:  screenWidth*0.4,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextButton(
                      onPressed: (){
                        _submit(context);
                      },
                      child: const Text('Se Connecter' ,style: TextStyle(color: Colors.white),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
