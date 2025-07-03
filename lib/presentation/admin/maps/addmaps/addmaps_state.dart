import 'package:shaft_rent/data/model/response/maps_response_model.dart';

sealed class AddMapsState {}

final class AddMapsInitial extends AddMapsState {}

final class AddMapsLoading extends AddMapsState {}

final class AddMapsSuccess extends AddMapsState {
  final Maps map;

  AddMapsSuccess({required this.map});
}

final class AddMapsError extends AddMapsState {
  final String message;

  AddMapsError({required this.message});
}