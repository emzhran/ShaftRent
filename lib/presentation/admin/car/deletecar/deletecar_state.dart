sealed class DeleteCarState {}

class DeleteCarInitial extends DeleteCarState {}

class DeleteCarLoading extends DeleteCarState {}

class DeleteCarSuccess extends DeleteCarState {}

class DeleteCarError extends DeleteCarState {
  final String message;

  DeleteCarError({required this.message});
}
