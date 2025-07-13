import 'package:shaftrent/data/model/response/car_response_model.dart';

sealed class CarNoAuthState {}

final class CarNoAuthInitial extends CarNoAuthState {}

final class CarNoAuthLoading extends CarNoAuthState {}

final class CarNoAuthLoaded extends CarNoAuthState {
  final List<Car> cars;

  CarNoAuthLoaded({required this.cars});
}

final class CarNoAuthFailure extends CarNoAuthState {
  final String message;

  CarNoAuthFailure({required this.message});
}
