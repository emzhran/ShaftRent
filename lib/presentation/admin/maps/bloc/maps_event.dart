import 'package:shaftrent/data/model/request/admin/maps_request_model.dart';

sealed class MapsEvent {}

class FetchMaps extends MapsEvent {}

class AddMap extends MapsEvent {
  final MapsRequestModel requestModel;
  AddMap({required this.requestModel});
}

class UpdateMap extends MapsEvent {
  final int mapId;
  final MapsRequestModel requestModel;
  UpdateMap({required this.mapId, required this.requestModel});
}

class DeleteMap extends MapsEvent {
  final int mapId;
  DeleteMap({required this.mapId});
}
