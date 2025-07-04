import 'package:shaft_rent/data/model/response/car_response_model.dart';

sealed class GetCarCustomerState {}

class GetCarInitial extends GetCarCustomerState {}

class GetCarLoading extends GetCarCustomerState {}

class GetCarLoaded extends GetCarCustomerState {
  final CarResponseModel cars;

  GetCarLoaded({required this.cars});
}

class GetCarError extends GetCarCustomerState {
  final String message;

  GetCarError({required this.message});
}
