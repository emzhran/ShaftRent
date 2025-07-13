sealed class OrderCarByCustomerEvent {}

class FetchAllOrdersByCustomer extends OrderCarByCustomerEvent {}

class UpdatePendingOrderStatus extends OrderCarByCustomerEvent {
  final int orderId;
  final String newStatus;

  UpdatePendingOrderStatus({
    required this.orderId,
    required this.newStatus,
  });
}
