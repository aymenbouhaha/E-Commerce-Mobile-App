part of 'user_cubit.dart';


class UserState extends Equatable {

  @override
  List<Object?> get props => [];


}

class UserInitState extends UserState{
  UserInitState();
}

class LoginLoadingState extends UserState{

  LoginLoadingState();

}

class UserLoggedInState extends UserState{
  User user;
  String token;
  bool isAdmin;

  UserLoggedInState({required this.user, required this.token, required this.isAdmin});

  @override
  List<Object?> get props => [user, token];

}

class LoginError extends UserState {

  String message ;

  LoginError({required this.message});


  @override
  List<Object?> get props => [message];
}



