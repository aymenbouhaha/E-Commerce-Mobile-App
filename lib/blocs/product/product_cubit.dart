import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_projet/models/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'product_state.dart';


class ProductCubit extends Cubit<ProductState>{
  final String token;

  ProductCubit(this.token) : super(ProductInitState());


  getProduct()async{
    emit(ProductLoadingState());
    Uri uri=Uri.parse("lalal");
    var response = await http.get(uri , headers: {
      "Authorization" : 'Bearer '+ token
    });
    if (response.statusCode>=200 && response.statusCode<=299){
      List<dynamic> productRespo= json.decode(response.body);
      List<Product> productList = [];
      productRespo.forEach((element) {
        productList.add(Product(
          id: element["id"],
          nom: element["name"],
          price: element["price"],
          imageSrc: element["image"],
          description: element["description"]
        ));
      });
      emit(ProductLoadedState(products: productList));
    }else {
      _handlingError(response.body);
    }
  }

  addProduct(Product product)async{
    Uri uri=Uri.parse("lalal");
    var response = await http.post(
      uri,
        headers: {
          "Authorization" : 'Bearer '+ token
        },
      body: {
        "name": product.nom,
        "price": product.price,
        "description" : product.description,
        "image" : product.imageSrc
      }
    );
    if(response.statusCode>=200 && response.statusCode<=299){
      emit(
          ProductLoadedState(
              products: List.from((this.state as ProductLoadedState).products)..add(product)
          )
      );
    }else{
      _handlingError(response.body);
    }


  }

  removeProduct(Product product)async{
    Uri uri=Uri.parse("lalal");
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