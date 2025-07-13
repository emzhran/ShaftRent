import 'package:shaftrent/data/model/response/customer/history_order_response.dart';

sealed class HistoryOrderState {}

class HistoryOrderInitial extends HistoryOrderState {}

class HistoryOrderLoading extends HistoryOrderState {}

class RatingSubmitting extends HistoryOrderState {}

class HistoryOrderLoaded extends HistoryOrderState {
  final List<HistoryOrder> orders;

  HistoryOrderLoaded(this.orders);
}

class RatingSuccess extends HistoryOrderState {
  final String message;

  RatingSuccess(this.message);
}

class RatingError extends HistoryOrderState {
  final String message;

  RatingError(this.message);
}


class HistoryOrderError extends HistoryOrderState {
  final String message;

  HistoryOrderError(this.message);
}
