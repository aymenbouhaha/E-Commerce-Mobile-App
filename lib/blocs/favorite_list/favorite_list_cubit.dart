import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_projet/constant.dart';
import 'package:mini_projet/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'favorite_list_state.dart';

class FavoriteListCubit extends Cubit<FavoriteListState>{
  FavoriteListCubit() : super(FavoriteListInitState());


  getFavoriteList(String token) async {
    emit(FavoriteListLoadingState());
    Uri uri = Uri.parse("${url}/user/favorite");
    var response = await http.get(
      uri,
      headers: {
        "Authorization" : 'Bearer '+ token
      }
    );
    if (response.statusCode>=200 && response.statusCode<=299){
      List<Product> favoriteList = productListFromJson(response.body);
      emit(FavoriteListLoadedState(product: favoriteList));
    }else{
      _handlingError(response.body);
    }

    }


    addProductToFavoriteList(String token, Product product) async{
      List<Product> products=(this.state as FavoriteListLoadedState).product;
      emit(FavoriteListLoadingState());
      Uri uri = Uri.parse("${url}/user/favorite/add/${product.id}");
      var response = await http.patch(
        uri,
          headers: {
            "Authorization" : 'Bearer '+ token
          },
      );
      if (response.statusCode>=200 && response.statusCode<=299){
        emit(
          FavoriteListLoadedState(
              product: List.from(products..add(product))
        ));
      }else{
        _handlingError(response.body);
      }

    }


  _handlingError(dynamic response){
    var jsonResp=json.decode(response);
    emit(FavoriteListErrorState(message: jsonResp["message"]));
  }


}