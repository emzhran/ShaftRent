import 'package:shaftrent/data/model/request/customer/order_car_request_model.dart';

sealed class CarOrderEvent {}

class FetchCarsCustomer extends CarOrderEvent {}

class ResetSearchCustomer extends CarOrderEvent {}

class SearchCarsCustomer extends CarOrderEvent {
  final String keyword;

  SearchCarsCustomer({required this.keyword});
}

class FilterCarsCustomer extends CarOrderEvent {
  final String? transmisi;
  final String? sortByHarga;

  FilterCarsCustomer({this.transmisi, this.sortByHarga});
}



class OrderCarSubmitted extends CarOrderEvent {
  final OrderCarRequestModel request;

  OrderCarSubmitted({required this.request});
}
