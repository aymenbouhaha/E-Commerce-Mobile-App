import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mini_projet/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {


  UserCubit() : super(UserInitState());


  login({required String email,required String password}) async {
    Uri uri = Uri.parse("https://7856-196-187-158-182.eu.ngrok.io/user/login");
    emit(LoginLoadingState());
    var response = await http.post(
      uri,
      body: {
        "email" : email,
        "password" : password
      });
    if (response.statusCode>=200 && response.statusCode<=299){
      final respJson = json.decode(response.body);
      Map<String, dynamic> userInfo = JwtDecoder.decode(respJson["token"]);
      int id= userInfo["id"];
      String username = userInfo["username"];
      String email= userInfo["email"];
      String role = userInfo["role"];
      String phoneNumber = userInfo["phoneNumber"];
      String image = userInfo["image"];
      User user = User(id: id,username: username , email: email , role: role, phoneNumber: phoneNumber , imageSrc: image);
      emit(UserLoggedInState(user: user, token: respJson["token"]));

    }else {
      final respJson = json.decode(response.body);
      emit(LoginError(message: respJson["message"]));
    }

  }



}