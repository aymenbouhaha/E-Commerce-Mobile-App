import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_projet/models/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';

part 'product_state.dart';


class ProductCubit extends Cubit<ProductState>{

  ProductCubit() : super(ProductInitState());


  getProduct(String token)async{
    emit(ProductLoadingState());
    Uri uri=Uri.parse("https://c027-197-29-17-255.eu.ngrok.io/product");
    var response = await http.get(uri , headers: {
      "Authorization" : 'Bearer '+ token
    });
    if (response.statusCode>=200 && response.statusCode<=299){
      List<Product> productList = productListFromJson(response.body);
      emit(ProductLoadedState(products:  productList ));
    }else {
      _handlingError(response.body);
    }
  }

  addProduct(Product product , String token)async{
    Uri uri=Uri.parse("${url}/product/add");
    var response = await http.post(
      uri,
        headers: {
          "Authorization" : 'Bearer '+ token
        },
      body: {
        "name": product.nom,
        "price": product.price,
        "description" : product.description,
        "image" : product.image
      }
    );
    if(response.statusCode>=200 && response.statusCode<=299){
      Product addedProduct = productFromJson(response.body);
      emit(
          ProductLoadedState(
              products: List.from((this.state as ProductLoadedState).products)..add(addedProduct)
          )
      );
    }else{
      _handlingError(response.body);
    }


  }

  removeProduct(Product product , String token)async{
    Uri uri=Uri.parse("${url}/product/${product.id}");
    var response = await http.delete(
      uri,
      headers: {
          "Authorization" : 'Bearer '+ token
      },
    );
    if (response.statusCode>=200 && response.statusCode<=299){
      emit(
        ProductLoadedState(
            products: List.from((this.state as ProductLoadedState).products)..remove(product)
        )
      );
    }else{
      _handlingError(response.body);
    }

  }


  _handlingError(dynamic response){
    var jsonResp=json.decode(response);
    emit(ProductError(message: jsonResp["message"]));
  }




}