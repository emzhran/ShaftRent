import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/data/repository/car_order_repository.dart';
import 'package:shaft_rent/presentation/customer/car/order_car/ordercar_event.dart';
import 'package:shaft_rent/presentation/customer/car/order_car/ordercar_state.dart';

class OrdercarBloc extends Bloc<OrdercarEvent, OrdercarState> {
  final CarOrderRepository carOrderRepository;

  OrdercarBloc({required this.carOrderRepository}) : super(OrderCarInitial()) {
    on<AddCarOrder>(_onAddCarOrder);
  }

  Future<void> _onAddCarOrder(
    AddCarOrder event,
    Emitter<OrdercarState> emit,
  ) async {
    emit(OrderCarLoading());

    final result = await carOrderRepository.orderCar(event.request);

    result.fold(
      (error) => emit(OrderCarError(message: error)),
      (response) => emit(OrderCarSuccess(order: response.data)),
    );
  }
}
