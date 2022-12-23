
import 'package:mini_projet/models/client_model.dart';
import 'package:mini_projet/models/product_model.dart';

class Order {
  OrderState state;
  Client client;
  Product product;

  Order({ required this.state,required this.client,required this.product});


  String ConvertOrderState(){

    switch (this.state){
      case OrderState.accepted : return "Accepté" ;break;
      case OrderState.refused : return "Refusé"; break;
      case OrderState.enCours : return "En Cours"; break;
    }
  }

}

enum OrderState {
  accepted ,
  refused ,
  enCours
}