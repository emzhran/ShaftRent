import 'package:shaft_rent/data/model/request/admin/maps_request_model.dart';

sealed class UpdateMapsEvent {}

class UpdateMaps extends UpdateMapsEvent {
  final int mapId;
  final MapsRequestModel requestModel;

  UpdateMaps({required this.mapId, required this.requestModel});
}
