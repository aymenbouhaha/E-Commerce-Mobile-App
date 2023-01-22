part of 'favorite_list_cubit.dart';



class FavoriteListState extends Equatable{

  @override
  List<Object?> get props => [];

}


class FavoriteListInitState extends FavoriteListState{

}

class FavoriteListLoadingState extends FavoriteListState{

}

class FavoriteListLoadedState extends FavoriteListState{

  List<Product> product;

  FavoriteListLoadedState({required this.product});

  @override
  List<Object?> get props => [product];

}

class FavoriteListErrorState extends FavoriteListState{
  String message ;

  FavoriteListErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}