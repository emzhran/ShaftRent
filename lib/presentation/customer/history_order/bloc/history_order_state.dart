import 'package:shaftrent/data/model/response/customer/history_order_response.dart';

sealed class HistoryOrderState {}

class HistoryOrderInitial extends HistoryOrderState {}

class HistoryOrderLoading extends HistoryOrderState {}

class HistoryOrderLoaded extends HistoryOrderState {
  final List<HistoryOrder> orders;

  HistoryOrderLoaded(this.orders);
}

class HistoryOrderError extends HistoryOrderState {
  final String message;

  HistoryOrderError(this.message);
}
