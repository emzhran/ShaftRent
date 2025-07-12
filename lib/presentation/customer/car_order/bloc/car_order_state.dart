import 'package:shaftrent/data/model/response/car_response_model.dart';
import 'package:shaftrent/data/model/response/customer/order_car_response_model.dart';

sealed class CarOrderState {}

class CarOrderInitial extends CarOrderState {}

class CarOrderLoading extends CarOrderState {}

class CarOrderLoadSuccess extends CarOrderState {
  final List<Car> cars;
  final List<Car> filteredCars; 

  CarOrderLoadSuccess({
    required this.cars,
    required this.filteredCars,
  });
}


class CarOrderSuccess extends CarOrderState {
  final String message;
  final CarOrder order;

  CarOrderSuccess({required this.message, required this.order});
}

class CarOrderError extends CarOrderState {
  final String error;

  CarOrderError({required this.error});
}
