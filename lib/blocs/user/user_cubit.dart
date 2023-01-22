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
    Uri uri = Uri.parse("https://c027-197-29-17-255.eu.ngrok.io/user/login");
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
      User user=User.fromJson(userInfo);
      bool isAdmin=user.role == "admin" ? true : false;
      emit(UserLoggedInState(user: user, token: respJson["token"],isAdmin: isAdmin));

    }else {
      final respJson = json.decode(response.body);
      emit(LoginError(message: respJson["message"]));
    }

  }



}