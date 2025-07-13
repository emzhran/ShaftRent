sealed class MapsCustomerEvent {}

class GetMaps extends MapsCustomerEvent {}

class GetMapById extends MapsCustomerEvent {
  final int id;
  GetMapById(this.id);
}
