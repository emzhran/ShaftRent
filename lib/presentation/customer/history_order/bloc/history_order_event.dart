sealed class HistoryOrderEvent {}

class GetHistoryOrders extends HistoryOrderEvent {}

class SubmitOrderRating extends HistoryOrderEvent {
  final int orderId;
  final int rating;

  SubmitOrderRating({required this.orderId, required this.rating});
}
