import 'package:shaftrent/data/model/request/admin/profile_customer_request_model.dart';

sealed class CustomerProfileEvent {}

class FetchAllCustomer extends CustomerProfileEvent {}

class FetchCustomerDetail extends CustomerProfileEvent {
  final int customerId;
  FetchCustomerDetail({required this.customerId});
}

class SubmitUpdateStatus extends CustomerProfileEvent {
  final StatusAccountRequestModel requestModel;
  SubmitUpdateStatus({required this.requestModel});
}
