import 'package:shaft_rent/data/model/response/maps_response_model.dart';

sealed class GetMapsState {}

final class GetMapsInitial extends GetMapsState {}

final class GetMapsLoading extends GetMapsState {}

final class GetMapsLoaded extends GetMapsState {
  final List<Maps> maps;

  GetMapsLoaded({required this.maps});
}

final class GetMapsError extends GetMapsState {
  final String message;

  GetMapsError({required this.message});
}
