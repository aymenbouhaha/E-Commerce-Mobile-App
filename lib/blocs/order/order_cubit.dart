import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_projet/models/order_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_projet/models/product_model.dart';

import '../../constant.dart';

part  'order_state.dart';

class OrderCubit extends Cubit<OrderState>{

  OrderCubit() : super(OrderInitState());

  makeOrder(Product product,String token) async {
    List<Order> orders=(this.state as OrderLoadedState).order;
    emit(OrderLoadingState());
    Uri uri= Uri.parse("${url}/order/create");
    var response = await http.post(
      uri,
      body: {
        "product" : productToJson(product)
      }, 
        headers: {
          "Authorization" : 'Bearer '+ token
        }
    );
    if(response.statusCode>=200 && response.statusCode<=299){
      final addedOrder = orderFromJson(response.body);
      emit(
        OrderLoadedState(
            order: List.from(orders..add(addedOrder))
      ));
    }else{
      _handlingError(response.body);
    }

  }

  getOrderList(String token) async {
    emit(OrderLoadingState());
    Uri uri= Uri.parse("${url}/order");
    var response = await http.get(
      uri,
        headers: {
          "Authorization" : 'Bearer '+ token
        }
    );
    if(response.statusCode>=200 && response.statusCode<=299){
      final decodedResp=orderListFromJson(response.body);
      emit(OrderLoadedState(order: decodedResp));
    }else{
      _handlingError(response.body);
    }
  }

  changeOrderClassState(Order order, String orderState , String token) async {
    List<Order> orders= (this.state as OrderLoadedState).order;
    emit(OrderLoadingState());
    Uri uri= Uri.parse("${url}/order/change/${order.id}");
    var response = await http.patch(
      uri,
        headers: {
          "Authorization" : 'Bearer '+ token
        },
      body: {
        "state" : orderState
      }
    );
    if(response.statusCode>=200 && response.statusCode<=299){
      final changedOrder= orderFromJson(response.body);
      List<Order> list = List.from(orders);
      int index =list.indexWhere((element) => element.id==changedOrder.id);
      list[index]=changedOrder;
      emit(OrderLoadedState(order: list));
    }else{
      _handlingError(response.body);
    }

    }

  _handlingError(dynamic response){
    var jsonResp=json.decode(response);
    emit(OrderErrorState(message: jsonResp["message"]));
  }

  
  
  
}


