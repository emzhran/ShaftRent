sealed class DeleteMapsState {}

class DeleteMapsInitial extends DeleteMapsState {}

class DeleteMapsLoading extends DeleteMapsState {}

class DeleteMapsSuccess extends DeleteMapsState {}

class DeleteMapsError extends DeleteMapsState {
  final String message;

  DeleteMapsError({required this.message});
}
