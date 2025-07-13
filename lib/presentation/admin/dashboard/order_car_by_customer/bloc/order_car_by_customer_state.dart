import 'package:shaftrent/data/model/response/admin/status_order_update.dart';

sealed class OrderCarByCustomerState {}

class OrderCarByCustomerInitial extends OrderCarByCustomerState {}

class OrderCarByCustomerLoading extends OrderCarByCustomerState {}

class OrderCarByCustomerLoaded extends OrderCarByCustomerState {
  final List<CarOrderAdmin> pending;
  final List<CarOrderAdmin> dikonfirmasi;
  final List<CarOrderAdmin> selesai;

  OrderCarByCustomerLoaded({
    required this.pending,
    required this.dikonfirmasi,
    required this.selesai,
  });
}

class OrderCarByCustomerStatusUpdated extends OrderCarByCustomerState {
  final String message;
  final StatusOrderUpdate updatedOrder;

  OrderCarByCustomerStatusUpdated({
    required this.message,
    required this.updatedOrder,
  });
}

class OrderCarByCustomerError extends OrderCarByCustomerState {
  final String message;

  OrderCarByCustomerError({required this.message});
}
