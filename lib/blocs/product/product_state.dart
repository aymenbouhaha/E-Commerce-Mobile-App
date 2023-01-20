

part of 'product_cubit.dart';

class ProductState extends Equatable {


  @override
  List<Object?> get props => [];

}


class ProductInitState extends ProductState{


}


class ProductLoadingState extends ProductState{


}


class ProductLoadedState extends ProductState{

  List<Product> products;

  @override
  List<Object?> get props => [products];

  ProductLoadedState({required this.products});
}


class ProductError extends ProductState {

  String message ;

  ProductError({required this.message});

  @override
  List<Object?> get props => [message];

}






