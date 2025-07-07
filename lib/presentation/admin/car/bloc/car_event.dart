import 'package:shaftrent/data/model/request/admin/car_request_model.dart';

sealed class CarEvent {}

class FetchCars extends CarEvent {}

class AddCar extends CarEvent {
  final CarRequestModel requestModel;
  AddCar({required this.requestModel});
}

class UpdateCar extends CarEvent {
  final int carId;
  final CarRequestModel requestModel;
  UpdateCar({required this.carId, required this.requestModel});
}

class DeleteCar extends CarEvent {
  final int carId;
  DeleteCar({required this.carId});
}