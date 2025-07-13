import 'package:shaftrent/data/model/response/maps_response_model.dart';

sealed class MapsCustomerState {}

class MapsInitial extends MapsCustomerState {}

class MapsLoading extends MapsCustomerState {}

class MapsLoaded extends MapsCustomerState {
  final List<Maps> maps;
  MapsLoaded(this.maps);
}

class MapByIdLoaded extends MapsCustomerState {
  final Maps map;
  MapByIdLoaded(this.map);
}

class MapsError extends MapsCustomerState {
  final String message;
  MapsError(this.message);
}
