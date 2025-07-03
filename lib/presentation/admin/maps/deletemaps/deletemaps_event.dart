sealed class DeleteMapsEvent {}

class DeleteMaps extends DeleteMapsEvent {
  final int mapId;

  DeleteMaps({required this.mapId});
}
