sealed class DeleteCarEvent {}

class DeleteCar extends DeleteCarEvent {
  final int carId;

  DeleteCar({required this.carId});
}
