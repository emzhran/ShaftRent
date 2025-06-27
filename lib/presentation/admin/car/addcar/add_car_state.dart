import 'package:shaft_rent_app/data/model/response/get_all_car_response_model.dart';

sealed class AddCarState {}

final class AddCarInitial extends AddCarState {}

final class AddCarLoading extends AddCarState {}

final class AddCarSuccess extends AddCarState {
  final Car car;

  AddCarSuccess({required this.car});
}

final class AddCarLoaded extends AddCarState {
  final GetAllCarModel cars;

  AddCarLoaded({required this.cars});
}

final class AddCarError extends AddCarState {
  final String message;

  AddCarError({required this.message});
}
