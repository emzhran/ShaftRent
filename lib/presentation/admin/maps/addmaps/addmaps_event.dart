import 'package:shaft_rent/data/model/request/admin/maps_request_model.dart';

sealed class AddMapsEvent {}

class AddMaps extends AddMapsEvent {
  final MapsRequestModel requestModel;

  AddMaps({required this.requestModel});
}
