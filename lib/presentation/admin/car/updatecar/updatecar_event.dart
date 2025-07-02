import 'package:shaft_rent/data/model/request/admin/car_request_model.dart';

sealed class UpdateCarEvent {}

class UpdateCar extends UpdateCarEvent {
  final int carId;
  final CarRequestModel requestModel;

  UpdateCar({required this.carId, required this.requestModel});
}
