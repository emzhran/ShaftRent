import 'package:shaft_rent/data/model/request/admin/car_request_model.dart';

sealed class AddCarEvent {}

class AddCar extends AddCarEvent {
  final CarRequestModel requestModel;

  AddCar({required this.requestModel});
}
