import 'package:shaftrent/data/model/request/customer/profile_request_model.dart';

sealed class ProfileEvent {}

class FetchProfile extends ProfileEvent {}

class AddProfile extends ProfileEvent {
  final int customerId;
  final ProfileRequestModel requestModel;
  AddProfile({required this.requestModel, required this.customerId});
}
