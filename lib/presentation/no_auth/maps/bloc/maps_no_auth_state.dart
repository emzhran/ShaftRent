import 'package:shaftrent/data/model/response/maps_response_model.dart';

sealed class MapsNoAuthState {}

final class MapsNoAuthInitial extends MapsNoAuthState {}

final class MapsNoAuthLoading extends MapsNoAuthState {}

final class MapsNoAuthLoaded extends MapsNoAuthState {
  final List<Maps> locations;

  MapsNoAuthLoaded({required this.locations});
}

final class MapsNoAuthFailure extends MapsNoAuthState {
  final String message;

  MapsNoAuthFailure({required this.message});
}
