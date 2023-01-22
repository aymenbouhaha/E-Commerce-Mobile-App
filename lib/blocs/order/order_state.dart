part of 'order_cubit.dart';


class OrderState extends Equatable {

  @override
  List<Object?> get props => [];

}

class OrderInitState extends OrderState{

}

class OrderLoadingState extends OrderState{

}

class OrderLoadedState extends OrderState{

  List<Order> order;

  OrderLoadedState({required this.order});

  @override
  List<Object?> get props => [order];

}

class OrderErrorState extends OrderState{
  String message ;

  OrderErrorState({required this.message});

  @override
  List<Object?> get props => [message];

}
