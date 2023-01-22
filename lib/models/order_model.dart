import 'package:mini_projet/models/product_model.dart';
import 'package:mini_projet/models/user_model.dart';

import 'dart:convert';

List<Order> orderListFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));
Order orderFromJson(String str) => Order.fromJson(json.decode(str));
String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    required this.id,
    required this.state,
    required this.product,
    required this.client,
  });

  int id;
  String state;
  Product product;
  User client;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    state: json["state"],
    product: Product.fromJson(json["product"]),
    client: User.fromJson(json["client"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state": state,
    "product": product.toJson(),
    "client": client.toJson(),
  };

}

enum OrderClassState {
  accepted ,
  refused ,
  enCours
}




