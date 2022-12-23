import 'package:mini_projet/models/product_model.dart';

class FavouriteProduct extends Product {
  FavouriteProduct({required String nom, required double price, required String imageSrc}) : super(nom: nom, price: price, imageSrc: imageSrc);

  // FavouriteProduct(int id, String nom, String description, double price, String imageSrc) : super(id, nom, description, price, imageSrc);

}