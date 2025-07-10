import 'package:shaftrent/data/model/response/admin/profile_customer_response_model.dart';

sealed class CustomerProfileState {}

class CustomerProfileInitial extends CustomerProfileState {}

class CustomerProfileLoading extends CustomerProfileState {}

class CustomerProfileLoaded extends CustomerProfileState {
  final List<ProfileCustomer> profile;
  CustomerProfileLoaded({required this.profile});
}

class CustomerDetailLoaded extends CustomerProfileState {
  final ProfileCustomer profile;
  CustomerDetailLoaded({required this.profile});
}

class UpdateStatusSuccess extends CustomerProfileState {}

class UpdateStatusError extends CustomerProfileState {
  final String message;
  UpdateStatusError({required this.message});
}
