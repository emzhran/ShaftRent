sealed class UpdateCarState {}

class UpdateCarInitial extends UpdateCarState {}

class UpdateCarLoaded extends UpdateCarState {}

class UpdateCarSuccess extends UpdateCarState {}

class UpdateCarError extends UpdateCarState {
  final String message;
  UpdateCarError({required this.message});
}
