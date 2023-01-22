import 'dart:convert';

List<Product> productListFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.id,
    required this.nom,
    required this.price,
    required this.image,
    required this.description,
  });

  int id;
  String nom;
  int price;
  String image;
  String description;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    nom: json["name"],
    price: json["price"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nom,
    "price": price,
    "image": image,
    "description": description,
  };
}