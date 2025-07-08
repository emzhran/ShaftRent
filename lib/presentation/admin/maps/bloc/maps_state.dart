import 'package:shaftrent/data/model/response/maps_response_model.dart';

sealed class MapsState {}

class MapsInitial extends MapsState {}

class MapsLoading extends MapsState {}

class MapsLoaded extends MapsState {
  final List<Maps> maps;
  MapsLoaded({required this.maps});
}

class MapAdded extends MapsState {
  final Maps map;
  MapAdded({required this.map});
}

class MapUpdated extends MapsState {}

class MapDeleted extends MapsState {}

class MapsError extends MapsState {
  final String message;
  MapsError({required this.message});
}
