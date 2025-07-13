import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/model/request/admin/status_order_request_model.dart';
import 'package:shaftrent/data/repository/order_car_repository.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_event.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_state.dart';

class OrderCarByCustomerBloc extends Bloc<OrderCarByCustomerEvent, OrderCarByCustomerState> {
  final CarOrderRepository orderRepository;

  OrderCarByCustomerBloc({required this.orderRepository}) : super(OrderCarByCustomerInitial()) {
    on<FetchAllOrdersByCustomer>(_onFetchAllOrders);
    on<UpdatePendingOrderStatus>(_onUpdateStatus);
  }

  Future<void> _onFetchAllOrders(
    FetchAllOrdersByCustomer event,
    Emitter<OrderCarByCustomerState> emit,
  ) async {
    emit(OrderCarByCustomerLoading());

    final result = await orderRepository.getAllOrdersForAdmin();

    result.fold(
      (error) => emit(OrderCarByCustomerError(message: error)),
      (orders) {
        final pending = orders.where((o) => o.statusPemesanan.toLowerCase() == 'pending').toList();
        final dikonfirmasi = orders.where((o) => o.statusPemesanan.toLowerCase() == 'dikonfirmasi').toList();
        final selesai = orders.where((o) => o.statusPemesanan.toLowerCase() == 'selesai').toList();

        emit(OrderCarByCustomerLoaded(
          pending: pending,
          dikonfirmasi: dikonfirmasi,
          selesai: selesai,
        ));
      },
    );
  }

  Future<void> _onUpdateStatus(
    UpdatePendingOrderStatus event,
    Emitter<OrderCarByCustomerState> emit,
  ) async {
    emit(OrderCarByCustomerLoading());

    final result = await orderRepository.updateOrderStatus(
      orderId: event.orderId,
      request: StatusUpdateRequest(statusPemesanan: event.newStatus),
    );

    result.fold(
      (error) => emit(OrderCarByCustomerError(message: error)),
      (response) {
        emit(OrderCarByCustomerStatusUpdated(
          message: response.message,
          updatedOrder: response,
        ));

        add(FetchAllOrdersByCustomer());
      },
    );
  }
}
