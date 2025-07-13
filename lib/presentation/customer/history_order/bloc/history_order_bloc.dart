import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/repository/history_order_repository.dart';
import 'package:shaftrent/presentation/customer/history_order/bloc/history_order_event.dart';
import 'package:shaftrent/presentation/customer/history_order/bloc/history_order_state.dart';

class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  final HistoryOrderRepository historyOrderRepository;

  HistoryOrderBloc({required this.historyOrderRepository})
    : super(HistoryOrderInitial()) {
    on<GetHistoryOrders>((event, emit) async {
      emit(HistoryOrderLoading());

      final result = await historyOrderRepository.getHistoryOrders();
      result.fold(
        (failure) => emit(HistoryOrderError(failure)),
        (orders) => emit(HistoryOrderLoaded(orders)),
      );
    });
  }
}
