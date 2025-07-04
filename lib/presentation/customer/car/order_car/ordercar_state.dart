import 'package:shaft_rent/data/model/response/customer/car_order_response_model.dart';

sealed class OrdercarState {}

class OrderCarInitial extends OrdercarState {}

class OrderCarLoading extends OrdercarState {}

class OrderCarSuccess extends OrdercarState {
  final CarOrder order;

  OrderCarSuccess({required this.order});
}

class OrderCarError extends OrdercarState {
  final String message;

  OrderCarError({required this.message});
}
