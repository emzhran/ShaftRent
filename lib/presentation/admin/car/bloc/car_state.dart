import 'package:shaftrent/data/model/response/car_response_model.dart';

sealed class CarState {}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarListLoaded extends CarState {
  final CarResponseModel cars;
  CarListLoaded({required this.cars});
}

class CarAdded extends CarState {
  final Car car;
  CarAdded({required this.car});
}

class CarUpdated extends CarState {}

class CarDeleted extends CarState {}

class CarError extends CarState {
  final String message;
  CarError({required this.message});
}