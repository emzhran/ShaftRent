sealed class UpdateMapsState {}

class UpdateMapsInitial extends UpdateMapsState {}

class UpdateMapsLoading extends UpdateMapsState {}

class UpdateMapsSuccess extends UpdateMapsState {}

class UpdateMapsError extends UpdateMapsState {
  final String message;
  UpdateMapsError({required this.message});
}
