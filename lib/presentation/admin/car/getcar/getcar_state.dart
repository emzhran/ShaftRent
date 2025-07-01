import 'package:shaft_rent/data/model/response/car_response_model.dart';

sealed class GetCarState {}

final class GetCarInitial extends GetCarState {}

final class GetCarLoading extends GetCarState {}

final class GetCarLoaded extends GetCarState {
  final CarResponseModel cars;

  GetCarLoaded({required this.cars});
}

final class GetCarError extends GetCarState {
  final String message;

  GetCarError({required this.message});
}
