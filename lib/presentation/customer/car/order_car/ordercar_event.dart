import 'package:shaft_rent/data/model/request/customer/order_car_request.dart';

sealed class OrdercarEvent {}

class AddCarOrder extends OrdercarEvent {
  final OrderCarRequest request;

  AddCarOrder({required this.request});
}
